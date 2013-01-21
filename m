From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: Re: [PATCH v3 0/2] Make git-svn work with gitdir links
Date: Mon, 21 Jan 2013 15:19:19 +0100
Message-ID: <kdjip9$4j7$1@ger.gmane.org>
References: <20120308005103.GA27398@dcvr.yhbt.net> <1358731322-44600-1-git-send-email-barry.wardell@gmail.com> <7vwqv7i9su.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 21 15:20:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxIEE-0003KB-Ci
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 15:20:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635Ab3AUOTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 09:19:36 -0500
Received: from plane.gmane.org ([80.91.229.3]:51127 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752458Ab3AUOTf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 09:19:35 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TxIE3-0003Ae-AW
	for git@vger.kernel.org; Mon, 21 Jan 2013 15:19:51 +0100
Received: from dsdf-4db5d717.pool.mediaways.net ([77.181.215.23])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 21 Jan 2013 15:19:51 +0100
Received: from jojo by dsdf-4db5d717.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 21 Jan 2013 15:19:51 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsdf-4db5d717.pool.mediaways.net
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214121>

Junio C Hamano wrote:
> Barry Wardell <barry.wardell@gmail.com> writes:
>
>> These patches fix a bug which prevented git-svn from working with
>> repositories which use gitdir links.
>>
>> Changes since v2:
>>  - Rebased onto latest master.
>>  - Added test case which verifies that the problem has been fixed.
>>  - Fixed problems with git svn (init|clone|multi-init).
>>  - All git-svn test cases now pass (except two in t9101 which also
>>    failed before these patches).
>>
>> Barry Wardell (2):
>>   git-svn: Add test for git-svn repositories with a gitdir link
>>   git-svn: Simplify calculation of GIT_DIR
>
> Thanks for your persistence ;-) As this is a pretty old topic, I'll
> give two URLs for people who are interested to view the previous
> threads:
>
>    http://thread.gmane.org/gmane.comp.version-control.git/192133
>    http://thread.gmane.org/gmane.comp.version-control.git/192127
>
> You would want to mark it as test_expect_failure in the first patch
> and then flip it to text_expect_success in the second patch where
> you fix the breakage?  Otherwise, after applying the first patch,
> the testsuite will break needlessly.

I'd just apply them the other way round, 1st fix the problem, 2nd add a test 
for it

Bye, Jojo 
