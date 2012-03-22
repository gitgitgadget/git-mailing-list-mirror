From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: Strange effect merging empty file
Date: Thu, 22 Mar 2012 13:47:04 +0100
Message-ID: <4F6B1F48.3040007@in.waw.pl>
References: <4F69AD3C.4070203@ericsson.com> <4F69B375.5050205@in.waw.pl> <86iphwomnq.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ralf Nyren <ralf.nyren@ericsson.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 13:47:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAhQD-00079L-Om
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 13:47:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757900Ab2CVMrN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Mar 2012 08:47:13 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:56060 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755115Ab2CVMrN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 08:47:13 -0400
Received: from optyk25.fuw.edu.pl ([193.0.81.79])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SAhQ6-0001UP-Iw; Thu, 22 Mar 2012 13:47:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20120104 Icedove/8.0
In-Reply-To: <86iphwomnq.fsf@red.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193650>

On 03/22/2012 01:17 PM, Randal L. Schwartz wrote:
>>>>>> "Zbigniew" =3D=3D Zbigniew J=C4=99drzejewski-Szmek<zbyszek@in.wa=
w.pl>  writes:
>
> Zbigniew>  touch .gitignore
>
> If you're doing this to make sure git makes an empty directory, alway=
s
> put the directory name in there as a comment... that makes it (a) not=
 an
> empty file (so merge doesn't get confused) and (b) unique, so when yo=
u
> change it, merge won't try to change other similar empty files.

Yes, this will indeed fix this particular problem. But in general, empt=
y=20
files can be used for various reasons, and it can be a pretty nasty=20
surprise if they sprout random content as a result of a merge.

Maybe merge-recursive could special-case empty files?

Zbyszek
