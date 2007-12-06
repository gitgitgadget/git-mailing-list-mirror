From: David Kastrup <dak@gnu.org>
Subject: Re: Git and GCC
Date: Thu, 06 Dec 2007 23:26:07 +0100
Message-ID: <85r6hzo3y8.fsf@lola.goethe.zz>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com> 	<20071205.202047.58135920.davem@davemloft.net> 	<4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com> 	<20071205.204848.227521641.davem@davemloft.net> 	<4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com> 	<alpine.LFD.0.9999.0712052132450.13796@woody.linux-foundation.org> 	<1196968371.18340.30.camel@ld0161-tx32> 	<7vk5nrd1yq.fsf@gitster.siamese.dyndns.org> 	<7vabonczad.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Loeliger <jdl@freescale.com>,  Linus Torvalds <torvalds@linux-foundation.org>,  Daniel Berlin <dberlin@dberlin.org>,  David Miller <davem@davemloft.net>,  ismail@pardus.org.tr,  gcc@gcc.gnu.org,  Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: gcc-return-142776-gcc=m.gmane.org@gcc.gnu.org Thu Dec 06 23:26:16 2007
Return-path: <gcc-return-142776-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J0PAb-0004Kw-U9
	for gcc@gmane.org; Thu, 06 Dec 2007 23:26:14 +0100
Received: (qmail 25156 invoked by alias); 6 Dec 2007 22:25:55 -0000
Received: (qmail 25144 invoked by uid 22791); 6 Dec 2007 22:25:55 -0000
X-Spam-Check-By: sourceware.org
Received: from fencepost.gnu.org (HELO fencepost.gnu.org) (140.186.70.10)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 06 Dec 2007 22:25:48 +0000
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz) 	by fencepost.gnu.org with esmtp (Exim 4.60) 	(envelope-from <dak@gnu.org>) 	id 1J0PA5-000567-R1; Thu, 06 Dec 2007 17:25:42 -0500
Received: by lola.goethe.zz (Postfix, from userid 1002) 	id 3AE671C4CCE5; Thu,  6 Dec 2007 23:26:07 +0100 (CET)
In-Reply-To: <7vabonczad.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's 	message of "Thu, 06 Dec 2007 13:02:18 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67348>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Jon Loeliger <jdl@freescale.com> writes:
>>
>>> I'd like to learn more about that.  Can someone point me to
>>> either more documentation on it?  In the absence of that,
>>> perhaps a pointer to the source code that implements it?
>>
>> See Documentation/technical/pack-heuristics.txt,
>
> A somewhat funny thing about this is ...
>
> $ git show --stat --summary b116b297
> commit b116b297a80b54632256eb89dd22ea2b140de622
> Author: Jon Loeliger <jdl@jdl.com>
> Date:   Thu Mar 2 19:19:29 2006 -0600
>
>     Added Packing Heursitics IRC writeup.

Ah, fishing for compliments.  The cookie baking season...

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
