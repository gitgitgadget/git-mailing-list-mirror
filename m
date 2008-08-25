From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: "failed to read delta base object at..."
Date: Mon, 25 Aug 2008 12:46:02 -0400
Message-ID: <20080825164602.GA2213@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 25 18:47:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXfDk-0001HS-7S
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 18:47:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754063AbYHYQqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 12:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754069AbYHYQqE
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 12:46:04 -0400
Received: from mail.fieldses.org ([66.93.2.214]:57669 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754037AbYHYQqD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 12:46:03 -0400
Received: from bfields by fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1KXfCc-0000gE-7Y
	for git@vger.kernel.org; Mon, 25 Aug 2008 12:46:02 -0400
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93641>

Today I got this:

fatal: failed to read delta base object at 3025976 from
/home/bfields/local/linux-2.6/.git/objects/pack/pack-f7261d96cf1161b1b0a1593f673a67d0f2469e9b.pack

This has happened once before recently, I believe with a pack that had
just been created on a recent fetch.  (If I remember correctly, this was
soon after a failed suspend/resume cycle that might have interrupted an
in-progress fetch; could that possible explain the error?)  In that case
I reset origin/master, deleted a tag or two, and fetched, and the
problem seemed to be fixed.

--b.
