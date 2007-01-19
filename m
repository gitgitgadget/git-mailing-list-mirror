From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Packfile SHA1 mismatch with itself
Date: Fri, 19 Jan 2007 12:35:09 -0800 (PST)
Message-ID: <510820.93884.qm@web31802.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Jan 19 21:35:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H80SQ-0007sm-1P
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 21:35:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbXASUfM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 15:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbXASUfM
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 15:35:12 -0500
Received: from web31802.mail.mud.yahoo.com ([68.142.207.65]:47091 "HELO
	web31802.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932846AbXASUfK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jan 2007 15:35:10 -0500
Received: (qmail 93920 invoked by uid 60001); 19 Jan 2007 20:35:09 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=cfJELPyhgNKCrK/1mc9bArnZyEqT5bVpULbGNWGmrDkgNrNBErN7jQ/j/jSiTTWocezb80BoD1ljnB7XI9n2mI8cihGTv0QiAEaDKU6J7fH6sQDblt2Dx8rrVf2vWvzJZ4rc5Qs8iNyBJqANgL5GkHyhqmfJWg4Iv8VCu40YXm8=;
X-YMail-OSG: F319dK4VM1nOngA8kKMWMuO9mi27L.1h2O5IbdAxcVwLB0Pm54xReRwmDQ4uY2OUCXApc5cObQ--
Received: from [64.215.88.90] by web31802.mail.mud.yahoo.com via HTTP; Fri, 19 Jan 2007 12:35:09 PST
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37201>

$GIT_DIR=. git-fsck-objects --full
error: Packfile ./objects/pack/pack-8cafdff4eb66bb2219016e4c0817cdb5cb326ab6.pack SHA1 mismatch
with itself
fatal: unknown object type 0 in ./objects/pack/pack-8cafdff4eb66bb2219016e4c0817cdb5cb326ab6.pack

So,... anyone seen this?

Is there a way to fix it, other than blowing away the repo and
recreating it?

Thanks,
   Luben
