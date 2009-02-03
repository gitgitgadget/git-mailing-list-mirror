From: "Bisani, Alok" <alok.bisani@credit-suisse.com>
Subject: RE: git rebase -i onto HEAD~n
Date: Tue, 3 Feb 2009 18:00:39 -0000
Message-ID: <C5E2CAEE4A87D24DAB5334F62A72D1F43ADCA2@ELON17P32001A.csfb.cs-group.com>
References: <C5E2CAEE4A87D24DAB5334F62A72D1F43ADC9D@ELON17P32001A.csfb.cs-group.com>
 <20090203154457.GA6859@atjola.homenet>
 <C5E2CAEE4A87D24DAB5334F62A72D1F43ADCA0@ELON17P32001A.csfb.cs-group.com>
 <20090203170457.GB6859@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "=?iso-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 03 19:02:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUPbY-0000JW-Iz
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 19:02:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbZBCSBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 13:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbZBCSBL
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 13:01:11 -0500
Received: from mail-gw17.credit-suisse.com ([198.240.130.182]:53718 "EHLO
	nys17a-3002.corpny.csfb.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751010AbZBCSBK convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 3 Feb 2009 13:01:10 -0500
Received: by nys17a-3002.corpny.csfb.com; Tue, 3 Feb 2009 13:00:42 -0500 (EST) 
X-Server-Uuid: 451BAB89-5416-43D7-AAFC-AFA88B572C1F
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <20090203170457.GB6859@atjola.homenet>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git rebase -i onto HEAD~n
thread-index: AcmGIatQJikOHkakTTCraAJqo01urgAAkmpA
X-OriginalArrivalTime: 03 Feb 2009 18:00:40.0295 (UTC)
 FILETIME=[531CD770:01C98629]
X-WSS-ID: 659659C245027939-01-05
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108231>

>On 2009.02.03 16:22:22 -0000, Bisani, Alok wrote:
>> >And in the editor:
>> >pick HEAD~2
>> >squash HEAD
>> 
>>     # Leave editor for ~/gittest/.git/rebase-merge/git-rebase-todo with
>>     squash 8df4c33 two
>>     # deleted line with discard
>>     squash 91f8267 three
>
>Notice the difference? You're trying to squash 8df4cee into nothing. And _if_ that would work, it would still squash 8df4c33 into the previous commit, which is not what you wanted anyway.

Yes, it is clear now. Thank you. And actually, the help page http://www.kernel.org/pub/software/scm/git/docs/git-rebase.html states this clearly as well: 'If you want to fold two or more commits into one, replace the command "pick" with "squash" for the *second_and_subsequent* commit.'

However, I _did_ want to squash 8df4c33 (HEAD~2) etc, into HEAD~3 (the first commit). But unfortunately I cannot do $ git rebase -i  HEAD~4, as HEAD~3 is the first commit. Although, I understand that it will hardly be ever used in practise.

Is there a way to have git rebase --amend the --onto commit?

Best regards,
Alok

==============================================================================
Please access the attached hyperlink for an important electronic communications disclaimer: 

http://www.credit-suisse.com/legal/en/disclaimer_email_ib.html
==============================================================================
