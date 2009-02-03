From: "Bisani, Alok" <alok.bisani@credit-suisse.com>
Subject: git rebase -i onto HEAD~n
Date: Tue, 3 Feb 2009 15:32:35 -0000
Message-ID: <C5E2CAEE4A87D24DAB5334F62A72D1F43ADC9D@ELON17P32001A.csfb.cs-group.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 03 16:34:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUNIF-0007ix-8X
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 16:34:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157AbZBCPdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 10:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752024AbZBCPdD
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 10:33:03 -0500
Received: from mail-gw18.credit-suisse.com ([198.240.130.183]:43067 "EHLO
	nys17a-3003.corpny.csfb.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751907AbZBCPdB convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 3 Feb 2009 10:33:01 -0500
Received: by nys17a-3003.corpny.csfb.com; Tue, 3 Feb 2009 10:32:55 -0500 (EST) 
X-Server-Uuid: 4EAC7D12-E00D-46D7-91F2-2C1B0FAC6618
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git rebase -i onto HEAD~n
thread-index: AcmGFJvSEZJUgf20TqmNgI9uRTrf2g==
X-OriginalArrivalTime: 03 Feb 2009 15:32:36.0363 (UTC)
 FILETIME=[A3E065B0:01C98614]
X-WSS-ID: 6596BC130ZK46514-07-05
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108199>

Hi,

Is it possible to use git rebase -i for the following use case, in a
local branch?

$ git reset --soft HEAD~3
$ # magically squash HEAD~2 & HEAD, ignoring HEAD~1 (which should be
discarded)
$ git commit -m "new commit replacing current HEAD~2 HEAD, without the
commit HEAD~1 (to be discarded)"

I get the error below.

    grep: /home/user/project/.git/rebase-merge/done: No such file or
directory
    Cannot 'squash' without a previous commit

Or could you please suggest another command which is meant to this.

I must mention, that HEAD~3, in my case is the first commit, but I don't
think that makes any difference.

$ git --version
git version 1.6.0

Best regards,
Alok

==============================================================================
Please access the attached hyperlink for an important electronic communications disclaimer: 

http://www.credit-suisse.com/legal/en/disclaimer_email_ib.html
==============================================================================
