From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 0/9] i18n: add PO files to po/
Date: Tue, 4 Oct 2011 23:58:07 +0200
Message-ID: <CACBZZX5uz5cdoWebYOY-Omu0drnQasJB-12DMZyZ_NX17jzhmg@mail.gmail.com>
References: <1317668297-2702-1-git-send-email-avarab@gmail.com>
	<20111003220659.GA19537@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?Q?Marcin_Cie=C5=9Blak?= <saper@saper.info>,
	Sam Reed <sam@reedyboy.net>,
	Jan Engelhardt <jengelh@medozas.de>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 23:58:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBD0D-0000Ti-8T
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 23:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933188Ab1JDV6K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Oct 2011 17:58:10 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49716 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933049Ab1JDV6J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Oct 2011 17:58:09 -0400
Received: by bkbzt4 with SMTP id zt4so1245881bkb.19
        for <git@vger.kernel.org>; Tue, 04 Oct 2011 14:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=pCRU4WrUo2nAbC9+fO+fN4ONeTcjEX2r5gFstKvY/DM=;
        b=snkziW2L7/dRRCDHoGE652Ue8qjzSx0zKc85AXbt2YlzR6EYC1j2pBIDBRboqKplG1
         pveNfRpnkIwGJcdV/FL9WxcKfNF1cgRV8kP/8faR5MW+yewp7PbZM6OyzWX2/4lFbaR/
         P246wjISA8vTlYjWzLDTzlcndFPiLVutdho3c=
Received: by 10.204.130.139 with SMTP id t11mr1047604bks.300.1317765487631;
 Tue, 04 Oct 2011 14:58:07 -0700 (PDT)
Received: by 10.204.119.203 with HTTP; Tue, 4 Oct 2011 14:58:07 -0700 (PDT)
In-Reply-To: <20111003220659.GA19537@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182807>

On Tue, Oct 4, 2011 at 00:06, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> It's been a long time coming, but here's an initial submission of PO
>> files to the po/ directory. This adds some initial and as of yet
>> unused translations.
>
> Neat. =C2=A0I think it's good to figure out what we will do with thes=
e
> anyway, and we don't have to wait for the infrastructure to do that.

I think it's a bit too premature to try to plan this all ahead, why
not just take patches to po/ and see what the friction points are,
then address those as they arise?

The reason I'm submitting this is because:

 * Other parts of the i18n series depend on there being some PO files
   for tests etc.

 * I've had these sitting in my tree for way to long and there's no
   reason not to stick them in git.git for further improvement.

> So, basic questions:
>
> =C2=A01. which branch will be translated?

Translations are an end user product, so I think it makes sense to
just translate the master when it's near or in the RC phase when you
know your work will make it into the end release and be useful to
users.

> =C2=A02. who keeps track of incoming translations?

While we could set up some "i18n maintainer" infrastructure why not
just have people submit patches to the list like we do for every other
file in git?

The people maintaining each translation would be the authority on that
file so their patches should be fast-tracked once they're seen not te
be complete buffoons.

> =C2=A03. how can we avoid this making "git log -p" output unusable?

Well it's already going to be making "git log -p" output unusable for
most software projects that use git and any sort of pseudo-generated
files, so it sounds like having this in the core and raising an itch
to scratch might improve the git user experience for everyone with
e.g. an --exclude option to git log.
