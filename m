From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH] add -p: make the beginning of the hunk easier to see
Date: Sat, 13 Feb 2010 15:04:16 +0000
Message-ID: <da1290fab3da0339a2f08dc320e297f9@212.159.54.234>
References: <4B768807.3030003@gmail.com> <20100213112342.GA1299@coredump.intra.peff.net> <6672d0161002130333m55372972x909234cae7bd0d82@mail.gmail.com> <6672d0161002130342h348765a0j76f63972c4bbe060@mail.gmail.com> <20100213115512.GA5472@coredump.intra.peff.net> <6672d0161002130634j6d9b4994w5cd44405fe9b98a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 13 16:04:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgJXp-0000HA-1Y
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 16:04:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755875Ab0BMPEX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Feb 2010 10:04:23 -0500
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:42085 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755552Ab0BMPEW (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Feb 2010 10:04:22 -0500
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id 79974819C372;
	Sat, 13 Feb 2010 15:04:19 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 47CDE204C5C;
	Sat, 13 Feb 2010 15:04:19 +0000 (GMT)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 0Q0UhnSydiRE; Sat, 13 Feb 2010 15:04:16 +0000 (GMT)
Received: from webmail.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 8F98517730E;
	Sat, 13 Feb 2010 15:04:16 +0000 (GMT)
In-Reply-To: <6672d0161002130634j6d9b4994w5cd44405fe9b98a1@mail.gmail.com>
X-Sender: julian@quantumfyre.co.uk
User-Agent: RoundCube Webmail/0.1-rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139805>

On Sat, 13 Feb 2010 15:34:00 +0100, Bj=C3=B6rn Gustavsson
<bgustavsson@gmail.com> wrote:
> 2010/2/13 Jeff King <peff@peff.net>:
>> On Sat, Feb 13, 2010 at 12:42:56PM +0100, Bj=C3=B6rn Gustavsson wrot=
e:
>> If you are using color.interactive (or color.ui), that should alread=
y
be
>> "bold blue". You can change it to red with color.interactive.prompt.
>=20
> Oops! Turned out I only had colors for "diff", "status", and "branch"=
,
> so the prompt had had no color. I configured my color settings the
> day I started using git last spring (according to some tutorial or
> getting started document) and haven't looked at the color
> settings since.
>=20
> Now it looks much better.
>=20
> Personally, I would prefer if more colors were turned on by
> default, or if there were a master setting to turn on all colors
> at once.

quoting man git-config:

       color.ui
           When set to always, always use colors in all git commands wh=
ich
are
           capable of colored output. When false (or never), never. Whe=
n
set
           to true or auto, use colors only when the output is to the
           terminal. When more specific variables of color.* are set, t=
hey
           always take precedence over this setting. Defaults to false.

--=20
Julian
