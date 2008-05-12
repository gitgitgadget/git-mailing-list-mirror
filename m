From: Teemu Likonen <tlikonen@iki.fi>
Subject: Why repository grows after "git gc"? / Purpose of *.keep files?
Date: Mon, 12 May 2008 15:29:00 +0300
Message-ID: <20080512122900.GA13050@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 12 14:31:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvXAE-0004By-FC
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 14:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755277AbYELM3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 08:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754368AbYELM3H
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 08:29:07 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:58645 "EHLO
	jenni2.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753564AbYELM3F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 08:29:05 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni2.rokki.sonera.fi (8.5.014)
        id 482329DB00294DD1 for git@vger.kernel.org; Mon, 12 May 2008 15:29:02 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1JvX9I-0004zF-VP
	for git@vger.kernel.org; Mon, 12 May 2008 15:29:00 +0300
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81856>

I have noticed that after cloning a repository (via git protocol) the
repo is packed pretty tightly and takes relatively small amount of disk
space. After using it a while and running "git gc" the repo sometimes
grows 25% or something like that.

For testing purposes I deleted objects/pack/*.keep file(s) and ran "git
gc" again. The repo resulted in small again, just like after the initial
clone. I don't have disk space problems but a repo growing about 25%
after manual "git gc" seems weird. What's the purpose of these *.keep
files? They just contain text like "fetch-pack <number> on <my
hostname>".


PS. I have merged Brandon Casey's new git-gc/repack patches. In case it
    has some effect. See the "pu" branch or "git log 9e7d5019".
