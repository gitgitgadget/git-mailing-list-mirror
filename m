From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [OT] Your branch is ahead of the tracked remote branch
 'origin/master' by 50 commits.
Date: Tue, 01 Jul 2008 16:55:02 -0700
Message-ID: <7vhcb9kvmx.fsf@gitster.siamese.dyndns.org>
References: <20080701091347.GA11817@elte.hu>
 <7vlk0mne5d.fsf@gitster.siamese.dyndns.org> <20080701100725.GE31309@elte.hu>
 <20080701111601.GT4729@genesis.frugalware.org>
 <20080701112235.GC11809@elte.hu>
 <20080701114118.GU4729@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Jul 02 01:56:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDpiF-0001AV-3s
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 01:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757280AbYGAXzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 19:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757252AbYGAXzr
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 19:55:47 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50886 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754944AbYGAXzP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 19:55:15 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C788E2674C;
	Tue,  1 Jul 2008 19:55:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E88CA2674B; Tue,  1 Jul 2008 19:55:09 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 26546170-47C9-11DD-A683-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87067>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Tue, Jul 01, 2008 at 01:22:35PM +0200, Ingo Molnar <mingo@elte.hu> wrote:
>> [ Oh, and i could switch between git versions without having to rebuild
>>   ;-) ]
>
> I remember about a mail from Junio where he wrote he has a lot of
> versions installed under ~/git/git-version. So usually he has git from
> next as default and he can try ~/git/git-1.5.4/git if he want 1.5.4,
> etc.

Yup.

I have $HOME/git-active/bin on my $PATH and then these:

lrwxrwxrwx 1 junio junio   10 2008-05-25 18:13 /home/junio/git-active -> git-master
drwxr-sr-x 6 junio junio 4096 2007-04-04 02:49 /home/junio/git-maint
drwxr-sr-x 5 junio junio 4096 2007-12-14 22:46 /home/junio/git-master
drwxr-sr-x 6 junio junio 4096 2008-06-23 22:02 /home/junio/git-next
drwxr-sr-x 7 junio junio 4096 2007-12-02 02:52 /home/junio/git-pu
drwxr-sr-x 4 junio junio 4096 2006-10-14 22:43 /home/junio/git-snap-v1.0.0
drwxr-sr-x 4 junio junio 4096 2007-01-11 22:27 /home/junio/git-snap-v1.1.0
drwxr-sr-x 4 junio junio 4096 2007-01-11 22:26 /home/junio/git-snap-v1.2.0
drwxr-sr-x 4 junio junio 4096 2007-01-11 22:24 /home/junio/git-snap-v1.3.0
...
drwxr-sr-x 5 junio junio 4096 2008-06-07 12:11 /home/junio/git-snap-v1.5.5.4
drwxr-sr-x 5 junio junio 4096 2008-06-26 17:33 /home/junio/git-snap-v1.5.5.5
drwxr-sr-x 5 junio junio 4096 2008-06-25 14:41 /home/junio/git-test

my "Make" and "Doit" scripts that arrange the $(prefix) for these builds
are found in my 'todo' branch.
