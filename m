From: Jeremy Huddleston <jeremyhu@apple.com>
Subject: 1.7.3.4 build regression
Date: Thu, 16 Dec 2010 19:31:19 -0800
Message-ID: <8779CB66-03D3-4EC9-8650-521532112CA5@apple.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 17 04:31:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTR2q-0000fU-M5
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 04:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828Ab0LQDbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 22:31:34 -0500
Received: from cloud.CS.Berkeley.EDU ([128.32.36.234]:33754 "EHLO
	mail.outersquare.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821Ab0LQDbc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Dec 2010 22:31:32 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.outersquare.org (Postfix) with ESMTP id 18B7E54110
	for <git@vger.kernel.org>; Thu, 16 Dec 2010 19:31:32 -0800 (PST)
X-Virus-Scanned: amavisd-new at mail.outersquare.org
Received: from mail.outersquare.org ([127.0.0.1])
	by localhost (mail.outersquare.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VkBPtqUthvBC for <git@vger.kernel.org>;
	Thu, 16 Dec 2010 19:31:22 -0800 (PST)
Received: from 75-144-255-90-sfba.hfc.comcastbusiness.net (75-144-255-90-SFBA.hfc.comcastbusiness.net [75.144.255.90])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: jeremy@mail.outersquare.org)
	by mail.outersquare.org (Postfix) with ESMTPSA id E69B2540FE
	for <git@vger.kernel.org>; Thu, 16 Dec 2010 19:31:20 -0800 (PST)
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163857>

1.7.3.4 seems to have a regression (over 1.7.3.2 ... didn't try 1.7.3.3) building.  I do:
make
(strip the built executables)
make install

During 'make install', the executables get remade even though they shouldn't be.  My guess is that a Makefile dependency cycle has been added, but I haven't looked into it in detail yet.  Is this a known issue?
