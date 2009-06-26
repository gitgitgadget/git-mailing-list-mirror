From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv6 4/8] gitweb: (gr)avatar support
Date: Sat, 27 Jun 2009 01:25:24 +0200
Message-ID: <200906270125.25048.jnareb@gmail.com>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com> <200906270058.16686.jnareb@gmail.com> <cb7bb73a0906261614x3a5dab02h1f29d68b6f5005b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 01:25:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKKnW-0001oJ-CX
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 01:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753113AbZFZXZY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Jun 2009 19:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751714AbZFZXZX
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 19:25:23 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:57261 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295AbZFZXZW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 19:25:22 -0400
Received: by fg-out-1718.google.com with SMTP id e12so129081fga.17
        for <git@vger.kernel.org>; Fri, 26 Jun 2009 16:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=+PsutyRHKyhXvXqqZkfxZVVbKFoV2/PAprC6fr15zl8=;
        b=V/OHUP9CinaSWq/fIcv02WFUjvxpf+YB2x3USAfkSTNZjWchyiaJEb8UkYyyZQukjV
         ng2gpARbdLtqGg/qx1ZF1Vs4HZNe/vjWkx/zAwknqjTKWCpyPwtn6QTia1gsfFCK2LQF
         XUNL25+T6LA8GBH5PVf8cr5UOKQ87E/n7qQWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=kDeoHKpEpxkZN7jULoIEAP/vpuc5bnr+kYtu8/TM3vmFxtVaUYvX3xvHv3QtSHIfUb
         X5Mn7z3MD+dnoUDvI4X1bjNUuxExSuoZSZdkZHS9EAKVY5pqd/gW5ESsP82VR5P8IcKr
         0YuHtSXMe3WtsCUGQhLeAifpT2dAlN8fnrRgY=
Received: by 10.86.1.1 with SMTP id 1mr4216117fga.0.1246058724581;
        Fri, 26 Jun 2009 16:25:24 -0700 (PDT)
Received: from ?192.168.1.13? (abwa104.neoplus.adsl.tpnet.pl [83.8.224.104])
        by mx.google.com with ESMTPS id e11sm1367955fga.16.2009.06.26.16.25.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Jun 2009 16:25:23 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0906261614x3a5dab02h1f29d68b6f5005b1@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122334>

Dnia sobota 27. czerwca 2009 01:14, Giuseppe Bilotta napisa=B3:
> On Sat, Jun 27, 2009 at 12:58 AM, Jakub Narebski<jnareb@gmail.com> wr=
ote:

> > Do I understand this correctly that there is additional patch plann=
ed
> > in new release of this series providing support for gitweb.avatar =3D=
 picon?
>=20
> Yes.
>=20
> And a separate patch makes the picon the fallback for gravatar too,
> but I'm thinking about having something like a gitweb.gravatar_defaul=
t
> (or something like that) to make that configurable.

I'm not sure if having picons as 'default' for gravatar is a good idea,
because the rules for resolving picons are complicated[1]... which=20
I didn't realize when writing this (sketch of) idea.

[1] http://www.cs.indiana.edu/picons/ftp/faq.html
--=20
Jakub Narebski
Poland
