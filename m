From: Miles Bader <miles@gnu.org>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit state
Date: Thu, 15 Jan 2009 13:10:18 +0900
Message-ID: <buo8wpdfbv9.fsf@dhapc248.dev.necel.com>
References: <87ab9th0rh.fsf@cup.kalibalik.dk>
	<7vfxjlxuu5.fsf@gitster.siamese.dyndns.org>
	<200901142049.54775.bss@iguanasuicide.net>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>,
	git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Thu Jan 15 05:12:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNJaY-00032y-Vz
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 05:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754466AbZAOEKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 23:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754344AbZAOEKv
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 23:10:51 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:50282 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753717AbZAOEKv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 23:10:51 -0500
Received: from relay11.aps.necel.com ([10.29.19.46])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n0F4AJAR018098;
	Thu, 15 Jan 2009 13:10:19 +0900 (JST)
Received: from relay21.aps.necel.com ([10.29.19.20] [10.29.19.20]) by relay11.aps.necel.com with ESMTP; Thu, 15 Jan 2009 13:10:19 +0900
Received: from dhapc248.dev.necel.com ([10.114.113.195] [10.114.113.195]) by relay21.aps.necel.com with ESMTP; Thu, 15 Jan 2009 13:10:18 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id C1671458; Thu, 15 Jan 2009 13:10:18 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <200901142049.54775.bss@iguanasuicide.net> (Boyd Stephen Smith,
	Jr.'s message of "Wed, 14 Jan 2009 20:49:50 -0600")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105765>

"Boyd Stephen Smith Jr." <bss@iguanasuicide.net> writes:
>>We may need a version bump to 1.7.0 to update the UI for this command,
>> but please do test rigorously to build a stronger case for a saner UI.
>
> Instead of changing the meaning of edit, how about introducing a "replace" 
> command?

That seems like at best an awkward workaround, not a real solution to
the problem, which is that the term "edit XXXX" suggests you're starting
with XXXX and modifying it.  The term "replace" by contrast, seems more
to connote entirely removing XXXX and substituting something else.

[I do wonder how on earth the current awkward behavior was accepted in
the first place...]

-Miles

-- 
"Most attacks seem to take place at night, during a rainstorm, uphill,
 where four map sheets join."   -- Anon. British Officer in WW I
