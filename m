From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git-send-email generates mail with invalid Message-Id
Date: Tue, 28 Jul 2009 12:03:48 +0200
Message-ID: <200907281203.49732.trast@student.ethz.ch>
References: <200907280446.22890.elendil@planet.nl> <200907281127.44558.trast@student.ethz.ch> <40aa078e0907280251k159d9a93xa8c90413b3fab5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Frans Pop <elendil@planet.nl>, git@vger.kernel.org
To: "Erik Faye-Lund" <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 12:05:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVjYH-0006J6-Sl
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 12:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752867AbZG1KD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 06:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752015AbZG1KD7
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 06:03:59 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:38828 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752597AbZG1KD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 06:03:59 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Jul 2009 12:03:58 +0200
Received: from thomas.localnet ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Jul 2009 12:03:57 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.25-0.1-default; KDE/4.2.98; x86_64; ; )
In-Reply-To: <40aa078e0907280251k159d9a93xa8c90413b3fab5a@mail.gmail.com>
X-OriginalArrivalTime: 28 Jul 2009 10:03:58.0041 (UTC) FILETIME=[B9217C90:01CA0F6A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124230>

Erik Faye-Lund wrote:
> On Tue, Jul 28, 2009 at 11:27 AM, Thomas Rast<trast@student.ethz.ch> wrote:
> > git-format-patch generates its own message IDs if it needs them for
> > threading, with gen_message_id() (in builtin-log.c).  That one appends
> > the committer email address blindly, without verifying that it has an
> > @ in it.
> 
> That must be a separate issue (but quite possibly a valid one), since
> gen_message_id's ids dont' contain "-send-email-" like the message-id
> in the report does, no?

Ah, true of course.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
