From: Maaartin <grajcar1@seznam.cz>
Subject: Git pack - repo size doubled
Date: Thu, 24 Feb 2011 09:19:06 +0100
Message-ID: <ik549p$pq8$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 24 09:19:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsWQ4-0001Zr-Fl
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 09:19:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755422Ab1BXITX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 03:19:23 -0500
Received: from lo.gmane.org ([80.91.229.12]:53408 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755250Ab1BXITX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 03:19:23 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PsWPv-0001VT-9d
	for git@vger.kernel.org; Thu, 24 Feb 2011 09:19:19 +0100
Received: from 188.120.198.24 ([188.120.198.24])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 09:19:19 +0100
Received: from grajcar1 by 188.120.198.24 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 09:19:19 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 188.120.198.24
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167781>

I'm using git version 1.7.3.3 under cygwin (W XP64). When I tried

git repack -A -d --depth=255 --window=255 --window-memory=4g

I've got the message

rm: cannot remove `pack-c75642be5314b1a98ddfcf0d51ac838db4af75ad.pack':
Device or resource busy

It seems like the file hadn't got closed. The non-deletion of the file
roughly doubles the repo size (134070 KiB instead of 67470 KiB).

- Can I manually remove the file?

- If I do it, does "git fsck" suffice to make sure, everything's all right?

- Would creating of multiple packs work better? What "--max-pack-size"
would you recommend?
