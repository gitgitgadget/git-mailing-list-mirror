From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Fri, 7 Sep 2007 14:33:42 +0200
Message-ID: <E4A6490A-ABA9-4383-978E-C7F2E4BC9C23@wincent.com>
References: <46DDC500.5000606@etek.chalmers.se> <1189004090.20311.12.camel@hinata.boston.redhat.com> <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com> <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org> <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <D7BEA87D-1DCF-4A48-AD5B-0A3FDC973C8A@wincent.com> <46E0EEC6.4020004@op5.se> <Pine.LNX.4.64.0709071155570.28586@racer.site> <46E13C0F.8040203@op5.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Sep 07 14:36:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITd4B-0000qt-HJ
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 14:36:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965300AbXIGMeF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 7 Sep 2007 08:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965298AbXIGMeE
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 08:34:04 -0400
Received: from wincent.com ([72.3.236.74]:48594 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965187AbXIGMeD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Sep 2007 08:34:03 -0400
Received: from [192.168.1.99] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l87CXlBC032461;
	Fri, 7 Sep 2007 07:33:48 -0500
In-Reply-To: <46E13C0F.8040203@op5.se>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58033>

El 7/9/2007, a las 13:54, Andreas Ericsson escribi=F3:

> Johannes Schindelin wrote:
>> Hi,
>> On Fri, 7 Sep 2007, Andreas Ericsson wrote:
>>> Wincent Colaiuta wrote:
>>>> El 7/9/2007, a las 2:21, Dmitry Kakurin escribi?:
>>>>
>>>>> I just wanted to get a sense of how many people share this "Git =20
>>>>> should
>>>>> be in pure C" doctrine.
>>>> Count me as one of them. Git is all about speed, and C is the =20
>>>> best choice
>>>> for speed, especially in context of Git's workload.
>>>>
>>> Nono, hand-optimized assembly is the best choice for speed. C is =20
>>> just
>>> a little more portable ;-)
>> I have a buck here that says that you cannot hand-optimise =20
>> assembly (on modern processors at least) as good as even gcc.
>
>
> http://www.gelato.unsw.edu.au/archives/git/0504/1746.html
>
> I win. Donate $1 to FSF next time you get the opportunity ;-)

Well, you picked a very specific algorithm amenable to that kind of =20
optimization: small, manageable, with a minimal and well-defined =20
performance critical section that could be written in assembly. Note =20
how a good chunk of the implementation was still in C. At most I'd =20
give you 75 cents for that one. ;-)

Wincent
