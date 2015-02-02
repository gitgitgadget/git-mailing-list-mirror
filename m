From: Yue Lin Ho <yuelinho777@gmail.com>
Subject: Re: [RFC PATCH] diff: do not use creation-half of -B as a rename
 target candidate
Date: Sun, 1 Feb 2015 23:47:47 -0700 (MST)
Message-ID: <1422859667830-7624836.post@n2.nabble.com>
References: <xmqqegqaahnh.fsf@gitster.dls.corp.google.com> <xmqqfvapuhkk.fsf@gitster.dls.corp.google.com> <54CF1089.6020804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 07:47:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIAnZ-0005wz-01
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 07:47:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbbBBGrs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 01:47:48 -0500
Received: from mwork.nabble.com ([162.253.133.43]:56962 "EHLO mwork.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932283AbbBBGrs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 01:47:48 -0500
Received: from mjim.nabble.com (unknown [162.253.133.84])
	by mwork.nabble.com (Postfix) with ESMTP id 2D6B51286EE9
	for <git@vger.kernel.org>; Sun,  1 Feb 2015 22:47:48 -0800 (PST)
In-Reply-To: <54CF1089.6020804@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263251>

A1 = "I am file A."
B1 is copied from A1, so B1 = "I am file A."
B1 changes to B2 = "I am file B."
A1 changes to A2 = "file A is changed a lot, a lot, ..., a lot."
At this moment, commit A2 and B2 files.





--
View this message in context: http://git.661346.n2.nabble.com/Git-BUG-Please-do-not-use-B-M-in-diff-family-for-now-tp7624794p7624836.html
Sent from the git mailing list archive at Nabble.com.
