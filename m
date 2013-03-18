From: Joydeep Bakshi <joydeep.bakshi@infoservices.in>
Subject: git branch based hook desigh
Date: Mon, 18 Mar 2013 09:57:51 +0530
Message-ID: <148C5E2E-8FD6-4686-A009-57D1F403C808@infoservices.in>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 18 05:28:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHRgO-0005q8-Cn
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 05:28:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839Ab3CRE1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 00:27:50 -0400
Received: from static.88-198-19-49.clients.your-server.de ([88.198.19.49]:53441
	"EHLO zimbra.infoservices.in" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750775Ab3CRE1t convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 00:27:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.infoservices.in (Postfix) with ESMTP id 1F8CEF06B04
	for <git@vger.kernel.org>; Mon, 18 Mar 2013 09:57:48 +0530 (IST)
X-Virus-Scanned: amavisd-new at zimbra.infoservices.in
Received: from zimbra.infoservices.in ([127.0.0.1])
	by localhost (zimbra.infoservices.in [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hiXMAOjwYjPe for <git@vger.kernel.org>;
	Mon, 18 Mar 2013 09:57:47 +0530 (IST)
Received: from [192.168.1.116] (unknown [122.176.30.116])
	by zimbra.infoservices.in (Postfix) with ESMTPSA id B4BC9F06AE0
	for <git@vger.kernel.org>; Mon, 18 Mar 2013 09:57:46 +0530 (IST)
X-Mailer: Apple Mail (2.1499)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218391>

Hello list,

I have implemented git pre-received hook successfully. And it works on the repo level.
Could anyone suggest how to call branch level hook please ?