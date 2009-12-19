From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] Introduce the GIT_CONFIG_EXTRA environment variable
Date: Sat, 19 Dec 2009 23:45:01 +0900
Message-ID: <20091219234501.6117@nanako3.lavabit.com>
References: <4B2C0828.4010505@signalbeam.net> <20091219013246.GD25474@genesis.frugalware.org> <7vhbrnodd9.fsf@alter.siamese.dyndns.org> <4B2C5A1A.8000201@signalbeam.net> <7vzl5fik3o.fsf@alter.siamese.dyndns.org> <4B2C7EC3.6070501@signalbeam.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Moe <moe@signalbeam.net>
X-From: git-owner@vger.kernel.org Sat Dec 19 15:46:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NM0ZD-0000Zy-ST
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 15:46:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616AbZLSOpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 09:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752367AbZLSOpe
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 09:45:34 -0500
Received: from karen.lavabit.com ([72.249.41.33]:46737 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752608AbZLSOpc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 09:45:32 -0500
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id F19C911B730;
	Sat, 19 Dec 2009 08:45:31 -0600 (CST)
Received: from 5981.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id T30LPTP9UEYT; Sat, 19 Dec 2009 08:45:31 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=QK1hPzslDKSJwck5X78N2xvgr7u0caK+l81yhcLQjaE9A0nUz/SAGN++Kbv0HE1wSMQfImxVSyBaoEetkA74w5aZX6m7szQbHsZfwqkZxYnv62oHLc2Svum0p6oYeD+y57ZfQRcRkqEZPsa5iRFjsmdU3ae6H0IXy2FiqGE0y6Q=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <4B2C7EC3.6070501@signalbeam.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135483>

Quoting Moe <moe@signalbeam.net>

> In practice our developers will su or ssh to this user to get working
> and generally they need only a very small set of divertions from the
> common configuration - such as their personal git identity and their
> preferred editor settings.

Do "preferred editor settings" mean $HOME/.vim that was one of 
Junio's examples? How do you handle it?

It sounds like you are only interested in user.name and 
user.email, and you don't need to override $HOME/.gitconfig as 
a whole.  Because you already have a section in $HOME/.bashrc 
that does different things based on the user's SSH key, you 
may want to set variables GIT_AUTHOR_NAME and GIT_AUTHOR_EMAIL 
in there without doing anything else if that is the case.

> One may argue that a bunch of host-specific symlinks could achieve a
> similar effect - and that would be correct - but having literally
> everything under version control yields certain advantages that we
> wouldn't want to miss.

Sorry, but I don't understand. What do symlinks have to do 
with keeping everything under version control? git can track 
symbolic links just fine, if that is what is troubling you.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
