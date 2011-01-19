From: Maaartin <grajcar1@seznam.cz>
Subject: Re: [PATCH 3/3] setup: always honor GIT_WORK_TREE and core.worktree
Date: Wed, 19 Jan 2011 19:51:02 +0100
Message-ID: <4D373296.6030101@seznam.cz>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com> <1290785563-15339-40-git-send-email-pclouds@gmail.com> <20110118074400.GA4185@burratino> <7v1v4aknij.fsf@alter.siamese.dyndns.org> <20110119123732.GA23222@burratino> <20110119124230.GD23222@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?YyBEdXk=?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 19 19:51:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pfd7h-00063c-Of
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 19:51:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753208Ab1ASSvF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 13:51:05 -0500
Received: from cgc-instruments.com ([83.169.21.132]:36397 "EHLO
	lvps83-169-21-132.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753152Ab1ASSvE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Jan 2011 13:51:04 -0500
Received: (qmail 28479 invoked from network); 19 Jan 2011 19:51:01 +0100
Received: from 188-120-198-113.luckynet.cz (HELO ?10.0.3.100?) (188.120.198.113)
  by cgc-instruments.com with SMTP; 19 Jan 2011 19:51:01 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20110119124230.GD23222@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165275>

On 11-01-19 13:42, Jonathan Nieder wrote:
> Unfortunately the existence of GIT_WORK_TREE makes it tempting to
> use without setting GIT_DIR.

Maybe I'm asking nonsense, but why should I always use both? On the
command line, I either cd to my (alternate) working tree and use GIT_DIR
only or the other way round. I used both several times when I wanted to
compare the (normal) working tree with another commit using something
better than git-diff (git-difftool didn't work for me on cygwin).
