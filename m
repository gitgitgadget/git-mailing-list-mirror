From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: BUG! missing .idx causes .pack to be removed
Date: Fri, 06 Aug 2010 09:14:18 +0200
Message-ID: <4C5BB64A.4070601@lsrfire.ath.cx>
References: <20100805170137.GA2630@nibiru.local> <AANLkTi=bjM7rGSXv0eB5+6VEX=wY84upkzDcBJ6C9KdK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: weigelt@metux.de, git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 09:14:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhH8X-0000Vr-L9
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 09:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760454Ab0HFHOa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Aug 2010 03:14:30 -0400
Received: from india601.server4you.de ([85.25.151.105]:45039 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758900Ab0HFHO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 03:14:29 -0400
Received: from [10.0.1.100] (p57B7F69B.dip.t-dialin.net [87.183.246.155])
	by india601.server4you.de (Postfix) with ESMTPSA id 964182F80B5;
	Fri,  6 Aug 2010 09:14:27 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.7) Gecko/20100713 Thunderbird/3.1.1
In-Reply-To: <AANLkTi=bjM7rGSXv0eB5+6VEX=wY84upkzDcBJ6C9KdK@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152766>

Am 06.08.2010 05:24, schrieb Tay Ray Chuan:
> Hi,
>=20
> On Fri, Aug 6, 2010 at 1:01 AM, Enrico Weigelt <weigelt@metux.de> wro=
te:
>> while doing some experiments I've removed the *.idx files and
>> ran git-repack - that complained about missing objects and removed
>> all *.pack files !
>>
>> I'm sure that's a bug - an ugly one ;-o
>=20
> IIRC, a .pack file is useless without its corresponding .idx file. So
> the removal of a .pack file makes sense here - to me, at least.

git-index-pack can rebuild the index for a pack file.  Not sure if it
should be done automagically, but the file is not completely useless.

Ren=E9
