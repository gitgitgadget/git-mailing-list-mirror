From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH 1/3 v5] diff --stat: tests for long filenames and big
 change counts
Date: Thu, 16 Feb 2012 10:57:44 +0100
Message-ID: <4F3CD318.1040600@in.waw.pl>
References: <7vpqdg3n7z.fsf@alter.siamese.dyndns.org> <1329303808-16989-1-git-send-email-zbyszek@in.waw.pl> <7vvcn810ml.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 16 10:58:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rxy6D-0008Bh-HW
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 10:58:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763Ab2BPJ5x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Feb 2012 04:57:53 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:52694 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751373Ab2BPJ5w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 04:57:52 -0500
Received: from amanda.fuw.edu.pl ([193.0.82.254] helo=[192.168.121.139])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1Rxy62-0001GV-5R; Thu, 16 Feb 2012 10:57:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20120104 Icedove/8.0
In-Reply-To: <7vvcn810ml.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190890>

On 02/15/2012 06:12 PM, Junio C Hamano wrote:
> Zbigniew J=C4=99drzejewski-Szmek<zbyszek@in.waw.pl>  writes:
>
>> Eleven tests for various combinations of a long filename and/or big
>> change count and ways to specify widths for diff --stat.
>> ---
>
> Sign-off?

> Hrm, this does not seem to pass, making the result of applying [1/3] =
fail;
> I see that the elided name is shown much shorter than the above expec=
ts.

Hi,

I'm sorry for not properly testing the patch with tests. I somehow=20
convinced myself that the tests pass. This whole series needs more work=
,=20
even after squashing in your two patches. I'll send a new series, but=20
probably not today. (I'll try to remember the sign-off too, next time).
--
Zbyszek
