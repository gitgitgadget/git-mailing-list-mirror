From: Kumar Gala <galak@kernel.crashing.org>
Subject: reducing object store size with remote alternates or shallow clone?
Date: Tue, 24 Aug 2010 01:59:11 -0500
Message-ID: <14526ED4-F65C-4DF2-ABDD-BF1E76DAC2B0@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 24 08:59:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnnTp-0005mB-Bg
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 08:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752975Ab0HXG7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 02:59:16 -0400
Received: from gate.crashing.org ([63.228.1.57]:47282 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751683Ab0HXG7P convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Aug 2010 02:59:15 -0400
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id o7O6xCvp022521
	for <git@vger.kernel.org>; Tue, 24 Aug 2010 01:59:13 -0500
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154299>

I'm trying to package a linux kernel source tree and would like to just tar up a tree with .git/.  However this is a bit problematic as the size of tgz is about 500M which exceeds the limit of the image I'm trying to produce.

I was wondering if anyone had a means to reduce the size drastically.  I'm ok if a post processing step is required to get full git support.  One idea I had was doing a shallow clone and if there was some means to "reconnect" it to a full work state after the fact.

thanks

- k