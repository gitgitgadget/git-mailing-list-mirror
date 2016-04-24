From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [git send-email] Less secure?
Date: Sun, 24 Apr 2016 22:36:57 +0000
Message-ID: <20160424223657.GA25762@dcvr.yhbt.net>
References: <CAL+bK4Ms5WLSiWEPhXOX2i5T9UdcaZyD+kaTZpVsd0NZBts+7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Neven Sajko <nsajko@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 00:37:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auSek-0000mz-RG
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 00:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752143AbcDXWhB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 18:37:01 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53590 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752094AbcDXWhA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 18:37:00 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D646633822;
	Sun, 24 Apr 2016 22:36:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAL+bK4Ms5WLSiWEPhXOX2i5T9UdcaZyD+kaTZpVsd0NZBts+7A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292446>

Neven Sajko <nsajko@gmail.com> wrote:
> Gmail by default doesn't allow usage through send-email.
> They say that send-email is "less secure" and that enabling it
> makes it easier to break into my account.
> 
> Is send-email really less secure than the Gmail web browser
> interface?

Like any email client, git send-email is only as secure as your
own practices.  It can use git's native git-credential system
for handling passwords.

According to the following post from Javier, you will need
an extra password if you have two-factor auth enabled with Gmail:

http://mid.gmane.org/CALZVapn9KjXCpO+zaYuB6RSnG747u4a7e_m_HDg+uH-uz8UhQg@mail.gmail.com

Additionally, since (AFAIK) you can still get multiple Gmail
accounts, there's no reason you need to use your primary email
account (that might be tied to your private/personal life)
for sending patches to a public mailing list.


Disclaimer: I have little experience with Gmail myself and do
not endorse Google (or any corporation).  I just care deeply
about the continued existence of vendor-neutral messaging.
