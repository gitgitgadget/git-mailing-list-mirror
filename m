From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: thoughts on setting core.logAllRefUpdates default true for bare repos
Date: Wed, 4 Nov 2009 12:55:53 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrnhf2uep.7d3.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 04 13:56:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5fPV-0007Kj-NH
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 13:56:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755762AbZKDM4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 07:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755726AbZKDM4O
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 07:56:14 -0500
Received: from lo.gmane.org ([80.91.229.12]:37293 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755629AbZKDM4O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 07:56:14 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N5fPN-0007Fl-Uv
	for git@vger.kernel.org; Wed, 04 Nov 2009 13:56:17 +0100
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 13:56:17 +0100
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 13:56:17 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132082>

It seems to me an accidental push -f would cause some
trouble on a bare repo, and would usually require a bit of
grubbing around among the unreachable commits looking for
the right one.

What would be the downsides (other than some objects hanging
around far longer, i.e., space issues) of setting the config
variable core.logAllRefUpdates to be default true on bare
repos.
