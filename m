From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 0/3] cygwin-tests patches
Date: Thu, 16 Jun 2011 21:20:59 +0100
Message-ID: <4DFA65AB.7050605@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 22:28:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXJAj-0001Zc-NZ
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 22:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932983Ab1FPU2F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 16:28:05 -0400
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:33116 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932982Ab1FPU2C (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jun 2011 16:28:02 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1QXJAW-0003DV-i9; Thu, 16 Jun 2011 20:28:02 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175927>

Hi Junio,

These patches, from my cygwin-tests branch, fix test failures on
cygwin. I have sent the first two patches to the list before
(patches #8-9/14 of the "misc test-suite patches" series on 
14-12-2010), but they didn't even make it to the pu branch!
[You requested help in reviewing them.]

The final patch corresponds to the RFC patch sent late last week
(9-6-2011) which has an updated commit message, but is otherwise
unchanged.

    [PATCH 1/3] help.c: Fix detection of custom merge strategy on cygwin
    [PATCH 2/3] t1301-*.sh: Fix the 'forced modes' test on cygwin
    [PATCH 3/3] config.c: Make git_config() work correctly when called recursively

Ah, ... I just noticed that the original RFC patch is already in
pu, merged from rj/config-cygwin.  Hmm, do you want to split that
off from this series again?

ATB,
Ramsay Jones
