From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: t3010 broken by 2eac2a4
Date: Wed, 21 Aug 2013 16:31:56 -0400
Message-ID: <82078845-3AB9-4B36-9130-039CC33C8A7A@gernhardtsoftware.com>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 21 22:32:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCF55-0006rd-UR
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 22:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752745Ab3HUUcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 16:32:36 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:56317 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235Ab3HUUcf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Aug 2013 16:32:35 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id B00B527361DC; Wed, 21 Aug 2013 20:32:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.5 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from dhcp-10-4-2-155.wireless.rochester.edu (u-of-rochester-128-151-150-1.wireless.rochester.edu [128.151.150.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 6A72727361A9
	for <git@vger.kernel.org>; Wed, 21 Aug 2013 20:32:06 +0000 (UTC)
X-Mailer: Apple Mail (2.1508)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232727>

With 2eac2a4: "ls-files -k: a directory only can be killed if the index has a non-directory" applied, t3010 fails test 3 "validate git ls-files -k output".  It ends up missing the pathx/ju/nk file.

OS X 10.8.4
Xcode 4.6.3
clang "Apple LLVM version 4.2 (clang-425.0.28) (based on LLVM 3.2svn)" 

~~ Brian Gernhardt
