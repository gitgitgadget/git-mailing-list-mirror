From: =?UTF-8?B?IkFsZWphbmRybyBSLiBTZWRlw7FvIg==?= <asedeno@MIT.EDU>
Subject: Re: [PATCH] git-svn: Add a svn-remote.<name>.pushurl config key
Date: Fri, 22 Apr 2011 15:40:13 -0400
Message-ID: <4DB1D99D.4020104@mit.edu>
References: <1302102336-8800-1-git-send-email-asedeno@mit.edu> <1302274674-4231-1-git-send-email-asedeno@mit.edu> <7vmxk033ic.fsf@alter.siamese.dyndns.org> <20110408205437.GB16540@sigill.intra.peff.net> <7v4o6830cc.fsf@alter.siamese.dyndns.org> <20110408213201.GA20348@sigill.intra.peff.net> <7vipuo1iuy.fsf@alter.siamese.dyndns.org> <20110408224035.GB7343@sigill.intra.peff.net> <4DB1D2F2.6040000@mit.edu> <20110422193621.GB3323@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 22 21:45:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDMI7-0006Dw-6r
	for gcvg-git-2@lo.gmane.org; Fri, 22 Apr 2011 21:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879Ab1DVTpR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Apr 2011 15:45:17 -0400
Received: from DMZ-MAILSEC-SCANNER-1.MIT.EDU ([18.9.25.12]:62208 "EHLO
	dmz-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752420Ab1DVTpQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2011 15:45:16 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Apr 2011 15:45:16 EDT
X-AuditID: 1209190c-b7b7aae0000047c7-e5-4db1d9a350a3
Received: from mailhub-auth-4.mit.edu ( [18.7.62.39])
	by dmz-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id F4.89.18375.3A9D1BD4; Fri, 22 Apr 2011 15:40:19 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id p3MJeEEl022395
	for <git@vger.kernel.org>; Fri, 22 Apr 2011 15:40:15 -0400
Received: from darkmatter.mit.edu (DARKMATTER.MIT.EDU [18.238.2.175])
	(authenticated bits=0)
        (User authenticated as smtp/darkmatter.mit.edu@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p3MJeD8b010649
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Fri, 22 Apr 2011 15:40:14 -0400 (EDT)
Received: by darkmatter.mit.edu (Postfix, from userid 108)
	id DD5AD14C021; Fri, 22 Apr 2011 15:40:13 -0400 (EDT)
Received: from asedeno.corp.itasoftware.com (ita4fw1.itasoftware.com [63.107.91.99])
	by darkmatter.mit.edu (Postfix) with ESMTPSA id A5EA914C00F;
	Fri, 22 Apr 2011 15:40:13 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110402 Icedove/3.1.9
In-Reply-To: <20110422193621.GB3323@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42IRYrdT1118c6OvQfsza4uuK91MDowenzfJ
	BTBGcdmkpOZklqUW6dslcGVc3vOWvWAeV8XW3wdZGhgncHQxcnJICJhI/Dr0kgXCFpO4cG89
	WxcjF4eQwD5GicXzJ7OCJIQETjFKnFovAJH4xCTxesVDZohEkcTqP3+hOnYzSky43cDUxcjB
	wSugJjHzsyRIDYuAqsTmtkVgG9gEXCSWPL7GBmKLCsRLzO68BWbzCghKnJz5BKxGREBW4vvh
	jYwgM5kFFjNKrPnZAZYQFvCQmHZsNTPEsiPMEp+WTQE7j1PASuLktClgi5kF1CXWzxMCCTML
	yEs0b53NPIFReBaSHbMQqmYhqVrAyLyKUTYlt0o3NzEzpzg1Wbc4OTEvL7VI11AvN7NELzWl
	dBMjKLQ5JXl2ML45qHSIUYCDUYmHN3v9Rl8h1sSy4srcQ4ySHExKorwGV4FCfEn5KZUZicUZ
	8UWlOanFhxglOJiVRHgfnwHK8aYkVlalFuXDpKQ5WJTEeWdIqvsKCaQnlqRmp6YWpBbBZGU4
	OJQkeP/dAGoULEpNT61Iy8wpQUgzcXCCDOcBGv4MpIa3uCAxtzgzHSJ/ilFRSpz3LEhCACSR
	UZoH1wtLPa8YxYFeEeZ9CVLFA0xbcN2vgAYzAQ2esxtscEkiQkqqgTHot65YUPLR28ruPMt3
	JMhnLyjSqyh4bWrA0WN6Kj/HqFfjeFt+ctbDKo+1r7lklt35vMEl9MadzX+5vxVbsGyqbrfQ
	3Oofx/as4Ei3S67g18tiZmzl7w9PZucSZZoiZ2knffGa7RRXT/GCbvk7rMfVOJy9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171944>

On 04/22/2011 03:36 PM, Jeff King wrote:
> On Fri, Apr 22, 2011 at 03:11:46PM -0400, "Alejandro R. Sede=C3=B1o" =
wrote:
>> I'd be happy to see something like this get in. I've often noticed
>> git-send-email telling me that it couldn't parse an address out of m=
y
>> signed-of-by lines, but I never stopped and took the time to look in=
to it.
>=20
> That is a separate issue. The patch I posted will make format-patch
> properly quote rfc822 specials in actual email header lines. But
> Signed-off-by lines will remain as they are, being part of the messag=
e
> body. And I think that's what we want. You certainly wouldn't want to
> rfc2047-encode them (they are already covered by the body's content-t=
ype
> encoding).
>=20
> And while you could quote rfc822 specials, people don't tend to do th=
at.
> There's no formal syntax defined, but people tend to treat them as:
>=20
>   Signed-off-by: (.*) <(.*)>
>=20
> i.e., everything inside <> is an address, and everything before that =
is
> the name.
>=20
> If there is an issue with send-email parsing signed-off-by lines or
> formatting the addresses it pulls from them, that's a separate proble=
m
> that will need to be dealt with in send-email.

Okay, then I'll try look into that when things settle down here, if no =
one
else has by then.

-Alejandro
