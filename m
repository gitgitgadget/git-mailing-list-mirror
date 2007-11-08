From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH v2] user-manual: add advanced topic "bisecting merges"
Date: Thu, 8 Nov 2007 07:40:56 +0100
Message-ID: <16D3798E-5229-485D-9EC4-426625BAFEB2@zib.de>
References: <20071104112302.GA2119@ins.uni-bonn.de> <11944722214046-git-send-email-prohaska@zib.de> <F783880C-A0F9-45D9-A23A-075600B31CEE@lrde.epita.fr>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Ralf.Wildenhues@gmx.de,
	Git Mailing List <git@vger.kernel.org>
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Thu Nov 08 07:40:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq13e-0004wd-5M
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 07:40:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbXKHGjt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Nov 2007 01:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbXKHGjs
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 01:39:48 -0500
Received: from mailer.zib.de ([130.73.108.11]:62873 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751452AbXKHGjr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Nov 2007 01:39:47 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lA86dd96021848;
	Thu, 8 Nov 2007 07:39:39 +0100 (CET)
Received: from [192.168.178.21] (brln-4db1017f.pool.einsundeins.de [77.177.1.127])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lA86dcpt027230
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 8 Nov 2007 07:39:38 +0100 (MET)
In-Reply-To: <F783880C-A0F9-45D9-A23A-075600B31CEE@lrde.epita.fr>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63938>


On Nov 7, 2007, at 11:16 PM, Benoit Sigoure wrote:

> Hi Steffen,
>
> On Nov 7, 2007, at 10:50 PM, Steffen Prohaska wrote:
>
> Some more comments below.  Sorry for not spotting these earlier.

I'll took all your suggestions except for ...


[...]

>> +later when you have a better understanding of git.
>> +
>> +[[bisect-merges]]
>> +Why bisecting merge commits can be harder than bisecting linear =20
>> history
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~=20
>> ~~~
>> +The following text is based upon an email by Junio C. Hamano to
>> +the git mailing list
>> +(link:http://marc.info/?l=3Dgit&m=3D119403257315527&w=3D2[link:http=
://=20
>> marc.info/?l=3Dgit&m=3D119403257315527&w=3D2]).
>> +It was slightly adapted for this manual.
>> +
>> +Bisecting merges can be challenging due to the complexity of
>> +changes introduced at a merge.  Bisecting through merges is not a
>
> s/at a merge/& point/ ?

I'll replace the first sentence with

Using gitlink:git-bisect[1] on a history with merges can be challenging=
=2E

The details are explained in the remainder of the paragraph.


[...]

>> +added a new calling site for that function at commit Y.  The
>> +commits from Z leading to B all assume the old semantics of that
>> +function and the callers and the callee are consistent with each
>> +other.  There is no bug at B, either.
>> +
>> +You merge to create C.  There is no textual conflict with this
>> +three way merge, and the result merges cleanly.  You bisect
>> +this, because you found D is bad and you know Z was good.  Your
>> +bisect will find that C (merge) is broken.  Understandably so,
>> +as at C, the new calling site of the function added by the lower
>> +branch is not converted to the new semantics, while all the
>> +other calling sites that already existed at Z would have been
>> +converted by the merge.  The new calling site has semantic
>> +adjustment needed, but you do not know that yet.  You need to
>
> s/adjustment/&s/

I'm not sure if plural is needed.

	Steffen

--
Steffen Prohaska <prohaska@zib.de>  <http://www.zib.de/prohaska/>
Zuse Institute Berlin, Takustra=DFe 7, D-14195 Berlin-Dahlem, Germany
+49 (30) 841 85-337, fax -107
