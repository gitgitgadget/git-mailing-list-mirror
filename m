From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] test suite: correct export var=val usage
Date: Wed, 18 Feb 2009 17:56:38 +0100
Message-ID: <F21AE3A2-480B-4311-81E7-32B75B49A356@wincent.com>
References: <7vr61w3dug.fsf@gitster.siamese.dyndns.org> <1234911457-37188-1-git-send-email-jaysoffian@gmail.com> <0E74A2BF-1E59-4D82-A750-380697667F10@wincent.com> <76718490902180519s3b5f4469m391aa34456059d37@mail.gmail.com> <76718490902180529w7520ba64kb7d0d6b284b406bd@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Thomas Rast <trast@student.ethz.ch>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 17:59:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZplA-0001WO-UG
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 17:58:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815AbZBRQ5J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Feb 2009 11:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754683AbZBRQ5I
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 11:57:08 -0500
Received: from wincent1.inetu.net ([209.235.192.161]:60147 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754778AbZBRQ5H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Feb 2009 11:57:07 -0500
Received: from cuzco.lan (54.pool85-53-5.dynamic.orange.es [85.53.5.54])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n1IGudFB001796
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 18 Feb 2009 11:56:41 -0500
In-Reply-To: <76718490902180529w7520ba64kb7d0d6b284b406bd@mail.gmail.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110557>

El 18/2/2009, a las 14:29, Jay Soffian escribi=F3:

> On Wed, Feb 18, 2009 at 8:19 AM, Jay Soffian <jaysoffian@gmail.com> =20
> wrote:
>> On Wed, Feb 18, 2009 at 5:06 AM, Wincent Colaiuta <win@wincent.com> =
=20
>> wrote:
>>> Perhaps my eyes are playing tricks on me but I see the original =20
>>> version
>>> setting MSG to an empty string and exporting it, and your version =20
>>> setting
>>> MSG to "1" and exporting it. So which one is wrong? The original =20
>>> or yours?
>>
>> http://thread.gmane.org/gmane.comp.version-control.git/109897/focus=3D=
110462
>
> Rather, http://thread.gmane.org/gmane.comp.version-control.git/109897=
/focus=3D110457
>
> (Cursed frame interface.)
>
> (The original is wrong.)

I'm definitely blind then, or perhaps I didn't explain myself. At =20
least, I saw nothing in the message you linked that answers my =20
question. Let me try again.

- Prior to your patch, in the two hunks I quoted we set MSG to an =20
empty string and exported it

- After your patch, the hunks now set MSG to "1" (not the same string) =
=20
and export it

In other words, you not only changed the _style_ from "assign and =20
export in a single step" to "assign and then export as two separate =20
steps"; you also changed _what_ gets exported in two of those hunks.

So my question really was, was this intended?

Cheers,
Wincent
