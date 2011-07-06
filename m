From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] git-rebase.txt: clarify that --abort checks out
 <branch>
Date: Tue, 5 Jul 2011 21:52:28 -0500
Message-ID: <20110706025228.GB10015@elie>
References: <1309574324-6833-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1309902196.31762.30.camel@drew-northup.unet.maine.edu>
 <alpine.DEB.2.00.1107052148370.7799@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Drew Northup <drew.northup@maine.edu>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 04:52:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeIEB-0004qH-M1
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 04:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755849Ab1GFCwe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jul 2011 22:52:34 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40391 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755224Ab1GFCwd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2011 22:52:33 -0400
Received: by yxi11 with SMTP id 11so2137920yxi.19
        for <git@vger.kernel.org>; Tue, 05 Jul 2011 19:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=FLKk+oAaWl2FTuR8DiIZ3dPzrtUgjhxJ9jw7LmKMhgg=;
        b=uZdXo9YsteOEWOSwrKyM8NWTxOcA+drYQ0m+U0uXAVbASkoL5Rpm+dA6d/Yo06FxmS
         SyAypsBmb0nzujEsu8M+mrsT+i2bFOOz7FTXjxoR9pyxKXHmQxjLtTyso5v6/TMZ+94e
         WjZuT5I0tQmoZZDlH81Rc9NTGih7nH9t09ODE=
Received: by 10.101.83.8 with SMTP id k8mr5021918anl.1.1309920753140;
        Tue, 05 Jul 2011 19:52:33 -0700 (PDT)
Received: from elie (adsl-69-209-76-243.dsl.chcgil.ameritech.net [69.209.76.243])
        by mx.google.com with ESMTPS id i20sm5618418anq.9.2011.07.05.19.52.31
        (version=SSLv3 cipher=OTHER);
        Tue, 05 Jul 2011 19:52:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1107052148370.7799@debian>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176636>

Martin von Zweigbergk wrote:

> That reminds me that <branch> may not have been specified. How about
> saying things more explicitly like this?
>
>   Abort the rebase operation and reset HEAD to the original branch. If
>   <branch> was provided when the rebase operation was started, then
>   HEAD will be reset to <branch>. Otherwise HEAD will be reset to
>   where it was when the rebase operation was started.

Sounds great to me for what it's worth.  (With the caveat that "git
rebase --abort" reattaches HEAD in addition to what "git reset --hard"
would do, but I think it's fine to just leave that implied.)  Sorry to
have been slow to respond lately.
