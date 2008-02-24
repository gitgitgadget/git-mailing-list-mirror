From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: on subtree checkout
Date: Sun, 24 Feb 2008 12:53:09 +0100
Message-ID: <200802241253.11271.jnareb@gmail.com>
References: <fcaeb9bf0802240134i46e276ajfe83071e0b18ce61@mail.gmail.com> <m3wsoubqmq.fsf@localhost.localdomain> <200802241153.58009.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>,
	"git mailing list" <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 12:54:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTFQx-0002Uo-9N
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 12:54:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118AbYBXLxV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Feb 2008 06:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751715AbYBXLxV
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 06:53:21 -0500
Received: from wx-out-0506.google.com ([66.249.82.232]:30060 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbYBXLxU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 06:53:20 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1031562wxd.4
        for <git@vger.kernel.org>; Sun, 24 Feb 2008 03:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=cxbROK4mjyex7beLk+jofGEtWm2rMPbobJ3A8FqhguQ=;
        b=IZCPeMBiYdRFdqHnuY9kbzpAK9zg6xrIS2hXFJTiJnMDtSSoxpHuWceocDjH8aAx3SEpuRXZ8wCL0Ss1LfnzpHiOlo1l4dmfwullLSbo4Fd9HcPywVdBzS119nt89aaBoTLpGvg1qP3863ffxTlao53hCpqH2Ksk+Zd6tJPoo6g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=cxasGKAFQYYIwEl5uYOreepWMTlcUH365MW2AgU23YzJpSzCVgq4vov3XcykwRBMqH6I1vejBKBC3+z3tTKyztkNagrMelpxsSD2aQEmqSdbzLCdRlsqNzsgf1I2JhFC4e3fuoQEAKC///TRl29oYp9QHyC2sM25kMcmEukn29M=
Received: by 10.141.20.7 with SMTP id x7mr1011500rvi.255.1203853999069;
        Sun, 24 Feb 2008 03:53:19 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.255.46])
        by mx.google.com with ESMTPS id d24sm4901943nfh.22.2008.02.24.03.53.16
        (version=SSLv3 cipher=OTHER);
        Sun, 24 Feb 2008 03:53:17 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200802241153.58009.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74926>

Dnia niedziela 24. lutego 2008 11:53, Robin Rosenberg napisa=B3:
> s=F6ndagen den 24 februari 2008 skrev Jakub Narebski:
>> Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:
>>> s=F6ndagen den 24 februari 2008 skrev Nguyen Thai Ngoc Duy:

>>>> I'm going to implement subtree checkout. The plan is to save "inde=
x
>>>> prefix" in GIT_DIR/prefix and update git commands to use index pre=
fix
>>>> when accessing the index. If I'm heading a wrong way, stop me now.
>>>=20
>>> Make it multivalue as having more than one directory checked out is
>>> quite reasonable in for example Eclipse, where there are hundreds o=
f
>>> plugins all listed at the top level, but you only need a checkout
>>> for those that you actually want to change. KDE would be another
>>> example where you want to mention multiple roots.
>>=20
>> IMHO both in case of Eclipse plugins, and KDE modules/apps/whatever
>> it would be much better to use submodules support than partial
>> checkouts.
>=20
> 400 submodules... noway.

Way.

IHMO rule of thumb is: use submodules support if projects are
independent, or at least largely independent.
--=20
Jakub Narebski
Poland
