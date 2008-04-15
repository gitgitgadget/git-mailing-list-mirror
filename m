From: "Russ Dill" <russ.dill@gmail.com>
Subject: Re: branch description
Date: Tue, 15 Apr 2008 10:31:06 -0700
Message-ID: <f9d2a5e10804151031o1d09c1f9od0ad78dcf9b746c5@mail.gmail.com>
References: <9b3e2dc20804150951scf8b3c7x26f3a56eab1f9840@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Stephen Sinclair" <radarsat1@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 19:51:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jlp0c-000401-59
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 19:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868AbYDORbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 13:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753692AbYDORbI
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 13:31:08 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:49514 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbYDORbH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 13:31:07 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1061106ywb.1
        for <git@vger.kernel.org>; Tue, 15 Apr 2008 10:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=MiaVdMpaG2ZbjQot2vIA+WCQ83wv4YgjhbyNb3l0GZ0=;
        b=x9KEqJep2K/H6PlZhQttKgtZmj26aqoPf64f0bpWh6ahWSLu6EJxAanCD+7zCVSEMBHM4fMuqATwigt3DctQOQph1elWb5xiwaP6NVMprPNcomiwGD1lntwYXwOHQWE+JFXInyTL6ROj4/luTJ7xsY9/HoP+nIvePyG6wJMErxE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DyWKs93TbMH/C4mGsidWE29y88JwjsCL2+UmBB1fZkurrAiroNdduJ2cldiZ1ptkZzDGgcbyY7LxDbjBwvroDGSV10I4+/BRaYJBzeP9iadTj/Q7nXoPxRn0/Qgbb8rxCPUbEaxDjVvyBVBu4s/i3zSEWYfmAF1OZkaiIA2p7EY=
Received: by 10.150.12.5 with SMTP id 5mr8144681ybl.39.1208280666115;
        Tue, 15 Apr 2008 10:31:06 -0700 (PDT)
Received: by 10.150.52.7 with HTTP; Tue, 15 Apr 2008 10:31:06 -0700 (PDT)
In-Reply-To: <9b3e2dc20804150951scf8b3c7x26f3a56eab1f9840@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79609>

>  I find it useful to use fairly short names for branches.  However,
>  sometimes I would like to have a full sentence to actually describe
>  what the branch is for, without having the peruse the actual commits.

Me too.

>  This information could of course be kept on a web page, but it would
>  be nice to have it in the repo.

Like, putting your bug number in the branch name.

>  Is there any such branch annotation command?
>  Ideally I'd like to see a sentence displayed next to the branch name
>  when I use "git-branch".
>  Perhaps, git-branch --info or something.

The problem is that a branch is just a floating name for a line of
development. Its not really a "thing" in the repository like a tag or
a commit. You'd need to make some sort of special tag that describes
the branch or somesuch.
