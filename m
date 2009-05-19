From: "Chris Friesen" <cfriesen@nortel.com>
Subject: any way to apply tag across all branches in repository?
Date: Tue, 19 May 2009 10:26:33 -0600
Message-ID: <4A12DDB9.60608@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 19 18:27:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6SA0-0004Yf-QK
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 18:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754307AbZESQ0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 12:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753792AbZESQ0g
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 12:26:36 -0400
Received: from zcars04e.nortel.com ([47.129.242.56]:34079 "EHLO
	zcars04e.nortel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754054AbZESQ0f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 12:26:35 -0400
Received: from zcarhxs1.corp.nortel.com (zcarhxs1.corp.nortel.com [47.129.230.89])
	by zcars04e.nortel.com (Switch-2.2.0/Switch-2.2.0) with ESMTP id n4JGPVo06660
	for <git@vger.kernel.org>; Tue, 19 May 2009 16:25:31 GMT
Received: from localhost.localdomain ([47.130.81.171] RDNS failed) by zcarhxs1.corp.nortel.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 19 May 2009 12:26:34 -0400
User-Agent: Thunderbird 2.0.0.21 (X11/20090302)
X-OriginalArrivalTime: 19 May 2009 16:26:34.0345 (UTC) FILETIME=[933CFD90:01C9D89E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119545>


Hi all,

I'm hoping you can help me out...please CC me on replies, I'm not
subscribed to the list.

We have a piece of software with a "main" branch and multiple
architecture-specific "target" branches.  At each "official" compile,
we'd like to tag the commits that went into that compile with an identifier.

Using tags normally requires that the tag be assigned to each branch
individually--is there any way to apply some sort of designator to the
head of each branch in the repository all at once rather than doing it
separately for each branch?

Thanks,

Chris
