From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH bc/connect-plink] t5601-clone: remove broken and pointless
 check for plink.exe
Date: Wed, 12 Aug 2015 13:07:31 +0200
Organization: gmx
Message-ID: <866a41f50ef9b4807da72576a4bca717@www.dscho.org>
References: <55CA6066.5070500@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Aug 12 13:07:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPTsh-0003X9-BH
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 13:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156AbbHLLHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 07:07:34 -0400
Received: from mout.gmx.net ([212.227.15.19]:54081 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751182AbbHLLHd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 07:07:33 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LpsIh-1Yv7TA49dX-00fl7e; Wed, 12 Aug 2015 13:07:32
 +0200
In-Reply-To: <55CA6066.5070500@kdbg.org>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:GhPLXD+Vm0ogovHiTnmeAOcRCponK6+UAj3VMkwGLhruLJ/VlA0
 1atZCwt/nvesWt8f41R6CVPYxdgbTZKL/g39/DAeYlLzcGiqg12xVwnOGmhfdT1UcZbrNYp
 +w9ORpJkFP0bbMeEft4FUJaySU/ex+Oky5ELWbMd4E0GiZZ0A+QPeIQ356zNHHpiSGYF+PZ
 aZaMe2N9XEJ4SfL0uImqA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IKSMAVt6iG8=:hIlD3NtYaBOIXrQf6L+rKN
 j80g716ogcE3BMoWjIRm/W/2BKdvVnQ4Xtdz/6IxxVojbI5wO/TO7cbrkqauMA6NbkROp7bY7
 BaD/Zg4RZl+h9kb0Wm8hEkhUFf77F8GPcayv8W4sZPUC/1sbpXhF4dq34l+CFbdGNU9phyrwT
 EaifqibHlj4WttTnCrB7YohasqNwyq2F0XGdFijY2h6S9skHI+fLLt5xK2jD5GlBDBamC31me
 0V+WK2mohNMNjyFFX/qeVEXZ45udzKtQPsbcEuvLpWjM98VH3MwTQUaX3qoLidkr4c41ssZNi
 i4eNlboM2vaAyKF+IVg8VmWadIComILh2WdHBORwpNH0XZFHJhU6+xDtBg9iR7R/Sm8qYJNXs
 HIyiIBDPWM7fapMq7K0OZEAN6wkBmmIr/jCca3v7GlsjX828l5Hecu9f8h5LBsl6HoEKjTWYX
 TTzAK2i6dADuPKUDunRZEK7k1xBozIX4oPbalqJyKOM+l+gUNcqeDCI8RCwn+vPnITC80Vwdn
 S6Sg5UMoYmGd+0dVZgoNsrtIomVk4QGeeRWtw7YOy2Iqo0yUul5kooNfLsa9wsItekggiMgVA
 nZNzKO4dRZGaBE63mr6ETxiJJxd+Fg8K8FUYadaMqUhSlRhqolyLWQEY7VYRthiruAjYBTda3
 uZG+kacrneYGdt8zajjjTVLq8s44aAHMN4Vdht8sFLM6dauVGHiorfLvb5dx07dkd1KHt3WmI
 3j3NpdP+oz6Ipa915ieB+FElzxb6rjDZpSeykw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275758>

Hi Johannes,

On 2015-08-11 22:51, Johannes Sixt wrote:
> Invoking plink requires special treatment, and we have support and even
> test cases for the commands 'plink' and 'tortoiseplink'. We also support
> .exe variants for these two and there is a test for 'plink.exe'.
> 
> On Windows, however, where support for plink.exe would be relevant, the
> test case fails because it is not possible to execute a file with a .exe
> extension that is actually not a binary executable---it is a shell
> script in our test. We have to disable the test case on Windows.

Oh how would I wish you were working on Git for Windows even *just* a bit *with* me. At least I would wish for a more specific description of the development environment, because it sure as hell is not anything anybody can download and install as easily as Git for Windows' SDK.

FWIW Git for Windows has this patch (that I wanted to contribute in due time, what with being busy with all those tickets) to solve the problem mentioned in your patch in a different way:

https://github.com/git-for-windows/git/commit/2fff4b54a0d4e5c5e2e4638c9b0739d3c1ff1e45

Please read this as my vote not to remove the test cases.

Thanks,
Johannes
