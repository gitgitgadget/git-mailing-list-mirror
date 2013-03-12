From: =?iso-8859-2?Q?Jan_Pe=B9ta?= <jan.pesta@certicon.cz>
Subject: Updating not actual branch
Date: Tue, 12 Mar 2013 14:22:00 +0100
Message-ID: <006501ce1f24$94636a30$bd2a3e90$@certicon.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 12 14:22:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFPA4-0000Gk-GL
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 14:22:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755422Ab3CLNWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 09:22:10 -0400
Received: from service.certicon.cz ([90.183.112.10]:3750 "EHLO
	service.certicon.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755278Ab3CLNWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 09:22:09 -0400
Received: from miami (c-006.certicon.cz [90.183.112.6])
	(Authenticated sender: pesta)
	by service.certicon.cz (Postfix) with ESMTPSA id B33321707C8
	for <git@vger.kernel.org>; Tue, 12 Mar 2013 14:21:59 +0100 (CET)
X-Mailer: Microsoft Outlook 14.0
Thread-index: Ac4fJJQLfTbLFKVLQxG9E0Sc+xyjEQ==
Content-language: cs
X-certicon-MailScanner-Information: Please contact our ICT for more information
X-MailScanner-ID: B33321707C8.9784A
X-certicon-MailScanner: Found to be clean
X-certicon-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-0.2, required 5.1, autolearn=disabled, ALL_TRUSTED -1.00,
	BAYES_50 0.80)
X-certicon-MailScanner-From: jan.pesta@certicon.cz
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217963>

Hi All,

I have a question if there is a posibility tu update a branch which is not
actual working copy.

I have following situation:

A - B - C - I - J                       master
               \ - D - E - F               feature 1
                                 \ G - H     feature 2 (working copy)

I would like tu update whole tree with latest changes in master

A - B - C - I - J                                              master
                           \ - D* - E* - F*                  feature 1
                                                   \ G* - H*     feature 2
(working copy)


Is there some way how to do it without swithing to each branch and update
them manually?

Thanks,
Jan
