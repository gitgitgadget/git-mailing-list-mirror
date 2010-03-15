From: "Richard Lee" <richard@webdezign.co.uk>
Subject: RE: Doing a dummy or empty merge
Date: Mon, 15 Mar 2010 18:31:55 -0000
Message-ID: <8440EA2C12E50645A68C4AA9887166513FC532@SERVER.webdezign.local>
References: <8440EA2C12E50645A68C4AA9887166513FC480@SERVER.webdezign.local><86wrxiepv3.fsf@blue.stonehenge.com><7vljdyzjsy.fsf@alter.siamese.dyndns.org> <864okmeeyd.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 15 19:32:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrF59-00025C-JD
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 19:32:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753281Ab0COSb6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 14:31:58 -0400
Received: from mail.webdezign.co.uk ([213.123.201.79]:2043 "EHLO
	webdezign.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751693Ab0COSb6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Mar 2010 14:31:58 -0400
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <864okmeeyd.fsf@blue.stonehenge.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Doing a dummy or empty merge
Thread-Index: AcrBYC/nxXZwTBwwQ1eEWc9PV9PK4wDB/DOw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142240>

>>>>> "Junio" == Junio C Hamano <gitster@pobox.com> writes:

>> After the above "merge -s ours", you obviously can never merge from
>> live to test.  You have declared that you favor the live
>> configuration over the test configuration with that merge commit, and
>> merging a branch that has that merge commit (i.e. live) into any
>> branch (i.e. test) is your consent to be bound by that declaration.
>> The resulting backmerge will wipe the test configuration and replace
>> it with that from live.

Yes I have now come across this issue. I was working on the live branch
directly as it was a small change and was easier to work with the live
platform. Now I don't have a way to merge the changes from the live
branch into the test branch without overwriting the test configuration.

>Very good point.  But a cherry-pick would work, right?

Yes a cherry-pick would work. But is there a "neater" way to do this,
possibly using merging? I prefer merging over cherry-picking because
merging will use the common ancestor so that only the succeeding commits
are taken into account. After a while, keeping track of what has and has
not been cherry-picked would be difficult.

I get the feeling there is a better way to set out my branches/workflow.
Is there a way I can have a branch for each deployment where I can merge
over any changes in either direction between any two branches? Would I
need some sort of central "vanilla" branch for this?
