From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v3 0/5] commit: support commit.verbose and --no-verbose
Date: Mon, 26 May 2014 15:34:20 -0700
Message-ID: <20140526223420.GB20637@hudson.localdomain>
References: <20140525062427.GA94219@sirius.att.net>
 <1401130586-93105-1-git-send-email-caleb@calebthompson.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Caleb Thompson <cjaysson@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 00:34:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wp3TS-00033B-3P
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 00:34:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbaEZWe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 18:34:26 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:41944 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266AbaEZWeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 18:34:25 -0400
Received: by mail-pb0-f50.google.com with SMTP id ma3so8260760pbc.9
        for <git@vger.kernel.org>; Mon, 26 May 2014 15:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=T9VOwbBhKh7WFDBapgenBA7xXdlyMmdtwB2Z5zvU4Ws=;
        b=pde29O1LeluYU4FYeojEx+A+EKe6OO+4QgEIqwZ1PG52cUc0spxJEfJCGoLarJcdsE
         Gsv2CKsk7Jjiqs9KfAPfe4TR1hFGSiZfK8jcnCMIotl483YVQzBH2CPtfsEEi/GVpJX/
         TOwhRY7bf9DHE6Ob84CfMsBBVIGPwRq7jJGM6hX9di5j3hgWZJk6u12FvsWncUjrQfcD
         c6NlbHbgL9A0WQUjVIWrRnOoNRaim1wmhF1L9M6D7gUp2ia+B1CviQ0Uj3BIUT9gHQBX
         BAHNVcpcNXUq+dFDAKxGDaN6MfKryU2wN6UHUpL1LWl0hHWNanLOYjetjFJySrJ2eWUv
         SBQw==
X-Received: by 10.66.132.70 with SMTP id os6mr31274526pab.110.1401143665261;
        Mon, 26 May 2014 15:34:25 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id vm3sm19932363pbc.45.2014.05.26.15.34.22
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 May 2014 15:34:24 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 26 May 2014 15:34:20 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Caleb Thompson <cjaysson@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1401130586-93105-1-git-send-email-caleb@calebthompson.io>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250131>

Caleb,

On Mon, May 26, 2014 at 01:56:21PM -0500, Caleb Thompson wrote:
> This patch allows people to set commit.verbose to implicitly send
> --verbose to git-commit. It also introduces --no-verbose to
> override the configuration setting.
> 
> This version incorporates changes suggested by Eric Sunshine, Duy
> Nguyen, and Jeremiah Mahler.
> 
...
> 

Other than the minor style issue I pointed out in another email, it looks
good, and the patch set works properly on my machine.

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
