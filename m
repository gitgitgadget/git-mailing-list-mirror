From: "Todd A. Jacobs" <nospam@codegnome.org>
Subject: View remote logs?
Date: Tue, 14 Oct 2008 00:19:07 -0700
Message-ID: <20081014071907.GP16999@penguin.codegnome.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 14 09:52:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kpei3-0003Zg-5V
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 09:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754248AbYJNHvi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 03:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753756AbYJNHvi
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 03:51:38 -0400
Received: from que21.charter.net ([209.225.8.22]:52016 "EHLO que21.charter.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752578AbYJNHvh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 03:51:37 -0400
X-Greylist: delayed 1396 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Oct 2008 03:51:37 EDT
Received: from aarprv06.charter.net ([10.20.200.76]) by mta31.charter.net
          (InterMail vM.7.08.03.00 201-2186-126-20070710) with ESMTP
          id <20081014071910.KHGA4798.mta31.charter.net@aarprv06.charter.net>
          for <git@vger.kernel.org>; Tue, 14 Oct 2008 03:19:10 -0400
Received: from penguin.codegnome.org ([71.83.124.90])
          by aarprv06.charter.net with ESMTP
          id <20081014071909.NPV128.aarprv06.charter.net@penguin.codegnome.org>
          for <git@vger.kernel.org>; Tue, 14 Oct 2008 03:19:09 -0400
Received: by penguin.codegnome.org (Postfix, from userid 1000)
	id 3F85237CAB; Tue, 14 Oct 2008 00:19:09 -0700 (PDT)
Received: by penguin.codegnome.org (tmda-sendmail, from uid 1000);
	Tue, 14 Oct 2008 00:19:09 -0700
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Delivery-Agent: TMDA/1.1.12 (Macallan)
Mail-Followup-To: git@vger.kernel.org
X-Chzlrs: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98172>

I've Googled around, and tried some experiments with likely-looking
tools like git log, git diff, and git ls-remote, but they only seem to
operate on the local repository. In particular, there doesn't seem to be
an obvious way to view the commit logs on a remote repository without
pulling it first.

On an intuitive level, it seems like "git log origin" would allow me to
see what someone has committed to a remote repository so I can decide
whether it's something I want to pull. Even something like "git diff
HEAD origin" would let me know if there were changes I might want to
pull before doing so.

Am I missing something obvious? Is it possible to use the CLI to view
remote logs, or is the only choice to pull everything?

-- 
"Oh, look: rocks!"
	-- Doctor Who, "Destiny of the Daleks"
