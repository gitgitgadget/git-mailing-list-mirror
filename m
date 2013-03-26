From: Tim Walberg <twalberg@comcast.net>
Subject: verify-pack regression and/or doc error
Date: Tue, 26 Mar 2013 10:41:33 -0500
Message-ID: <20130326154133.GA26315@comcast.net>
Reply-To: Tim Walberg <twalberg@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 26 16:42:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKW0v-00052x-TZ
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 16:42:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934777Ab3CZPlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 11:41:39 -0400
Received: from qmta11.emeryville.ca.mail.comcast.net ([76.96.27.211]:41334
	"EHLO qmta11.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932839Ab3CZPlg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Mar 2013 11:41:36 -0400
Received: from omta10.emeryville.ca.mail.comcast.net ([76.96.30.28])
	by qmta11.emeryville.ca.mail.comcast.net with comcast
	id GDD21l0080cQ2SLABFhcU0; Tue, 26 Mar 2013 15:41:36 +0000
Received: from beta.localdomain ([67.184.156.247])
	by omta10.emeryville.ca.mail.comcast.net with comcast
	id GFha1l00r5LYcRf8WFhbET; Tue, 26 Mar 2013 15:41:36 +0000
Received: from calvin.localdomain ([10.0.0.8])
	by beta.localdomain with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <twalberg@comcast.net>)
	id 1UKW0E-0004Y2-6Z; Tue, 26 Mar 2013 10:41:34 -0500
Received: from tew by calvin.localdomain with local (Exim 4.72)
	(envelope-from <tew@calvin.localdomain>)
	id 1UKW0D-00072K-7H; Tue, 26 Mar 2013 10:41:33 -0500
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1364312496;
	bh=SuOtwVa6bIyow68jV1SJOZtvDye9Dhqrz10VQO4MucM=;
	h=Received:Received:Received:Received:Date:From:To:Subject:
	 Message-ID:Reply-To:MIME-Version:Content-Type;
	b=IAseTA+LOGKQMV1dRvjFywEA96h5u70rW3CCParwnVJHbaNnrXt7hu8zRHfyBcDZv
	 odthx33q2hf0n4rbCVe0RCU2AmLfFe79gm5jENUTbzfRDfD7fWhcVjvF3wZ2BTjDcC
	 FB7CUMISH7TLf4EWyQ7lBPVa+7SDFpvzyGb8SeNB73eI/EpEs5hT05Pp1/LIWtPk3w
	 MFpHL/fl5QxnmE+MQnuYuM3Yhs/AL7aQRe08XmJSjI9Y4iS8b440O7lMa/8qVSt5GL
	 Xs8rMvG/niR9S+DtgzH8rKZh9jbWVTsZi2uoIqdRS0RMlxnqPBYEISMOOtYHn0ujLQ
	 /CzLJ1+WrYZyQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219164>

The documentation for verify-pack states under the "-s, --stat-only" option,
that "With --verbose, list of objects is also shown.". However, this seems
to not be true in either 1.8.2 or 1.7.11.4, the two versions I have readily
at hand. I'm guessing this might be a documentation error (and is probably
easiest to fix), but it's also possible that this was true at some point
and would thus be a (somewhat long-standing) regression. Not a particularly
high-profile issue, but it is an inconsistency...


		      tw

-- 
twalberg@comcast.net
