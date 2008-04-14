From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Interaction between clean/smudge and git status
Date: Mon, 14 Apr 2008 09:21:43 +0200
Message-ID: <48030607.60603@viscovery.net>
References: <loom.20080413T231611-113@post.gmane.org> <4802FE3C.4090306@viscovery.net> <7vej98apdo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Sergio Callegari <sergio.callegari@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 09:22:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlJ1M-0004sc-SG
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 09:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752401AbYDNHVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 03:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbYDNHVs
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 03:21:48 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:26901 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507AbYDNHVs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 03:21:48 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JlJ0a-0001o4-BS; Mon, 14 Apr 2008 09:21:44 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 205CCAFCC; Mon, 14 Apr 2008 09:21:44 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vej98apdo.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79477>

Junio C Hamano schrieb:
> Johannes Sixt <j.sixt@viscovery.net> writes:
>> I've observed this, too, and I don't think it is expected behavior. But it
>> hasn't annoyed me enough to look at it in depth. Eventually I will, and I
>> hope to find out what's wrong. ;)
> 
> Are you recreating the .zip file in the filter in such a way that a file
> with the same contents results in byte-to-byte identical .zip file?
> Otherwise as far as git is concerned you have changed the file in the work
> tree.

In my case, there is only a "clean" filter, and it rearranges the lines of
a particular type of text files in a canonical way. Hmm, I can't reproduce
the unwanted behavior in quick test now. I'll come back to this issue if
it shows up again.

-- Hannes
