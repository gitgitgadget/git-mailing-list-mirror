From: samt <sam777t@gmail.com>
Subject: sparse checkout syntax does not work in git version 1.9.5.msysgit.0
Date: Mon, 23 Feb 2015 15:41:04 -0700 (MST)
Message-ID: <1424731264183-7625887.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 23:41:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQ1gd-0007v8-1g
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 23:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752493AbbBWWlG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 17:41:06 -0500
Received: from mwork.nabble.com ([162.253.133.43]:52307 "EHLO mwork.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752028AbbBWWlE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 17:41:04 -0500
Received: from mjim.nabble.com (unknown [162.253.133.84])
	by mwork.nabble.com (Postfix) with ESMTP id 4493314CB032
	for <git@vger.kernel.org>; Mon, 23 Feb 2015 14:41:04 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264303>

The platform is Windows server 2008
Git version is 1.9.5.msysgit.0

I have a repository and I want EVERYTHING in the repository to be checked
out into the workspace EXCEPT one directory.  I have a machine with  git
version 1.7.8.msysgit.0 and the following syntax in
.git/info/sparse-checkout file works fine:

/*
!engine/testdata/scenarios

This syntax does not seem to work with 1.9.5.msysgit.0  version. I have
tried to alter the syntax based on some suggestions on the internet, but
none of the combinations work. Git still attempts to checkout the directory
that I do not want.  Does anyone know what syntax works for version
1.9.5.msysgit.0 ? Thanks.



--
View this message in context: http://git.661346.n2.nabble.com/sparse-checkout-syntax-does-not-work-in-git-version-1-9-5-msysgit-0-tp7625887.html
Sent from the git mailing list archive at Nabble.com.
