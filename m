From: Thomas Ackermann <th.acker@arcor.de>
Subject: Re: [PATCH/RFC] clone: suggest index version 4 when the index is bigger than 512 KiB
Date: Tue, 19 Feb 2013 10:45:04 +0000 (UTC)
Message-ID: <loom.20130219T113730-546@post.gmane.org>
References: <1360848843-12092-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 19 11:45:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7khn-0002rV-RP
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 11:45:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590Ab3BSKpV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Feb 2013 05:45:21 -0500
Received: from plane.gmane.org ([80.91.229.3]:47793 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932339Ab3BSKpT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 05:45:19 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1U7khd-0002jZ-IA
	for git@vger.kernel.org; Tue, 19 Feb 2013 11:45:37 +0100
Received: from proxy36.sbs.de ([194.138.39.56])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 11:45:37 +0100
Received: from th.acker by proxy36.sbs.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 11:45:37 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 194.138.39.56 (Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.57 Safari/537.17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216601>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds <at> gmail.com> writ=
es:

>=20
> I just realized that many of my big repos are still on index v2 while
> v4 should reduce its size significantly (3.8M -> 2.9M for linux-2.6
> and 25M -> 14M for webkit, for example). I wanted to propose index v4
> as the new default version, because I guess that not many people
> outside git <at> vger are aware of it, but perhaps this approach is l=
ess
> drastic. It only suggest index v4 when the index size after clone hit=
s
> 512K limit.
>=20

Is V4 really recommended for general use?
Default seems to be V3 and all I found in the docs is
the coresponding release not describing V4 as "experimental".
(I have repos with index files > 40MiB (!) which will shrink to
approx. 20MiB with V4 so using V4 would be an interessting option for m=
e.)

---
Thomas
