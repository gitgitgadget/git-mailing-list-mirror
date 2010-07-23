From: Maurizio Vitale <mav@leonardo.pit.corp.google.com>
Subject: question (possibly) on git subtree/submodules
Date: Fri, 23 Jul 2010 10:00:52 -0400
Organization: Polymath Solutions, Inc.
Message-ID: <xotjlj92i9gr.fsf@leonardo.pit.corp.google.com>
Reply-To: maurizio.vitale@polymath-solutions.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 23 17:35:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcKHR-00065L-0r
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 17:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760313Ab0GWPfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 11:35:12 -0400
Received: from lo.gmane.org ([80.91.229.12]:43975 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752880Ab0GWPfL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 11:35:11 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OcKHA-0005zl-KA
	for git@vger.kernel.org; Fri, 23 Jul 2010 17:35:04 +0200
Received: from 63.161.156.65 ([63.161.156.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 17:35:04 +0200
Received: from maurizio.vitale by 63.161.156.65 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 17:35:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 63.161.156.65
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:JBO3xOL+qYPUinuqeWmfOnl8REU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151544>


I'm new to git and have read the recent thread on subtree support.
I'm not sure they (or git submodules) offer what I'm looking for.
Here's the scenario:
       - I have a large monolithic code base, all in my repository (e.g.
         I don't need to link in external repositories, which is what I
         understand submodules offer
       - I'd like to be able to clone only a small fraction of the
         repository (say an arbitrary directory or even a single file)
         in order to make small changes
       - these directories are not known when the full repository is set
         up.
       - commits to the part I've checked out should show in the history
         of any clone that includes the part, up to the full repository
       - ideally, I should be able to incrementally clone portions (e.g.
         I've checked out path/dir_A and realize I need to modify
         path/dir_B as well).
         these additional clones should be in whatever branch I switched
         to after the initial checkouts.

Assuming the above makes any sense (in general or in git), is there
anything in git that would help me doing what I'm looking for?
Thanks,

        Maurizio 

       
