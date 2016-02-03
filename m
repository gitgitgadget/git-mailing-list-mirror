From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] test-lib: limit the output of the yes utility
Date: Wed, 3 Feb 2016 13:11:57 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602031309550.2964@virtualbox>
References: <56B05A95.3000808@kdbg.org> <alpine.DEB.2.20.1602020907290.2964@virtualbox> <56B0F259.1060100@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Feb 03 13:12:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQwI3-00007i-LT
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 13:12:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754698AbcBCMMD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 07:12:03 -0500
Received: from mout.gmx.net ([212.227.17.21]:64738 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752398AbcBCMMB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 07:12:01 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MAQMg-1aKqQ81eAc-00BbnT; Wed, 03 Feb 2016 13:11:58
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <56B0F259.1060100@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:D33bUitZ7rekiKJNlVUOpEM2ihQ6FRZ58pool1pCwS/w1j0kWc8
 I+v7AI1M95gJ4gfjUkqaDA2r+wMXRicu4+uSS4z9NpfSQthFFHv4QSh5aMJlxn7n2LlmdBx
 SRNjYXATVhZK/3DwrJ4hSmYIyza/B5Co3GtNNxZhmxyVMRQHWG93VYJ40aRiw0Qxy55MANu
 Ngbti/O9sbjFcQgsq6sWg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Iy6mq8cGWTU=:ePKAlM9fBJxnyuuCpqj/2V
 0Te+/Nrw8rNkWGEjF48jbnmEI1RGS9B4PCn5r7xHcW/kq3WEE3WoE23c2wfNTjkMw7+3+JkP2
 +xZfbJOm4PlpeSL/xwIEnVUaEpee5QB+gT9AIJhbnLfi0diSPM1hAVlhC2ZClDQyCDeQ9s4Rk
 B+otB7yvZddXqPSDRSAzNYB11Zq4d57iDOvtnvFBXf2oN6gkN4TP0prZLTdpv05ZoKqJJLwH/
 nG7kH4j3aO0spXMplkFRXL3Nj/mp+vQXqgc2EeeIIRSp18tBefGGM0P6PaHgGI/6Bx6KSzvHP
 rZ4/Oca8QvjfIArYbKPXxQ21endd4xMIcKfAHV1WfMG32fYwKR3jb0Qy/KvwyClG0LvvnLILE
 i0gbrM4hiEpuHxieaFfY1rTHFEkpO39pxeTxHyyA+AVs+IlQASOGtmOcTOUYE84hIXcvdmn8A
 ZIT5OlCoxvnsmiAtRdkGmhCxPdfd0lPXKkhcni5A7Tnwj5CuermT3TwwQlrY76qwGrHay2gas
 kCTm4hkwQRY22Do1eN4vbGALSpJ2TciAQM/14BUvqOdqrZUJFmdEAF2gFMgBDZftB3PdaF9CN
 Uqmfx6IW7qxpxzGj+62jZUWPLucFUHFB6SrnceYnTI6xtR10ReHBV6ynAdYUylEcdblVdRQOH
 8Y7uL0HsSSaTY9Pp1lmF8PIT9IUKBz4EFriVQFZ271of+j/neVYM61yXV7MzODOXjRVDxHmzv
 GQT670YgK1S8FzMA/8ATebcYkvxCKDzR9dTy3NzrA+K2T0I5JngOYUaedpfN3vDOOSewzFur 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285366>

Hi Hannes,

On Tue, 2 Feb 2016, Johannes Sixt wrote:

> I'm not 100% satisfied with your version because it stomps on
> short-and-sweet shell variables $i and $y.

Please note that $y was already stomped on before my patch.

> But then the utility only occurs upstream of a pipeline in a separate
> process, so that does not matter.

That was my thinking, too.

> Please allow me to pass authorship to you, since the patch text is
> now all yours, and to forge your sign-off.

Fair enough,
Dscho
