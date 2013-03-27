From: Charlie Smurthwaite <charlie@atechmedia.com>
Subject: Segfault with merge-tree on multiple Git versions
Date: Wed, 27 Mar 2013 15:29:29 +0000
Message-ID: <51531059.8000407@atechmedia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 27 16:36:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKsOy-000079-IO
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 16:36:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365Ab3C0PgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 11:36:04 -0400
Received: from smtp.atechmedia.net ([109.104.109.18]:33936 "EHLO
	smtp.atechmedia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752321Ab3C0PgB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Mar 2013 11:36:01 -0400
X-Greylist: delayed 388 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Mar 2013 11:36:01 EDT
Received: by smtp.atechmedia.net (Postfix, from userid 2002)
	id 84317C0215; Wed, 27 Mar 2013 15:27:51 +0000 (GMT)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on smtp.atechmedia.net
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,HELO_NO_DOMAIN
	autolearn=no version=3.3.1
Received: from exchange.atechmedia.net (exchange.atechmedia.net [109.104.109.9])
	by smtp.atechmedia.net (Postfix) with ESMTP id 37645C0211
	for <git@vger.kernel.org>; Wed, 27 Mar 2013 15:27:51 +0000 (GMT)
Received: from [IPv6:2a01:348:311:2:98d8:7ad8:33d4:9b08]
 (2a01:348:311:2:98d8:7ad8:33d4:9b08) by exchange.atechmedia.net
 (2001:9d8:2005:1::9) with Microsoft SMTP Server (TLS) id 14.1.438.0; Wed, 27
 Mar 2013 15:29:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
X-Originating-IP: [2a01:348:311:2:98d8:7ad8:33d4:9b08]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219257>

I am experiencing a segmentation fault in various versions of Git using
different repositories. Specifically, I have reproduced it using a
public repo and the latest stable Git version. Other repos trigger the
error on different versions.

Full info can be found below. Thanks,

Charlie


Test repository:
https://github.com/atech/mail

Test Command
git merge-tree 26bb22a052fef9f74063afd4fc6fc11fe200b19f
8d6bdf012941d876b2279994e02f1bb0d5c26e7d
d5ef97ac407d945f231cd7c8fb1cfe48b3a12083

Environment:
Linux codebase-staging 2.6.32-41-server #91-Ubuntu SMP Wed Jun 13
11:58:56 UTC 2012 x86_64 GNU/Linux

Git:
git version 1.8.2

Output:
charlie@codebase-staging:~/mail$ git merge-tree
26bb22a052fef9f74063afd4fc6fc11fe200b19f
8d6bdf012941d876b2279994e02f1bb0d5c26e7d
d5ef97ac407d945f231cd7c8fb1cfe48b3a12083
Segmentation fault



Charlie Smurthwaite aTech Media

tel. 01202 901 222 (ext. 603) email. charlie@atechmedia.com<mailto:charlie@atechmedia.com> web. atechmedia.com<http://atechmedia.com>

aTech Media Limited is a registered company in England and Wales. Registration Number 5523199. Registered Office: Unit 9 Winchester Place, North Street, Poole, Dorset, BH15 1NX. VAT Registration Number: GB 868 861 560. This e-mail is confidential and for the intended recipient only. If you are not the intended recipient, be advised that you have received this e-mail in error and that any use, dissemination, forwarding, printing, or copying of this e-mail is prohibited. If you have received this e-mail in error, please notify the sender.
