From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] parse-options: Add support for dumping out long options
Date: Wed, 11 Apr 2012 13:51:43 +0300
Message-ID: <CAMP44s37wm2G0vSmtND83ghrjHHfbyCbsKEoaUew-YxE73T=6A@mail.gmail.com>
References: <1334140165-24958-1-git-send-email-bebarino@gmail.com>
	<1334140165-24958-2-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, spearce@spearce.org, szeder@ira.uka.de,
	jrnieder@gmail.com
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 12:51:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHv9S-0000H1-7d
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 12:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755385Ab2DKKvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 06:51:45 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:41872 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754467Ab2DKKvo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 06:51:44 -0400
Received: by eaaq12 with SMTP id q12so172025eaa.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 03:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zfszxK0wldXTIEdOOr8KO0K4a3JEECtE7fFHw7eyIQU=;
        b=WZVp2Bcx7lJYA9+RkIXq3scf/vKw2Wwj8l+DRXqKztAnEgmcMZPr0xv/AA03uKT1o4
         sgwcaPhlZ09kRpfomnGqUoX4bAkp7rR4kG3s0epc4prKO5k1qMohoXWAfHYX1hHqt/xF
         aIY8swIfrMGa8OhrLzo+KbyxpIoc5hHi3DU3EVO34E+J+vEmeq45LC2o9dmZUkfyHq56
         x3iXUpzdncKeDNfT1IOWva2uR7AC5vUp4PehEodkKZmuJbWcC66h1yn85imHVyWxneUR
         NQ51z07+NJ5p/rQVBJ82Jy1v3SWLbX7EsTgjewZ2Q78xvEQDfbnYG7LsQiRUs6FZnYHc
         eoqA==
Received: by 10.213.35.196 with SMTP id q4mr940059ebd.29.1334141503317; Wed,
 11 Apr 2012 03:51:43 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Wed, 11 Apr 2012 03:51:43 -0700 (PDT)
In-Reply-To: <1334140165-24958-2-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195162>

On Wed, Apr 11, 2012 at 1:29 PM, Stephen Boyd <bebarino@gmail.com> wrote:
> The bash completion script wants to know what the long options are for a
> certain command at runtime. Add a magical long option that nobody could
> possibly ever use (--dump-raw-long-options) to get this information.

I thought about doing this, but I would like more than just dumping
the options. In zsh one can show more than just the options; each
option can have a description.

I was thinking on something like 'git help --raw'. We also need
something like that to list all the plumbing commands, and options for
certain options, like merge strategies, and so on. Perhaps it would
even make sense to have a new 'git raw-help' command.

Cheers.

-- 
Felipe Contreras
