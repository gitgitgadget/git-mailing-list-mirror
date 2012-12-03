From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: [PATCH] gitk: read and write a repository specific configuration file
Date: Mon, 3 Dec 2012 22:15:08 +0100
Message-ID: <1kujrnc.1r4khfkkpdoo1M%lists@haller-berlin.de>
References: <1354483766-13925-1-git-send-email-stlman@poczta.fm>
Cc: paulus@samba.org, gitster@pobox.com
To: stlman@poczta.fm (Lukasz Stelmach), git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 03 22:15:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfdMQ-0001av-75
	for gcvg-git-2@plane.gmane.org; Mon, 03 Dec 2012 22:15:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566Ab2LCVPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2012 16:15:11 -0500
Received: from server90.greatnet.de ([83.133.96.186]:59699 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944Ab2LCVPK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2012 16:15:10 -0500
Received: from [192.168.0.42] (nat1.ableton.net [217.110.199.117])
	by server90.greatnet.de (Postfix) with ESMTPA id CA6932C4074;
	Mon,  3 Dec 2012 22:15:08 +0100 (CET)
In-Reply-To: <1354483766-13925-1-git-send-email-stlman@poczta.fm>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.8.2 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211060>

Lukasz Stelmach <stlman@poczta.fm> wrote:

> Enable gitk read and write repository specific configuration
> file: ".git/k" if the file exists. To make gitk use the local
> file simply create one, e.g. with the touch(1) command.

I'm not sure I like this proposal. While it may be desirable to have
*some* settings stored per repository, for most settings I want them to
be remembered globally.

Git-gui tries to solve this by presenting two panes in the preferences
dialog, so that I can choose the scope of every setting I change. This
still doesn't help for things that are remembered implicitly, like the
window size.

I don't have good suggestions how to solve this; just pointing out
problems.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
