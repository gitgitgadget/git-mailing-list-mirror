From: Ivan Kanis <expire-by-2010-08-10@kanis.fr>
Subject: Re: Git server eats all memory
Date: Thu, 05 Aug 2010 08:33:02 +0200
Message-ID: <87ocdhlgbl.fsf@kanis.fr>
References: <wesfwyupgrg.fsf@kanis.fr>
	<AANLkTimwy6GumHYSTo2je_hOUO80KEpx4_8z3iOoZyc0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 08:33:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ogu0y-0008BO-Rh
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 08:33:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759702Ab0HEGdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 02:33:09 -0400
Received: from kanis.fr ([75.127.73.245]:1618 "EHLO kanis.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758286Ab0HEGdH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 02:33:07 -0400
Received: from [89.83.137.164] (helo=tao)
	by kanis.fr with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <expire-by-2010-08-10@kanis.fr>)
	id 1Ogu0m-0007G3-Na; Thu, 05 Aug 2010 02:33:05 -0400
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAAXNSR0IArs4c6QAAAB5QTFRF
 IBkXUxMTOCwoTC4qcUY8iFxQmmper31txpaJ/v/8aKZ1oAAAAcVJREFUOMt100tu2zAQAFDCXnUZ
 oAcIqG68LZULVLQBbwuSiffm6AIRRyeotAySJoVu2+FPpJWWC3/4NKOZocSW/yxWfnJ2+Bdwzhj7
 8gleWVy7DXC2rkMNr2V/zRbghXIwthf3VbIA9Ffc71vZCSFyCEsBggtNS8ludwvfmhYA0Vn9o4DP
 zMWxR7+cPWzAYFzwM0ModtdmcDbDS6i/hT7L+RZof5yCXGrYe5jn2YO6BYMjgY+51tCIAqHgBLwR
 pwLnGuRjAKyBJkuN4yd4U92uCY1vUr2D/c5b8DuxyQwfOHUeaLqDJhnkkuGXbB56h2C1IVBdgncc
 bBi6feroa9B6jUDojnQPQKupbyXyeeCE1oT7Oqrt+SnfY3mkiyGA/3AmD3H5g32CcBx6hY8pRkwJ
 9PpcjRGobUfprFnhAa1vepwcgMOhwG+pdSgKHFU9HAvoAH6XUl7lDUCCq5Qb6GMbVm3Aj++qDYCt
 wdBc/YHgOFCmS3mjDMRcSE2qY4E3Q3PVIQRQmeodNH4QEbRUFZzW+VotzwX4yTcRTySOML1qjcE5
 hTirVqDHkMAP0PjAywp3d18JZtqzvr9zDYD+GaSKtE6Zlr/DLPNFmOcvBAAAAABJRU5ErkJggg==
In-Reply-To: <AANLkTimwy6GumHYSTo2je_hOUO80KEpx4_8z3iOoZyc0@mail.gmail.com>
	(Avery Pennarun's message of "Wed, 4 Aug 2010 16:12:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152616>

Avery Pennarun <apenwarr@gmail.com> wrote:

> On Wed, Aug 4, 2010 at 10:57 AM, Ivan Kanis

>> I am having problem with memory ballooning when receiving object
>> from the server. The amount of memory used on the server seems to be same
>> size as the object received.

> Git works fine with huge repositories; it does not work fine at all
> with very large individual objects in a repository, and it does what
> you're experiencing.

Hello Avery,

The largest object is 120M. I didn't describe the problem very
accurately. The memory consumed is the *sum* of the objects
downloaded. 

For example, a repository of 4G consumes 4G of memory at the end of the
receiving objects phase. What is very interesting is the total of
objects downloaded is the same as the memory consumed. That makes me
think there is a link somewhere. Surely it shouldn't consume that much
memory.

I am ready to do whatever to diagnose the problem. I know C pretty well
and am ready to look into it but I am not sure where to start.

Take care,
-- 
Ivan Kanis
http://kanis.fr

Seriousness is the only refuge of the shallow.
    -- Oscar Wilde 
