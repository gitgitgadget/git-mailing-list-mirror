From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 09/13] transport-helper: Use capname for gitdir
 capability too
Date: Sun, 29 Aug 2010 20:05:27 -0500
Message-ID: <20100830010527.GA2305@burratino>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
 <1283053540-27042-10-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 03:07:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpsqG-0003A4-KO
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 03:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187Ab0H3BHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 21:07:14 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:38300 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127Ab0H3BHM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 21:07:12 -0400
Received: by gwj17 with SMTP id 17so1811384gwj.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 18:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=aufFiyEMy6mYz6ILDig9jSl+goYaVOodxxwZfLeIhkc=;
        b=ldfCNjZsQbMcNtLO1+uxqF1OlTeClz6OsCGIvRvrvpFT2ySN9O4Bzn29ybiKUVwFUc
         bqdKIeGsVjReyc4fNTTOY+iXxaD3Xomx1vSqh/KiR++l2Bad426/tFZvFLwO/s8Fp37b
         0+7gIERLO2XTHu6VjN5S25WCRQk+cjXi27+C4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=io1X5pfyuQqgw11C04uquF/Q2Om68UktrXanoD/xeyPxNF8C7PdsWZNLgsZNc7Y35Y
         1BS6brxECkR2Du3P96UW3vZnaFUCV9GdGu909sMDZ+Toyc3hmCQVtqPQyR/T79OXuoDT
         yhjNiOmHPreuhHZt7mZDB8dtadUT801K6H/BE=
Received: by 10.151.92.3 with SMTP id u3mr4530138ybl.209.1283130432142;
        Sun, 29 Aug 2010 18:07:12 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id x3sm2057069ybl.22.2010.08.29.18.07.10
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 29 Aug 2010 18:07:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1283053540-27042-10-git-send-email-srabbelier@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154738>

Sverre Rabbelier wrote:

>   The first hunk was real silly and I should have caught it while
>   reviewing the patch that introduced the required capabilities.
> 
>   I suspect the reason the second hunk wasn't caught is because the
>   series that added 'gitdir' as capability, and the one that added
>   required capabilities were done in parallel.

Obviously good, and it looks to me like you caught all problems
of this kind.
