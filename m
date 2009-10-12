From: sebastian@CoLi.Uni-SB.DE
Subject: git refuses to work with gvim
Date: Mon, 12 Oct 2009 13:43:12 +0200
Message-ID: <20091012134312.236d250e@gzip.coli.uni-saarland.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 12 14:38:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxKAY-0003nL-DG
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 14:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756191AbZJLM13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 08:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755474AbZJLM13
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 08:27:29 -0400
Received: from triton.rz.uni-saarland.de ([134.96.7.25]:3178 "EHLO
	triton.rz.uni-saarland.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755253AbZJLM12 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 08:27:28 -0400
X-Greylist: delayed 2617 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Oct 2009 08:27:28 EDT
Received: from top.coli.uni-saarland.de (top.coli.uni-saarland.de [134.96.104.10])
	by triton.rz.uni-saarland.de (8.14.1/8.14.0) with ESMTP id n9CBhCTC031330
	for <git@vger.kernel.org>; Mon, 12 Oct 2009 13:43:12 +0200
Received: from gzip.coli.uni-saarland.de (gzip.coli.uni-saarland.de [134.96.105.8])
	by top.coli.uni-saarland.de (8.14.3/8.14.3) with ESMTP id n9CBhCUn016356
	for <git@vger.kernel.org>; Mon, 12 Oct 2009 13:43:12 +0200 (MET DST)
X-Mailer: Claws Mail 3.6.1 (GTK+ 2.16.1; i486-pc-linux-gnu)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (triton.rz.uni-saarland.de [134.96.7.25]); Mon, 12 Oct 2009 13:43:12 +0200 (CEST)
X-AntiVirus: checked by AntiVir MailGate (version: 2.1.2-14; AVE: 7.9.1.35; VDF: 7.1.6.98; host: AntiVir3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130007>

Hi,
a few days ago I decided to switch from vim to gvim. To make use of
this in most cases I added :gui to my .vimrc which should make most
applications automatically switch to use gvim if they used the vim
command before.

But git seems to have problems with this. If I do now a "git commit
something" not the gui is opened but the console-version of vim. I
could live with that for git but if I now type some commit-message in
the console-version and do :x or :wq I get an error-message:

# git commit something
fatal: no commit message?  aborting commit.
#

Also

# EDITOR=gvim git commit something
fatal: no commit message?  aborting commit.
# 

shows the same error.

Removing :gui from my .vimrc makes git behave normally again. I don't
know what the problem here is: vim or git or both toghether?

I already saw screenshots of people using git with gvim. So there is a
way to make them work together but what am I missing?


OS: Debian Lenny
vim: 7.1
git: 1.5.6.5

greetings
