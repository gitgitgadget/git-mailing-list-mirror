From: Yuri D'Elia <wavexx@thregr.org>
Subject: A better git log --graph?
Date: Wed, 07 Jan 2015 15:23:00 +0100
Message-ID: <m8jfg5$dsp$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 07 15:30:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8rYa-000888-Dm
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 15:25:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752450AbbAGOZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 09:25:52 -0500
Received: from plane.gmane.org ([80.91.229.3]:57829 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752439AbbAGOZv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 09:25:51 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Y8rXM-0006Q6-SO
	for git@vger.kernel.org; Wed, 07 Jan 2015 15:24:41 +0100
Received: from 193.106.183.18 ([193.106.183.18])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Jan 2015 15:24:40 +0100
Received: from wavexx by 193.106.183.18 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Jan 2015 15:24:40 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 193.106.183.18
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262132>

Hi everyone,

git log --graph is hard for me to parse mentally when developing a
project which has a lot of branches.

All the tools I've been using seem to just parse log --graph's output,
and thus are no better at showing history.

I would love to have a graph mode where each branch is assigned a
column, and stays there. If my log section shows the history of 3
branches, column 1 should always refer to master, 2 to the hypothetical
"development" branch and 3 to "feature".

Of course the mode will waste more horizontal space, but it would be
immediately more apparent which branch is merging into which.

I saw this idea proposed a couple of times in the mailing list, but I
saw no "action" behind the proposal. Since I don't have time to work on
it, has anyone already started some work that he would like to share as
a starting point? Even just to have a felling if it's worth the effort.

Does anybody know of another tool to graph the history using something
that is not based on git log --graph?

I've seen a couple of graphviz-based ones, but both failed to work out
of the box for me.

Thanks a lot for any pointer.
