From: Andi Kleen <andi@firstfloor.org>
Subject: Fix the bitrotted profile feedback build
Date: Fri,  4 Jul 2014 16:43:47 -0700
Message-ID: <1404517432-25185-1-git-send-email-andi@firstfloor.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 05 01:45:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X3DA9-0006Io-8X
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jul 2014 01:45:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760293AbaGDXow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2014 19:44:52 -0400
Received: from one.firstfloor.org ([193.170.194.197]:53376 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760262AbaGDXou (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2014 19:44:50 -0400
Received: from basil.firstfloor.org (184-100-237-164.ptld.qwest.net [184.100.237.164])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by one.firstfloor.org (Postfix) with ESMTPSA id 289768677D
	for <git@vger.kernel.org>; Sat,  5 Jul 2014 01:44:48 +0200 (CEST)
Received: by basil.firstfloor.org (Postfix, from userid 1000)
	id 13481A1891; Fri,  4 Jul 2014 16:43:59 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252908>

The profile feedback build support had bitrotted. This patchkit fixes
it and improves it slightly by adding a new profile-fast target.

-Andi
