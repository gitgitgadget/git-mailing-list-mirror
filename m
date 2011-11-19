From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: Switch from svn to git and modify repo completely
Date: Sat, 19 Nov 2011 22:50:48 +0400
Message-ID: <20111119225048.384189bc@zappedws>
References: <4EC7E32A.9040903@fechner.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthias Fechner <idefix@fechner.net>
X-From: git-owner@vger.kernel.org Sat Nov 19 19:51:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRq0R-0002rf-6j
	for gcvg-git-2@lo.gmane.org; Sat, 19 Nov 2011 19:51:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683Ab1KSSvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Nov 2011 13:51:07 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35998 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788Ab1KSSvF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2011 13:51:05 -0500
Received: by bke11 with SMTP id 11so4777075bke.19
        for <git@vger.kernel.org>; Sat, 19 Nov 2011 10:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=BUi2Mjv+kAGy65VqHyD4+X3HTxMKxO8E1JnRXJx++xA=;
        b=GVLguCEm27ggY8XI2Dx9aoGzmfV4XOyLieZ6F+TSLkCtmBYMKggCXNzKuqUK0Uepje
         e4moh+4n7cBIwNpM4qvRGey3VDecfdatwSQFAtdeQ9kVv4dg07Bg4ImGYd4mbDk4FWKg
         My+bEodxjlhRVfgsv4M03MLNKxj3n0Teq68RE=
Received: by 10.205.142.4 with SMTP id jg4mr1489428bkc.119.1321728664201;
        Sat, 19 Nov 2011 10:51:04 -0800 (PST)
Received: from zappedws (ppp91-77-24-178.pppoe.mtu-net.ru. [91.77.24.178])
        by mx.google.com with ESMTPS id h7sm3433266bkw.12.2011.11.19.10.51.00
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Nov 2011 10:51:03 -0800 (PST)
In-Reply-To: <4EC7E32A.9040903@fechner.net>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185696>

> Dear Git List,
> 
> I just started to migrate a svn repo to a git repo and was
> successfully with the "git svn" command and waiting a long time :)
> 
> I have now some confidential documents in the repository I must remove
> completely (including the complete history). These are single files
> spread over the complete repository. Is this possible with git?

take a look at "git filter-branch"
