From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: [RFC] Adding a challenge-response authentication method to git://
Date: Wed, 13 Aug 2008 18:26:44 +0200
Message-ID: <20080813162644.GC12200@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 13 18:29:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTJCh-0003tr-3t
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 18:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752402AbYHMQ0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 12:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbYHMQ0q
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 12:26:46 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:40585 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436AbYHMQ0p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 12:26:45 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 7D1F75465; Wed, 13 Aug 2008 18:26:44 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92239>

What are the opinions on adding a basic challenge-response type
authentication mechanism to the native git protocol?
I.e. the authentication would be a simple one, which uses
SHA1 (surprise ;-) to actually encrypt username/password/salt
and authenticate the user.

I'm willing to do the work, if there are no objections.
-- 
Sincerely,
           Stephen R. van den Berg.

"And now for something *completely* different!"
