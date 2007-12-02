From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: git + unison
Date: Sun, 2 Dec 2007 14:05:22 -0500
Message-ID: <20071202190522.GB20822@fieldses.org>
References: <vpqd4tpgepj.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Dec 02 20:05:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iyu8Q-00016R-H3
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 20:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755747AbXLBTFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 14:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755583AbXLBTFZ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 14:05:25 -0500
Received: from mail.fieldses.org ([66.93.2.214]:48762 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755393AbXLBTFY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 14:05:24 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1Iyu82-0006EP-Ny; Sun, 02 Dec 2007 14:05:22 -0500
Content-Disposition: inline
In-Reply-To: <vpqd4tpgepj.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66809>

On Sun, Dec 02, 2007 at 06:59:36PM +0100, Matthieu Moy wrote:
> What about you? What do you use to synchronize your laptop and
> desktop, or home and office? Anybody using unison and git on the same
> filesystem?

I just have a subdirectory of my home directory "local" that I tell
unison not to synchronize:

	ignore = Path local

and keep all my git repos there, relying on git itself when I need to
distribute stuff--generally all my repos are associated with public
repos on a single (regularly backed-up) server, and I try not to let any
work accumulate in any particular repository for long without being
pushed to a branch in its public repo.

--b.
