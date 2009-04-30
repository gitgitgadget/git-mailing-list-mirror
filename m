From: Christoph Duelli <duelli@melosgmbh.de>
Subject: finding the commit that deleted a file
Date: Thu, 30 Apr 2009 09:31:08 +0200
Message-ID: <49F953BC.7070303@melosgmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 30 09:33:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzQmE-0007mj-GF
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 09:33:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968AbZD3Hdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 03:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbZD3Hdk
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 03:33:40 -0400
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:49731 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbZD3Hdj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 03:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1241076817; l=397;
	s=domk; d=melosgmbh.de;
	h=Content-Transfer-Encoding:Content-Type:Subject:To:MIME-Version:From:
	Date:X-RZG-CLASS-ID:X-RZG-AUTH;
	bh=iP+ThbIW1tUrxo6IqLynEmNPJQM=;
	b=fWdkqdamiWZ45dMOkl8YWUWJXk+ITMSCUSitqs0CiUR6+nlr889FOadKJU92f5D+mHR
	LbywZa7vCqvV5dwmm/Nuv2uo6lMOyLnYA+f6zFo4lW++6piZ2fYuSjzdqQBJbxmHSFL/I
	kWN64nxqtEX1/YeGHWhwFbdJ8djyDn/TAu8=
X-RZG-AUTH: :P2kWY0mrft+7PRqjQVQfkgnIveo2zsFMc4bua7BlzFdpPx7kEk2N74DOz34elah7
X-RZG-CLASS-ID: mo00
Received: from mail.melosgmbh.de
	(186.146.179.213-static.augustakom.net [213.179.146.186])
	by post.strato.de (klopstock mo24) (RZmta 18.31)
	with ESMTP id v03e36l3U6ll1M for <git@vger.kernel.org>;
	Thu, 30 Apr 2009 09:33:36 +0200 (MEST)
X-Spam-Status: No, hits=0.0 required=4.0
	tests=AWL: 0.036,BAYES_00: -1.665,TOTAL_SCORE: -1.629
X-Spam-Level: 
Received: from [172.27.1.229] ([172.27.1.229])
	(authenticated user duelli@melosgmbh.de)
	by mail.melosgmbh.de (Kerio MailServer 6.6.2)
	for git@vger.kernel.org;
	Thu, 30 Apr 2009 09:35:07 +0200
User-Agent: Thunderbird 2.0.0.21 (X11/20090302)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117994>

Following scenario:
Some file x was deleted (or renamed, but the --follow option does not 
succeed) some 100 commits ago.
Now, I would like to check the 'lost' contents for some reason.

Is it possible to find out when a given file (path) was deleted?
(And then, with the obtained SHA1, use gitk or some such tool to inspect 
  this file.)

Thank you.

Best regards
-- 
Christoph Duelli
