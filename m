From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Repository authenticity question
Date: Wed, 17 Jun 2009 10:07:56 +0200
Message-ID: <4A38A45C.6080708@drmicha.warpmail.net>
References: <200906131527.03450.Karlis.Repsons@gmail.com> <4A33C980.40003@drmicha.warpmail.net> <200906170757.59476.Karlis.Repsons@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: =?UTF-8?B?S8SBcmxpcyBSZXBzb25z?= <karlis.repsons@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 10:08:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGqC1-0004nY-E7
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 10:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755229AbZFQIIP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Jun 2009 04:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754272AbZFQIIO
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 04:08:14 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:37546 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751941AbZFQIIN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Jun 2009 04:08:13 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id A62D131A64C;
	Wed, 17 Jun 2009 04:08:15 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 17 Jun 2009 04:08:15 -0400
X-Sasl-enc: e9mnWj9buGfdzRFmgaZlZmFxq5lV9NKf1SdUwBHiCMqz 1245226095
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id EE15A20C86;
	Wed, 17 Jun 2009 04:08:14 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1pre) Gecko/20090617 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <200906170757.59476.Karlis.Repsons@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121729>

K=C4=81rlis Repsons venit, vidit, dixit 17.06.2009 09:57:
> On Saturday 13 June 2009 15:45:04 you wrote:
>> K=C4=81rlis Repsons venit, vidit, dixit 13.06.2009 17:26:
>>> Hi,
>>> It would be good to know what did Linus meant, when he said "and th=
ey
>>> will fail" about people, who would try changing some git projects'
>>> history (that is, the content, that is added already)? If I loose m=
y
>>> repository completely, can I still know, that those contributions t=
here
>>> are the same after I pull and how? What contents can be deleted, wh=
ile
>>> still retaining consistency?
>>>
>>> Regards,
>>> K=C4=81rlis
>>
>> The sha1 ("object name") of a commit depends not only on its content=
s,
>> but on all its predecessors. So if you know one commit's sha1 to be
>> "original" you know for all its ancestors.
>>
>> Michael
>=20
> So, if I clone someone else's git archive, sha1 of a known commit mus=
t be=20
> compared and what else? How to check if all of archive's sha1-s are i=
dentical=20
> to its contents and every content is included?

As I said: if the sha1 of one commit agrees with what what you have or
know then, automatically, all ancestry is "original": commits as well a=
s
contents.

You can check the repo itself using "git fsck", this makes sure that al=
l
referenced content is included.

Michael
