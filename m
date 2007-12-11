From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Fix typo: we require Python 2.4, not 2.5
Date: Tue, 11 Dec 2007 06:47:38 -0800 (PST)
Message-ID: <m3r6hts2yk.fsf@roke.D-201>
References: <b0943d9e0712100340p78326b4avf2b7e64008bba6d6@mail.gmail.com>
	<20071211142347.GA22879@diana.vm.bytemark.co.uk>
	<b0943d9e0712110627g70ad0aecyfeaafd8b8655fb57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-15?q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 15:48:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J26Oy-0002S0-5i
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 15:48:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbXLKOrn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Dec 2007 09:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbXLKOrm
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 09:47:42 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:13385 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbXLKOrl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Dec 2007 09:47:41 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1298676nfb
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 06:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:from:date;
        bh=WcSilzSj8Pj3LjfKbefJtY2l944lBDw/Vn/7nw5ydGs=;
        b=UEWAZ/I0kuOuPyTIioZacl9ARMUIzSn+9IO/gywIGmwtz7+rzmW+Usor2yeLRDYbanefHP6BwucezK7yxBSY9UWaznFwW0FXL5TM5m/pSCr3j5FH6wpeqCdRHTHJDF3Q4CcZBP5Tu2si1a2A2+rYoux7dbq/IpFF4anZU+pVVo0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:from:date;
        b=FbKcHv6zbFEvrS8GsD0p7/9Ziciq67WLuk0HqNUj3xu1apvIZ4e6tdZOpPXjq3kRK90nx+rqnx1g8Kd1X+n4jpGtmiGxmH2VW2+3YGy/RSo+v+Au2oDCZsqnphAHl7jxYHiUSNmNO+R7UAgq23cQpmvwSJ1t0xmfipFRVGX3jqY=
Received: by 10.86.73.17 with SMTP id v17mr6748137fga.1197384460062;
        Tue, 11 Dec 2007 06:47:40 -0800 (PST)
Received: from roke.D-201 ( [83.8.252.236])
        by mx.google.com with ESMTPS id l12sm1321312fgb.2007.12.11.06.47.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 11 Dec 2007 06:47:38 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lBBElYJU010328;
	Tue, 11 Dec 2007 15:47:35 +0100
Received: (from jnareb@localhost)
	by roke (8.13.4/8.13.4/Submit) id lBBElWEY010324;
	Tue, 11 Dec 2007 15:47:32 +0100
X-Authentication-Warning: roke: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <b0943d9e0712110627g70ad0aecyfeaafd8b8655fb57@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67862>

"Catalin Marinas" <catalin.marinas@gmail.com> writes:

> On 11/12/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> > On 2007-12-10 11:40:41 +0000, Catalin Marinas wrote:
> >
> > > This release requires at least Python 2.4 and GIT 1.5.2.
> >
> > Yeah. So 0.14.1 (to be released very soon) should probably have thi=
s
> > fix. :-)
>=20
> Oops, I did some tests and forgot to revert it to 2.4. This would onl=
y
> affect people using the source tarball. The rpm and deb packages
> should be fine.

Hmmm...

$ rpm -Uhv --test stgit-0.14-1.noarch.rpm=20
error: Failed dependencies:
        python(abi) =3D 2.5 is needed by stgit-0.14-1.noarch

Although I guess that it is something that rpmbuild sets (if not set)
automatically during building.

I'll just download SRPMS (which is available, just not linked from
download area on homepage).

P.S. By the way: [application/x-wais-source]?
--=20
Jakub Narebski
Poland
ShadeHawk on #git
