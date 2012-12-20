From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: Re: [PATCH] mergetools/p4merge: Honor $TMPDIR for the /dev/null placeholder
Date: Thu, 20 Dec 2012 09:20:35 +0100
Message-ID: <kauhoq$g9n$1@ger.gmane.org>
References: <1355978754-7041-1-git-send-email-davvid@gmail.com> <7v623x6xvv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 20 09:21:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlbNT-0003LE-IO
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 09:21:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403Ab2LTIU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 03:20:58 -0500
Received: from plane.gmane.org ([80.91.229.3]:54360 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751155Ab2LTIU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 03:20:57 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TlbNL-0003GX-Rw
	for git@vger.kernel.org; Thu, 20 Dec 2012 09:21:07 +0100
Received: from dsdf-4db53d15.pool.mediaways.net ([77.181.61.21])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Dec 2012 09:21:07 +0100
Received: from jojo by dsdf-4db53d15.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Dec 2012 09:21:07 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsdf-4db53d15.pool.mediaways.net
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211885>

Junio C Hamano wrote:
> David Aguilar <davvid@gmail.com> writes:
>
>> Use mktemp to create the /dev/null placeholder for p4merge.
>> This keeps it out of the current directory.
>>
>> Reported-by: Jeremy Morton <admin@game-point.net>
>> Signed-off-by: David Aguilar <davvid@gmail.com>
>> ---
>> I consider this a final finishing touch on a new 1.8.1 feature,
>> so hopefully we can get this in before 1.8.1.
>
> Does everybody have mktemp(1), which is not even in POSIX.1?

HP-NonStop doesn't have it, unless you're on the latest release, which added 
GNU coreutils.

Bye, Jojo 
