From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git svn errors out with git-cat-file "usage" message
Date: Thu, 30 Apr 2009 18:31:22 +0200
Message-ID: <46a038f90904300931l4460a085pce97fcb5cdf32dc3@mail.gmail.com>
References: <46a038f90904290811p33332bd5h1d397734907ba9c2@mail.gmail.com>
	 <32541b130904291150k75a0433fnb29ea59f654a17f7@mail.gmail.com>
	 <49F8B7D1.2090903@drmicha.warpmail.net>
	 <46a038f90904291347i2ed158aaya7505e1bd11cd392@mail.gmail.com>
	 <49F8C127.4000400@drmicha.warpmail.net>
	 <46a038f90904300018u7101943blef084dc907a04c8d@mail.gmail.com>
	 <46a038f90904300153v22aa3e9fo407ff5084b58b5fc@mail.gmail.com>
	 <32541b130904300741p325012b7g28dabbd33576ceae@mail.gmail.com>
	 <46a038f90904300803h555f02b3n76d03c93d99f7506@mail.gmail.com>
	 <32541b130904300926x472d6d14p2896d3ade7566684@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Mihai Sucan <mihai.sucan@gmail.com>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 18:32:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzZB6-0007D9-4W
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 18:32:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758997AbZD3QbZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Apr 2009 12:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755653AbZD3QbY
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 12:31:24 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:45346 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754095AbZD3QbX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Apr 2009 12:31:23 -0400
Received: by fxm2 with SMTP id 2so1924186fxm.37
        for <git@vger.kernel.org>; Thu, 30 Apr 2009 09:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XF+gper0vNkZ42M7rSG87hJrls6SRIYz+5/J1CW1XPc=;
        b=Mo5QZF53hXbcv9K1izJ2F691LBc0DnCL68NUI8AD7DGtwfMIIBoyw5wXqyngL9dlB5
         tswC4op6/pDUf2cqnQkfYrP9FybWJsXwnn+Sw3f1pRHkkvTKvdp7b4+F4QlakuN5Ga72
         iJhhpGjWYibwKlsneXhMvULvC03Q18luGnGxk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SBLRPKX/pm+5rg6a/uwZy21Kx+MwxkPFHKYS7iU048Bv01StPpHMspyS+VZr2+rkm/
         t4HxqnUMhPLf0JmM30PI56t1sRImoKI49Rmkkf4D76wJBJdARcPUUd7C1DLgxMtlrQEx
         IxlgNjcKtLYBWqu2hjQ/XuMMlIzCIHb8LbilI=
Received: by 10.223.115.146 with SMTP id i18mr857736faq.6.1241109082250; Thu, 
	30 Apr 2009 09:31:22 -0700 (PDT)
In-Reply-To: <32541b130904300926x472d6d14p2896d3ade7566684@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118031>

On Thu, Apr 30, 2009 at 6:26 PM, Avery Pennarun <apenwarr@gmail.com> wr=
ote:
> And do the contents of these files match the ones in your git source
> directory? =A0What are their md5sums?
>
> /home/martin/libexec/git-core/git-svn
> /home/martin/share/perl/5.10.0/Git.pm

They match alright -

sha1sum /home/martin/share/perl/5.10.0/*
e5ceeaa91bfe878ac45a5e5daad4fa1d50b6ff4a
/home/martin/share/perl/5.10.0/Error.pm
d752abdebc8e40801d891859e6764631c2f1e8ff  /home/martin/share/perl/5.10.=
0/Git.pm

~/src/git$ sha1sum perl/blib/lib/*pm
e5ceeaa91bfe878ac45a5e5daad4fa1d50b6ff4a  perl/blib/lib/Error.pm
d752abdebc8e40801d891859e6764631c2f1e8ff  perl/blib/lib/Git.pm

~/src/git$ sha1sum /home/martin/libexec/git-core/git-svn git-svn
37cae8b77552f0bbdd54e060318bbc6a269a7577  /home/martin/libexec/git-core=
/git-svn
37cae8b77552f0bbdd54e060318bbc6a269a7577  git-svn

it's really weird.



m
--=20
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
