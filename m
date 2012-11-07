From: Josef Wolf <jw@raven.inka.de>
Subject: git-clone and unreliable links?
Date: Wed, 7 Nov 2012 16:35:19 +0100
Message-ID: <20121107153519.GI28437@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 07 16:40:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TW7jz-0006ox-EE
	for gcvg-git-2@plane.gmane.org; Wed, 07 Nov 2012 16:40:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754165Ab2KGPkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2012 10:40:14 -0500
Received: from quechua.inka.de ([193.197.184.2]:42385 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752654Ab2KGPkN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2012 10:40:13 -0500
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1TW7jf-0007kZ-Ne; Wed, 07 Nov 2012 16:40:11 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id B05D5760D5; Wed,  7 Nov 2012 16:35:19 +0100 (CET)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209133>

Hello,

When using git-clone over an unreliable link (say, UMTS) and the network goes
down, git-clone deletes everything what was downloaded. When the network goes
up again and you restart git-clone, it has to start over from the
beginning. Then, eventually, the network goes down again, and everything is
deleted again.

Is there a way to omit the deleting step, so the second invocation would start
where the first invocation was interrupted?
