From: Frans Pop <elendil@planet.nl>
Subject: git-send-email generates mail with invalid Message-Id
Date: Tue, 28 Jul 2009 04:46:22 +0200
Message-ID: <200907280446.22890.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 04:46:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVci1-0002mU-7p
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 04:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111AbZG1CqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 22:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752095AbZG1CqZ
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 22:46:25 -0400
Received: from Cpsmtpm-eml107.kpnxchange.com ([195.121.3.11]:60368 "EHLO
	CPSMTPM-EML107.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751984AbZG1CqZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jul 2009 22:46:25 -0400
Received: from aragorn.fjphome.nl ([84.85.147.182]) by CPSMTPM-EML107.kpnxchange.com with Microsoft SMTPSVC(7.0.6001.18000);
	 Tue, 28 Jul 2009 04:46:23 +0200
User-Agent: KMail/1.9.9
Content-Disposition: inline
X-OriginalArrivalTime: 28 Jul 2009 02:46:23.0857 (UTC) FILETIME=[986AEE10:01CA0F2D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124208>

I follow lkml through a local news server (inn2), using a mail2news script 
to convert incoming mails to news items.

Occasionally I get the following error in my system logs:
innd: localhost:18 bad_messageid <12487185672026-git-send-email->

The problem is that a Message-Id is supposed (RFC 822) to end in a domain 
part (...@example.com), but that's missing.

I assume that this is a configuration issue in the git setup of the 
sender, but shouldn't git-send-email refuse to send out messages with an 
invalid Message-Id?

Cheers,
FJP
