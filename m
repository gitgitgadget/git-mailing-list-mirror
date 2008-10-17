From: "Richard Hartmann" <richih.mailinglist@gmail.com>
Subject: Re: commiting while the current version is in conflict
Date: Fri, 17 Oct 2008 11:35:30 +0200
Message-ID: <2d460de70810170235q1c9211c3r1f56067e694b1ac@mail.gmail.com>
References: <7vy70of6t2.fsf@arte.twinsun.com>
	 <2d460de70810170021q5daa902er1e6e2fb6633400ec@mail.gmail.com>
	 <m3d4hzk2du.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio Hamano" <junio@twinsun.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Miklos Vajna" <vmiklos@frugalware.org>, git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 17 11:36:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqllE-0000hW-BY
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 11:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471AbYJQJfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 05:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752663AbYJQJfc
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 05:35:32 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:46424 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383AbYJQJfb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 05:35:31 -0400
Received: by yx-out-2324.google.com with SMTP id 8so91638yxm.1
        for <git@vger.kernel.org>; Fri, 17 Oct 2008 02:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Vt1KL+E6Ii7p26jynfXOESGYPFEkaiJOrvHB/olkn5A=;
        b=S36EkXtpd6h4nNPof/EpVfoFQj7KZin6yRBaulA0ESsy6aGnuGnX4fGkxIpIFh8QC9
         YPZb+5MT7+R+jkWQ3/CZ1sjg0y/sBNHaeaOJCsQAxB2dw1rVvfM70E3Rs1oPDYgPqu4l
         kTiMebVj5COrMPuAbGTecR4K8HSCbelFKQJd4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=i+8mqGpq6obktJKPQs7RXmj0/HwJayTo7irc9RqrZLy1SjgASM7m5s8iSvBc1RXYwy
         QDv0pARDtJtd43zhQxnrbGrbimvYjdkRKKlgs9Zy8cTM8CAb7rZK2YZ9gACg7GHklatM
         SU7zaKKyQn1oKUHPreLmFhcK2kRxZRzNQ5XQw=
Received: by 10.100.168.18 with SMTP id q18mr4981537ane.51.1224236130814;
        Fri, 17 Oct 2008 02:35:30 -0700 (PDT)
Received: by 10.100.43.19 with HTTP; Fri, 17 Oct 2008 02:35:30 -0700 (PDT)
In-Reply-To: <m3d4hzk2du.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98465>

On Fri, Oct 17, 2008 at 11:16, Jakub Narebski <jnareb@gmail.com> wrote:

> From time to time somebody proposes to add a command which is used
> only to say that given conflict got resolved, i.e. yet another
> porcelain "around" git-update-index plumbing (in addition to git-add,
> git-mv and git-rm).  One of problems is how to call it: git-resolve,
> git-resolved, git-mark-resolved?

In that case, you would still need a pre-add hook.
The problem is not that people can't mark resolved without adding.
It's that they can't add without checking (automatically) if there
are no conflicts.


Richard
