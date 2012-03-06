From: "David A. Greene" <dag@cray.com>
Subject: Re: [PATCH 2/2] Support Out-Of-Tree Valgrind Tests
Date: Tue, 6 Mar 2012 16:54:31 -0600
Message-ID: <87r4x5e3x4.fsf@smith.obbligato.org>
References: <1330903437-31386-1-git-send-email-greened@obbligato.org>
	<1330903437-31386-2-git-send-email-greened@obbligato.org>
	<87aa3vzdoc.fsf@thomas.inf.ethz.ch>
	<nngy5re29zn.fsf@transit.us.cray.com>
	<878vje86cy.fsf@thomas.inf.ethz.ch>
	<87mx7tiyhh.fsf@smith.obbligato.org>
	<7vaa3ttvj1.fsf@alter.siamese.dyndns.org>
	<87hay1fkfk.fsf@smith.obbligato.org>
	<7vboo9qskb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: "David A. Greene" <dag@cray.com>, Thomas Rast <trast@inf.ethz.ch>,
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 23:57:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S53K2-0001dv-6O
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 23:57:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031446Ab2CFW53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 17:57:29 -0500
Received: from exprod6og106.obsmtp.com ([64.18.1.191]:48969 "EHLO
	exprod6og106.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031133Ab2CFW53 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 17:57:29 -0500
Received: from CFWEX01.americas.cray.com ([136.162.34.11]) (using TLSv1) by exprod6ob106.postini.com ([64.18.5.12]) with SMTP
	ID DSNKT1aWUU5Z9SLaUInKtx+AUbsbkvWOqiL4@postini.com; Tue, 06 Mar 2012 14:57:29 PST
Received: from smith.obbligato.org (192.168.233.145) by
 CFWEX01.americas.cray.com (172.30.88.25) with Microsoft SMTP Server (TLS) id
 14.1.355.2; Tue, 6 Mar 2012 16:57:20 -0600
In-Reply-To: <7vboo9qskb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 6 Mar 2012 14:21:24 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192411>

Junio C Hamano <gitster@pobox.com> writes:

>>> Could it be that the reason for the breakage is because you are
>>> setting TEST_DIRECTORY to the directory that contains out-of-tree
>>> tests, instead of $GIT_BUILD_DIR/t/ directory?
>>
>> Well, yes.  I thought that's what out-of-tree tests are supposed to do.
>> They don't live in $GIT_BUILD_DIR/t/ after all.
>>
>> Perhaps I've misunderstood how the test system is supposed to work.  A
>> table as you described in README would be most helpful.  I thought
>> TEST_DIRECTORY is supposed to point to where the tests to run are
>> located.
>>
>>> Shouldn't TEST_DIRECTORY merely a short-hand for GIT_BUILD_DIR/t?
>>> What do you find relative to $TEST_DIRECTORY that cannot be found
>>> relative to GIT_BUILD_DIR/t?
>>
>> If that's what TEST_DIRECTORY is supposed to be, always, then it should
>> be stated in the comments and README.  I had no idea this was an
>> invariant.
>>
>> Thanks for clarifying!
>
> Not so fast. The questions in the message you are responding to were
> not rhetorical.

Ah, ok.  I don't think I have the proper guru status to answer them.  :)
Regardless, it seems we need some documentation on what each of these
variables is.

                           -Dave
