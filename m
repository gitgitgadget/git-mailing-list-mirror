From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] doc: format-patch: don't use origin as a branch name
Date: Fri, 1 Aug 2014 12:36:14 -0700
Message-ID: <20140801193614.GR12427@google.com>
References: <1406920826-4680-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Aug 01 21:36:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDId5-000584-BE
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 21:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbaHATg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2014 15:36:27 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:55502 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755853AbaHATgR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2014 15:36:17 -0400
Received: by mail-pa0-f43.google.com with SMTP id lf10so6334871pab.16
        for <git@vger.kernel.org>; Fri, 01 Aug 2014 12:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=BvimlSSXfsnQJKacfqu/f1N6qVIufcPF1yDX9FeNOf8=;
        b=sLKgT4yPZDsYPA1uAsFqb5sDZsLuL78tQo32m1ggCZsw6C2m4MkhvRkRmoGSpMUW9H
         NbCmH8NoOpX7INj0jgnLRaCgrkoaVNciXTa2+LIFu7IIONgzKCWoIORpot4scyB9W8Jm
         sKTaiX/5ZPdTO/MDxd1NhmgEa/x/amZNg6fa8wW6kckv1z22v853mRRzOPrsBN3AE1Cp
         aQ8zjKeqAPVEP+tbnwoV2QR7TrboEvOuXK1rUo76+xawO1rz+YmvuM3fJ2LnqFv/KfUn
         f065awXerde1h3+yBg5kOAR2Fp32f+z523vg3zQHsmGkf8I/eXduJvlKDI6c+v1UyhxC
         x4BQ==
X-Received: by 10.66.232.166 with SMTP id tp6mr8601603pac.127.1406921777090;
        Fri, 01 Aug 2014 12:36:17 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:303c:6b98:896:51f2])
        by mx.google.com with ESMTPSA id vz7sm5939773pbc.95.2014.08.01.12.36.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 01 Aug 2014 12:36:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1406920826-4680-1-git-send-email-philipoakley@iee.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254654>

Philip Oakley wrote:

> Historically (5 Nov 2005 v0.99.9-46-g28ffb89) the git-format-patch used
> 'origin' as the upstream branch name. This is now used to name the remote.
> Use the more modern 'master' as the branch name.

Would 'origin/master' make sense?

Thanks,
Jonathan
