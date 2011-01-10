From: Andy Lester <andy@petdance.com>
Subject: Re: Maybe there should be a git-grep plumbing interface for ack et al.
Date: Sun, 9 Jan 2011 21:38:14 -0600
Message-ID: <A206547D-A7FF-49CD-A122-0FDCD2FBF452@petdance.com>
References: <AANLkTi=E0x55-RUz5CJXL_LJ6hPr--Nupp-Ti72kpNv=@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: perl5-porters@perl.org, Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 10 04:57:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pc8sv-0008RD-1V
	for gcvg-git-2@lo.gmane.org; Mon, 10 Jan 2011 04:57:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916Ab1AJD4y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jan 2011 22:56:54 -0500
Received: from huggy.petdance.com ([72.14.176.61]:54499 "EHLO
	huggy.petdance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501Ab1AJD4y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jan 2011 22:56:54 -0500
X-Greylist: delayed 1116 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Jan 2011 22:56:54 EST
Received: from [192.168.2.100] (99-66-112-7.lightspeed.cicril.sbcglobal.net [99.66.112.7])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: andy)
	by huggy.petdance.com (Postfix) with ESMTP id B2C4F107004;
	Sun,  9 Jan 2011 22:38:15 -0500 (EST)
In-Reply-To: <AANLkTi=E0x55-RUz5CJXL_LJ6hPr--Nupp-Ti72kpNv=@mail.gmail.com>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164866>


On Jan 9, 2011, at 4:17 PM, =C6var Arnfj=F6r=F0 Bjarmason wrote:

> Then e.g. ack(1) could use this new plumbing command to read files
> when in a git repository, but could provide Perl's regex features and
> other things it has.

The plan for ack 2.0 is to have plugins that anyone can write to allow =
acking for whatever you want.  You'll write a plugin for PDF files and =
go acking for text in there, or an Excel file, or some file that specif=
ies a Postgresql table, or whatever.  It's up to the plugin to figure o=
ut how that happens.  I'm not interested in writing hooks to git or any=
 file system any more complicated than straight calls to open(), but pl=
ugin writers will have the flexibility to do it themselves.

xoa

--
Andy Lester =3D> andy@petdance.com =3D> www.techworklove.com =3D> AIM:p=
etdance
