From: Sergio <sergio.callegari@gmail.com>
Subject: Possible bug with git status in 1.7.0
Date: Wed, 17 Feb 2010 19:14:28 +0000 (UTC)
Message-ID: <loom.20100217T184109-183@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 20:15:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhpMT-0004TO-17
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 20:15:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754100Ab0BQTOz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 14:14:55 -0500
Received: from lo.gmane.org ([80.91.229.12]:58406 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754090Ab0BQTOy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 14:14:54 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NhpMK-0004Lm-EA
	for git@vger.kernel.org; Wed, 17 Feb 2010 20:14:52 +0100
Received: from i2-ve060.ingce.unibo.it ([137.204.107.60])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Feb 2010 20:14:52 +0100
Received: from sergio.callegari by i2-ve060.ingce.unibo.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Feb 2010 20:14:52 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 137.204.107.60 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100106 Ubuntu/9.10 (karmic) Firefox/3.5.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140253>

Hi,

if you have a submodule and the submodule contains
untracked files, "git status" in 1.7.0 keeps showing
the module as modified.

But of of course it is useless to "git add" the module
or to try to "git  commit -a", since the index entry is ok

I do not know if this is an intended behavior, but it
looks different from 1.6.6.1.

Sergio
