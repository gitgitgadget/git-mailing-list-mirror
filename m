From: Lukasz Palczewski <l.palczewski@prevac.pl>
Subject: Restart submodule update --recursive
Date: Thu, 28 Oct 2010 07:25:34 +0000 (UTC)
Message-ID: <loom.20101028T090353-376@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 28 09:30:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBMw9-0005gl-82
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 09:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758149Ab0J1HaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 03:30:09 -0400
Received: from lo.gmane.org ([80.91.229.12]:46434 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758115Ab0J1HaH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 03:30:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PBMw1-0005dU-1u
	for git@vger.kernel.org; Thu, 28 Oct 2010 09:30:05 +0200
Received: from ayr35.internetdsl.tpnet.pl ([83.18.121.35])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 09:30:05 +0200
Received: from l.palczewski by ayr35.internetdsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 09:30:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 83.18.121.35 (Mozilla/5.0 (Windows; U; Windows NT 5.1; pl; rv:1.9.2.11) Gecko/20101012 Firefox/3.6.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160162>

Hi.
I have a problem with the time and the stoping of the submodule update command
when the error occures.
In our project we have lots of submodules with submodules in them. So I use git
command: git submodule update --recursive, to update all the submodules, but it
take some time to do it. I have to do it quite often becouse I'm a tester of the
software and I usually don't know which submodule I need to update, to have the
newest version. If I have some local changes in some submodule, the command
stops and I have to revert the changes and start the submodule update from the
begining again. 
Is there a way to start the submodule update from the place, where the error
occured and the command stop? Something like:
git submodule update --recursive --restart_form_last_error
If there isn't, can You add this feature?
