From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: Help a sed noob
Date: Sat, 04 Aug 2007 14:26:05 +0200
Message-ID: <46B4705D.2010208@fs.ei.tum.de>
References: <fcaeb9bf0708031622w25ab6e9ev61372169cfc0bd98@mail.gmail.com> <20070804103126.GA28402@lapse.madduck.net> <20070804115003.GA9716@coredump.intra.peff.net> <20070804121811.GA1605@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 04 14:26:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHIhy-0005dE-U4
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 14:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756598AbXHDM0K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 4 Aug 2007 08:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756129AbXHDM0J
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 08:26:09 -0400
Received: from stella.fs.ei.tum.de ([129.187.54.7]:38565 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbXHDM0I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 08:26:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id F3B4D280EF;
	Sat,  4 Aug 2007 14:26:06 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 5iIy+ze33JJo; Sat,  4 Aug 2007 14:26:06 +0200 (CEST)
Received: from sweatshorts.home.corecode.ath.cx (85-218-11-248.dclient.lsne.ch [85.218.11.248])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 540B5280ED;
	Sat,  4 Aug 2007 14:26:06 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.4 (X11/20070627)
In-Reply-To: <20070804121811.GA1605@lapse.madduck.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54837>

martin f krafft wrote:
> also sprach Jeff King <peff@peff.net> [2007.08.04.1350 +0200]:
>> No, it prints everything _except_ "URL: *" from the first matching l=
ine.
>=20
> I am convinced we could submit this to the Obfuscated Code Contest.
> :)

This is basic sed scripting.

> The behaviour is absolutely unclear from the manpage and defies my
> logic. Can you elaborate a bit, even though this is off-topic?

-ne means "don't print, execute the following code".

/.../ should be clear, { starts a "function list"
s// is "match last regexp, so s/// is "match last regexp and replace wi=
th empty string.
flag "p" to function "s" means "print if matched"
q is "quit".

that's really straight forward and all documented in my sed(1).

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +=
++      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \
