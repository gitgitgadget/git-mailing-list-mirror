From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH] doc/bundle: Use the more conventional suffix '.bundle'
Date: Sun, 8 Feb 2009 10:41:04 +0100
Message-ID: <adf1fd3d0902080141s11b53127ufa83918c00b4579b@mail.gmail.com>
References: <1234045309-3626-1-git-send-email-santi@agolina.net>
	 <200902072302.36991.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Sun Feb 08 10:42:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW6BP-00039a-4B
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 10:42:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752743AbZBHJlK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2009 04:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752738AbZBHJlJ
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 04:41:09 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:36592 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707AbZBHJlH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Feb 2009 04:41:07 -0500
Received: by bwz5 with SMTP id 5so455423bwz.13
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 01:41:04 -0800 (PST)
Received: by 10.102.218.5 with SMTP id q5mr1560432mug.99.1234086064075; Sun, 
	08 Feb 2009 01:41:04 -0800 (PST)
In-Reply-To: <200902072302.36991.bss@iguanasuicide.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108935>

2009/2/8 Boyd Stephen Smith Jr. <bss@iguanasuicide.net>:
> On Saturday 07 February 2009 16:21:49 Santi B=E9jar wrote:
>> Although it does not matter in general it is handled different by
>> "git clone", as it removes it to make the "humanish" name of the
>> new repository.
>
> I'm mixed on this, particularly with the increasing numbers of MySysG=
it users
> we attract.  Perhaps it would be better to teach clone to remove .bdl=
 as well.

I don't have an opinion as I don't know exactly the situation for
MSysGit users, but I don't think it is a good idea to have two
suffixes.

>
> General Query:
> Is the bundle format stable enough to register a MIME-type (and assoc=
iated
> extensions)?

At least the signature yes:

static const char bundle_signature[] =3D "# v2 git bundle\n";


> --
> Boyd Stephen Smith Jr.                   ,=3D ,-_-. =3D.
> bss@iguanasuicide.net                   ((_/)o o(\_))
> ICQ: 514984 YM/AIM: DaTwinkDaddy         `-'(. .)`-'
> http://iguanasuicide.net/                    \_/
>
>
