From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: combined diff, but not condensed, howto?
Date: Thu, 18 Sep 2008 07:57:11 +0200
Message-ID: <48D1EDB7.5070107@viscovery.net>
References: <48D0B907.7040903@viscovery.net> <7vwsha6761.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 07:58:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgCX1-0006A9-9G
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 07:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbYIRF5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 01:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbYIRF5P
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 01:57:15 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:10612 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbYIRF5P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 01:57:15 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KgCVs-0008Kx-3A; Thu, 18 Sep 2008 07:57:12 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A5DF94FB; Thu, 18 Sep 2008 07:57:11 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vwsha6761.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96161>

Junio C Hamano schrieb:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> After a merge conflict, 'git diff' shows a combined diff, which presents
>> only the parts that conflicted or where there are near-by changes from
>> different parents (potential conflicts). Is there a command line switch so
>> that *all* changes are shown, even non-conflicting ones?
> 
> Like "git diff HEAD"?

No. Something that produces

@@@ -23,5 -23,5 +23,7 @@@
  A
  B
++<<<<<<< HEAD:foo
 +C
++=======
+ D
++>>>>>>> 97d7fee2cb068f215a593c6e5623b265db45d3bc:foo
  E
  F
@@@ -50,4 -50,5 +53,5 @@@
  G
  H
 +I
  J
  K
@@@ -60,5 -61,4 +63,4 @@@
  L
  M
- N
  O
  P
