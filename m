From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: Re: Weird behaviour of git status
Date: Fri, 16 Jan 2009 14:17:20 +0100
Message-ID: <bd6139dc0901160517ra26d69bw661816faaa91b339@mail.gmail.com>
References: <4970488B.3010608@morey-chaisemartin.com>
	 <2A29AD77-2B8D-4491-92C1-62F5FFFBB00F@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: devel@morey-chaisemartin.com,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Wincent Colaiuta" <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Jan 16 14:18:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNob3-0008Aj-Nj
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 14:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934025AbZAPNRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 08:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933637AbZAPNRX
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 08:17:23 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:7031 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933086AbZAPNRV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 08:17:21 -0500
Received: by yx-out-2324.google.com with SMTP id 8so678327yxm.1
        for <git@vger.kernel.org>; Fri, 16 Jan 2009 05:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=R1wgUx477rAOhmaC3mxG0Gz+sh5KKsc7SufcrFzEOfQ=;
        b=T/VsXYAUXXD+hHtTxVhmPyoiSEkF3Y3jO/Eo0otrZdV0LVVQzl54nptShpbd1Ei+Sq
         QUmxoFqd/dNydB2EyaoXr47bvu05LNpu9Kg9HlDX31KHjJIpoTaoMSG30/P4zBrf5wDt
         RYSBBAZKQ4ViBdtrtzYiZjkmochZJpE/YHqxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=ZdXni54KTEJRsN9LSN0Li/teBVPOw4GMM3m5y5IKp96Tn0+RrVX4nGIVYK7+TMjt7E
         Fldnt7h/XMnLSnjUg4jXmiFNXn34YxKB6qmOaluvFdGHrBRepnpktUO3EnwDGH9rpP2L
         Uop8zUWUh4kfZGmS/ugyDxLQiS4iP0Shahjpc=
Received: by 10.151.150.13 with SMTP id c13mr6088163ybo.136.1232111840133;
        Fri, 16 Jan 2009 05:17:20 -0800 (PST)
Received: by 10.150.121.4 with HTTP; Fri, 16 Jan 2009 05:17:20 -0800 (PST)
In-Reply-To: <2A29AD77-2B8D-4491-92C1-62F5FFFBB00F@wincent.com>
Content-Disposition: inline
X-Google-Sender-Auth: 8fde31d527e6e07e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105955>

On Fri, Jan 16, 2009 at 10:44, Wincent Colaiuta <win@wincent.com> wrote:
> "git status" shows you what would be committed if you ran "git commit" with
> the same parameters. So in your example, the output for "git status ." is
> exactly as you would expect.
>
> This is stated in the man page.

This is one of the first things I stumbled on when I started using
git. I often times wanted to do "git status -- pathspec" to see only
what changed in a certain directory, rather than what would be
committed if only the contents of that directory is committed.

-- 
Cheers,

Sverre Rabbelier
