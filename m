From: jidanni@jidanni.org
Subject: log-tree.c: date hardwired
Date: Tue, 13 Jan 2009 11:13:18 +0800
Message-ID: <87r637oq41.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 13 04:14:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMZjp-0006Ds-VT
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 04:14:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682AbZAMDNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 22:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752643AbZAMDNV
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 22:13:21 -0500
Received: from sd-green-bigip-177.dreamhost.com ([208.97.132.177]:47932 "EHLO
	homiemail-a4.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752618AbZAMDNV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jan 2009 22:13:21 -0500
Received: from jidanni.org (122-127-34-152.dynamic.hinet.net [122.127.34.152])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a4.dreamhost.com (Postfix) with ESMTP id 514D740C83
	for <git@vger.kernel.org>; Mon, 12 Jan 2009 19:13:20 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105446>

In log-tree.c: printf("From %s Mon Sep 17 00:00:00 2001\n", name);
Wouldn't it be more aesthetically pleasing to use current local or UTC time?
Or at least comment in the code that the date is hardwired like that
in the fear that otherwise people will think it is the actual commit time.
No, I can't think of any other tool that hardwires the From separators
they produce.
