From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GIT 1.6.0-rc1
Date: Mon, 28 Jul 2008 23:20:08 -0700
Message-ID: <7vr69dky93.fsf@gitster.siamese.dyndns.org>
References: <7vy73myim5.fsf@gitster.siamese.dyndns.org>
 <20080728063838.GB4234@blimp.local>
 <7vwsj6tsm3.fsf@gitster.siamese.dyndns.org>
 <20080728213727.GA3721@blimp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 08:21:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNiaB-0001iG-8t
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 08:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755260AbYG2GUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 02:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755253AbYG2GUP
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 02:20:15 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33956 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755244AbYG2GUO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 02:20:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 09D8143599;
	Tue, 29 Jul 2008 02:20:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6EFA543598; Tue, 29 Jul 2008 02:20:10 -0400 (EDT)
In-Reply-To: <20080728213727.GA3721@blimp.local> (Alex Riesen's message of
 "Mon, 28 Jul 2008 23:37:27 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6718A428-5D36-11DD-97D8-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90590>

Alex Riesen <raa.lkml@gmail.com> writes:

> Junio C Hamano, Mon, Jul 28, 2008 08:44:52 +0200:
>> Alex Riesen <raa.lkml@gmail.com> writes:
>> 
>> > t2103-update-index-ignore-missing.sh still broken on Windows because
>> > of stat.st_size being 0 for directories there.
>> 
>> I recall we did not reach a useful conclusion of that discussion.
>
> Why isn't the proposed patch useful? (and would it be possible to make
> the answer out of plain, small and short words?)

Can you answer out of plain, small and short words why the proposed patch
is correct without unwanted side effects, not just "this seems to solve
the particular issue for me but I don't know if it has unintended side
effects"?
