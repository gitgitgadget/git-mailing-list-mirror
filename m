From: guangai.che@travelzen.com
Subject: cherry-pick lost
Date: Wed, 18 Jun 2014 18:54:44 +0800 (CST)
Message-ID: <581006621.1669726.1403088884141.JavaMail.zimbra@travelzen.com>
References: <1958581451.1669669.1403088403521.JavaMail.zimbra@travelzen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 13:04:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxDfc-0007r2-Nr
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 13:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965895AbaFRLEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 07:04:44 -0400
Received: from shmail1.travelzen.com ([211.152.60.62]:45100 "EHLO
	shmail1.travelzen.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965874AbaFRLEo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 07:04:44 -0400
X-Greylist: delayed 579 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Jun 2014 07:04:43 EDT
Received: from localhost (localhost [127.0.0.1])
	by shmail1.travelzen.com (Postfix) with ESMTP id 65375872C08
	for <git@vger.kernel.org>; Wed, 18 Jun 2014 18:54:58 +0800 (CST)
Received: from shmail1.travelzen.com ([127.0.0.1])
	by localhost (shmail1.travelzen.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id FB6AFjb_GSCi for <git@vger.kernel.org>;
	Wed, 18 Jun 2014 18:54:44 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
	by shmail1.travelzen.com (Postfix) with ESMTP id 602FC87355A
	for <git@vger.kernel.org>; Wed, 18 Jun 2014 18:54:44 +0800 (CST)
X-Virus-Scanned: amavisd-new at travelzen.com
Received: from shmail1.travelzen.com ([127.0.0.1])
	by localhost (shmail1.travelzen.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tSZJ-A5mEb-i for <git@vger.kernel.org>;
	Wed, 18 Jun 2014 18:54:44 +0800 (CST)
Received: from shmail1.travelzen.com (shmail1.travelzen.com [192.168.30.30])
	by shmail1.travelzen.com (Postfix) with ESMTP id 3E9CD873552
	for <git@vger.kernel.org>; Wed, 18 Jun 2014 18:54:44 +0800 (CST)
In-Reply-To: <1958581451.1669669.1403088403521.JavaMail.zimbra@travelzen.com>
X-Originating-IP: [192.168.30.30]
X-Mailer: Zimbra 8.0.6_GA_5922 (ZimbraWebClient - GC34 (Linux)/8.0.6_GA_5922)
Thread-Topic: cherry-pick lost
Thread-Index: QzkCA/DFEXp6hTj1+l7wi3eVtAAm7w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251977>

Hi:

  I delete a file and push to master branch, after code reviewing in gerrit, then click 'Cherry Pick To' button to cherry-pick to release/1.1 branch, and then code review and merge...

but now, the cherry-pick commit seems being lost, the should be deleted file is still on release/1.1 branch.

I have encountered this circumstance twice.
