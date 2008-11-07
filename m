From: Miles Bader <miles@gnu.org>
Subject: Re: multiple-commit cherry-pick?
Date: Fri, 07 Nov 2008 14:09:07 +0900
Message-ID: <buozlkcqg0c.fsf@dhapc248.dev.necel.com>
References: <buoiqr18tdk.fsf@dhapc248.dev.necel.com>
	<20081106032437.GA27237@euler> <20081106095122.GA2656@atjola.homenet>
	<buozlkd6oh1.fsf@dhapc248.dev.necel.com>
	<20081106122658.GB4192@atjola.homenet>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Deskin Miller <deskinm@umich.edu>, git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 07 06:10:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyJcD-0000cD-Lm
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 06:10:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbYKGFJU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Nov 2008 00:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbYKGFJU
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 00:09:20 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:58923 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbYKGFJT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Nov 2008 00:09:19 -0500
Received: from relay31.aps.necel.com ([10.29.19.54])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id mA7599Sp010689;
	Fri, 7 Nov 2008 14:09:09 +0900 (JST)
Received: from relay21.aps.necel.com ([10.29.19.24] [10.29.19.24]) by relay31.aps.necel.com with ESMTP; Fri, 7 Nov 2008 14:09:08 +0900
Received: from dhapc248.dev.necel.com ([10.114.112.215] [10.114.112.215]) by relay21.aps.necel.com with ESMTP; Fri, 7 Nov 2008 14:09:08 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id 6881244E; Fri,  7 Nov 2008 14:09:08 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <20081106122658.GB4192@atjola.homenet> (=?iso-8859-1?Q?=22Bj?=
 =?iso-8859-1?Q?=F6rn?= Steinbrink"'s
	message of "Thu, 6 Nov 2008 13:26:58 +0100")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100287>

Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> writes:
>> > git reset --hard C
>> > git rebase --onto ORIG_HEAD A^
>>=20
>> Is that safe...?  Doesn't git-rebase also set ORIG_HEAD?
>
> One of the first things rebase does is validating and resolving its
> arguments. And that's happening before any actions that would touch
> ORIG_HEAD.

Ah, I see.

Hmm, I guess using rebase --abort isn't a very good idea in this case
though... :-/

Kind of a shame, since it's nice being to just abort the whole operatio=
n
if it turns out you did something wrong and aren't sure how to recover.

Thanks,

-Miles

--=20
Kilt, n. A costume sometimes worn by Scotchmen [sic] in America and Ame=
ricans
in Scotland.
