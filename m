From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: Specifying default checkout branch in url
Date: Thu, 11 Dec 2008 12:45:22 +0100
Message-ID: <237967ef0812110345h51b79f13mefc45501ecb5b1b3@mail.gmail.com>
References: <200812111221.36561.Resul-Cetin@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Resul Cetin" <Resul-Cetin@gmx.net>
X-From: git-owner@vger.kernel.org Thu Dec 11 12:46:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAk0A-0000i2-Kf
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 12:46:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755365AbYLKLp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 06:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756623AbYLKLp0
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 06:45:26 -0500
Received: from wa-out-1112.google.com ([209.85.146.179]:21788 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756627AbYLKLpY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 06:45:24 -0500
Received: by wa-out-1112.google.com with SMTP id v27so419730wah.21
        for <git@vger.kernel.org>; Thu, 11 Dec 2008 03:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=u42Z5aO83fpUfaoFWDmcm8q2JtazYOP9fEhnqz3doqE=;
        b=CxskjfNpbin3NhlAcVoZWphaBz2R2OMi0iQ3QuaUVbvMvbi1vuuFCyn0Ni+wTS2Ch8
         /Pmcy8ymG+5982orEm9+v8YaCYKuRotudkhtuHKpbEO3TWVRQR0z3lW+tIFN4uoMmmjN
         3t7+t64ta5Uv9lDvqFe11fjSUZWKWJA5kwUTI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=maVtRRxbyP2Ur2DAOxm3zngyxnraB/MM8SRgaxlLZcFsX7AkJE6aj98pvkoi+7K8nJ
         2q46PVzLhVfiBRuYNuEcrerB2gYIUVNizVzoEzoUPOvndtFSxNCJZWy5vGjmx4Y/hWuS
         ioCyXwb8pfuZ9msacSGMLJS2fxEEHfttiabHY=
Received: by 10.114.59.11 with SMTP id h11mr1797952waa.45.1228995922266;
        Thu, 11 Dec 2008 03:45:22 -0800 (PST)
Received: by 10.114.178.11 with HTTP; Thu, 11 Dec 2008 03:45:22 -0800 (PST)
In-Reply-To: <200812111221.36561.Resul-Cetin@gmx.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102795>

2008/12/11 Resul Cetin <Resul-Cetin@gmx.net>:
> Hi,
> I have the problem that I want to checkout a specific branch in a git-clone
> run. Someone at the debian-mentors mailing list[1] has suggested to use a url
> like git://git.myserver.org/project.git#branchname to checkout a branch with
> the name branchname by default. But this doesn't seem to work. Is there
> already another way to encode this in the url?
> More information why I cannot change HEAD of the repository can be found in a
> bug report against debcheckout[2].
>
> Regards,
>        Resul
>
> [1] http://article.gmane.org/gmane.linux.debian.devel.mentors/34421
> [2] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=508433

Use a git init, remote add, fetch branchname:branchname sequence.

-- 
Mikael Magnusson
