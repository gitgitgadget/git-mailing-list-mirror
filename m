From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Tue, 28 Jun 2005 16:45:12 -0400 (EDT)
Message-ID: <3886.10.10.10.24.1119991512.squirrel@linux1>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org>
    <20050624064101.GB14292@pasky.ji.cz>
    <20050624123819.GD9519@64m.dyndns.org>
    <20050628150027.GB1275@pasky.ji.cz> <20050628180157.GI12006@waste.org>
    <62CF578B-B9DF-4DEA-8BAD-041F357771FD@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Matt Mackall" <mpm@selenic.com>, "Petr Baudis" <pasky@ucw.cz>,
	"Christopher Li" <hg@chrisli.org>,
	"Jeff Garzik" <jgarzik@pobox.com>,
	"Linux Kernel" <linux-kernel@vger.kernel.org>,
	"Git Mailing List" <git@vger.kernel.org>, mercurial@selenic.com
X-From: git-owner@vger.kernel.org Tue Jun 28 22:41:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnMsZ-0006WB-9V
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 22:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbVF1Uqz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 16:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVF1Uqb
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 16:46:31 -0400
Received: from simmts8.bellnexxia.net ([206.47.199.166]:46077 "EHLO
	simmts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261606AbVF1UpN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2005 16:45:13 -0400
Received: from linux1 ([69.156.137.160]) by simmts8-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050628204512.JNJV28065.simmts8-srv.bellnexxia.net@linux1>;
          Tue, 28 Jun 2005 16:45:12 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j5SKj7pm015355;
	Tue, 28 Jun 2005 16:45:07 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Tue, 28 Jun 2005 16:45:12 -0400 (EDT)
In-Reply-To: <62CF578B-B9DF-4DEA-8BAD-041F357771FD@mac.com>
To: "Kyle Moffett" <mrmacman_g4@mac.com>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, June 28, 2005 4:27 pm, Kyle Moffett said:
> On Jun 28, 2005, at 14:01:57, Matt Mackall wrote:
>> Everything in Mercurial is an append-only log. A transaction journal
>> records the original length of each log so that it can be restored on
>> failure.
>
> Does this mean that (excepting the "undo" feature) one could set the
> ext3 "append-only" attribute on the repository files to avoid losing
> data due to user account compromise?
>

Probably.  In Git, which is a bit more flexible than Mecurial you can
chmod your objects to read-only or use the ext3 immutable setting to
protect your existing objects.   You can even have a setup where objects
are archived onto write-once media like DVD and still participate in a
live repository, where new objects are written to hard disk, but older
object are (automatically) sourced from the DVD.

Sean
