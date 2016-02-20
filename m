From: Seb <spluque@gmail.com>
Subject: interactive rebase results across shared histories
Date: Sat, 20 Feb 2016 16:58:44 -0600
Organization: Church of Emacs
Message-ID: <87io1j6laz.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 21 00:10:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXGfs-0002C9-0A
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 00:10:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753331AbcBTXKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2016 18:10:12 -0500
Received: from plane.gmane.org ([80.91.229.3]:47880 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751785AbcBTXKL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2016 18:10:11 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aXGf6-0001dG-SM
	for git@vger.kernel.org; Sun, 21 Feb 2016 00:10:05 +0100
Received: from s0106503955564c1f.wp.shawcable.net ([24.77.8.70])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 00:10:04 +0100
Received: from spluque by s0106503955564c1f.wp.shawcable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 00:10:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: s0106503955564c1f.wp.shawcable.net
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Cancel-Lock: sha1:AVyLnxQfPoCL+UEkbxv2LQ0bvOs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286791>

Hello,

I've recently learnt how to consolidate and clean up the master branch's
commit history.  I've squashed/fixuped many commits thinking these would
propagate to the children branches with whom it shares the earlier parts
of the its history.  However, this is not the case; switching to the
child branch still shows the non-rebased (dirty) commit history from
master.  Am I misunderstanding something with this?

Thanks,

-- 
Seb
