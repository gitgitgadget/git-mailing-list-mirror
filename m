From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: git-gui: Warn when username and e-mail address is unconfigured?
Date: Thu, 4 Dec 2008 20:04:34 +0100
Message-ID: <bd6139dc0812041104s26ae149foeafa489e65aeb584@mail.gmail.com>
References: <Pine.LNX.4.64.0812041141160.9969@ds9.cixit.se>
	 <b9fd99020812040805j1143c029yf0cc4c1c4a835759@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Peter Krefting" <peter@softwolves.pp.se>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jeremy Ramer" <jdramer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 20:06:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8JWV-00054C-7B
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 20:06:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756406AbYLDTEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 14:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756795AbYLDTEl
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 14:04:41 -0500
Received: from mail-gx0-f18.google.com ([209.85.217.18]:58937 "EHLO
	mail-gx0-f18.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755554AbYLDTEk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 14:04:40 -0500
Received: by gxk11 with SMTP id 11so1613952gxk.13
        for <git@vger.kernel.org>; Thu, 04 Dec 2008 11:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=vnBKNEScX/Rapl6vSe9aXMcspi8jrQ59YskmWFFmnas=;
        b=RWNOLoP2Xk8GNmEC9sGQZ/mhxkeKP/031Wxvn6MPN4Nb+LtGBWdFQ8Ldruuzayv/Qz
         cvMq5SQbFIW3oyQNCo5VO57enL4gmPhmBHSDp4rQGVvryBsjzCgDE9BcsuXofh1VCQvd
         wX8a+7eBnY8JOFkVL6q56VFOh6WS6q/Z6nk6k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=yChQGlIy5UDm3GTT39rVNFwQfWnj53InkAuyBKVgr0rlhwImJei4La9y5InEGJZt4l
         rJXZ/hfol4qWpz87/4RF01wse6mD1AXrIoa8AmzT/GlpXXSCc9RlXD7s6siZB6P+UzyO
         fzv1j6+mx4x9S+jFruJg0FU1iYCqd6miSBP+8=
Received: by 10.151.46.17 with SMTP id y17mr82689ybj.91.1228417474837;
        Thu, 04 Dec 2008 11:04:34 -0800 (PST)
Received: by 10.151.108.18 with HTTP; Thu, 4 Dec 2008 11:04:34 -0800 (PST)
In-Reply-To: <b9fd99020812040805j1143c029yf0cc4c1c4a835759@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102357>

On Thu, Dec 4, 2008 at 17:05, Jeremy Ramer <jdramer@gmail.com> wrote:
> That's strange. I am using git 1.6.0.4 on cygwin and I get a warning
> message every time I start git gui.  I actually find this really
> annoying and would like a way to turn this warning message off.

git config --global user.name "Your Name"
git config --global user.email "you@example.com"

-- 
Cheers,

Sverre Rabbelier
