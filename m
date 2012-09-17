From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: Re: Test failure: Test #3 in t1304-default-acl
Date: Mon, 17 Sep 2012 19:59:45 +0200
Message-ID: <k37oet$gj9$1@ger.gmane.org>
References: <CALkWK0n0bH3xPLarv35Th_agnhKCkRjgcKTJR7Xy=B_NkBHkOg@mail.gmail.com><vpqy5k8raig.fsf@grenoble-inp.fr><CALkWK0=h6iU_J=X6MFgLXPfo0rh236cTuVaU3nNSnAaikjKH5w@mail.gmail.com><vpqd31kr7v4.fsf@grenoble-inp.fr><CALkWK0=ROz8fxXgnqt-+AthU-hgq_mzFg0GhBQCrAshH_mRBPQ@mail.gmail.com><vpqvcfcps2z.fsf@grenoble-inp.fr><7v4nmwwqox.fsf@alter.siamese.dyndns.org> <vpqipbcpp69.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="Windows-1252";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 17 20:00:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDfcO-0004fq-Bf
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 20:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757115Ab2IQSAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 14:00:14 -0400
Received: from plane.gmane.org ([80.91.229.3]:60499 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757108Ab2IQSAM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 14:00:12 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TDfcE-0004cX-JW
	for git@vger.kernel.org; Mon, 17 Sep 2012 20:00:14 +0200
Received: from dsdf-4db53772.pool.mediaways.net ([77.181.55.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 20:00:14 +0200
Received: from jojo by dsdf-4db53772.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 20:00:14 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsdf-4db53772.pool.mediaways.net
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205726>

Matthieu Moy wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> I haven't been paying attention, but does that mean on that system,
>> a total stranger kseygold can write, modify, and remove whatever Ram
>> owns?  I am hoping that is not the case.
>
> I can see two reasons for having the same UID for two login names:
>
> 1) the sysadmin really messed up, and as you say, a total stranger has
> complete ownership of your files. Ramkumar, you should check that this
> is not your case.
>
> 2) the sysadmin explicitely gave two login names to the same physical
> person, as kinds of aliases for the same UID (e.g. the person got
> married, changed her name and login, but expects ~oldlogin to continue
> working). I'm not sure how common this is, and to which extend we want
> to support this in our test scripts.

On HP NonStop it is very common to have a user (form: "GROUP.USER", case 
insensitiv) and one or more aliases to them (form: "user", case sensitiv) 
the latter are very commonly used in the POSIX part of HP NonStop (call 
OSS), the one git runs in, the other are more commonly used in the 
proprietary part of the OS (called Guardian), althoug this is not a strict 
requirement.
The only thing they share is the UID.

Bye, Jojo 
