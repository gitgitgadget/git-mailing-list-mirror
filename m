From: drafnel@gmail.com
Subject: [PATCH 0/3] leave unreferenced objects unpacked
Date: Fri,  9 May 2008 23:01:54 -0500
Message-ID: <5119086.1210392044037.JavaMail.teamon@b303.teamon.com>
References: <7vabj0b1re.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat May 10 06:02:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JugHv-0000Ax-Dx
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 06:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbYEJEBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 00:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbYEJEBV
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 00:01:21 -0400
Received: from mailproxy03.teamon.com ([64.85.68.139]:44597 "EHLO
	b303.teamon.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750885AbYEJEBA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 00:01:00 -0400
Received: from b303.teamon.com (localhost [127.0.0.1])
	by b303.teamon.com (8.11.7 DSN_MOD/8.11.7) with ESMTP id m4A40iU18306;
	Sat, 10 May 2008 04:00:44 GMT
X-Mailer: git-send-email 1.5.5.67.g9a49
In-Reply-To: <7vabj0b1re.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81648>

Here is a formal patch. I removed the first invocation of
unpack-objects since I think it is unneccessary.

Followed up with mods to git-gc.

-brandon
