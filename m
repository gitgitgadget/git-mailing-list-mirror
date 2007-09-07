From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Subject: [PATCH] git-merge-pack
Date: Fri, 07 Sep 2007 00:34:55 -0700
Message-ID: <7vd4wv6i8w.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
	<20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix>
	<46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix>
	<alpine.LFD.0.9999.0709051438460.21186@xanadu.home>
	<7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0709061651550.28586@racer.site>
	<7vk5r3adlx.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999.0709061906010.5626@evo.linux-foundation.org>
	<7v1wdb9ymf.fsf_-_@gitster.siamese.dyndns.org>
	<46E0F998.1080202@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Pitre <nico@cam.org>, Nix <nix@esperi.org.uk>,
	Steven Grimm <koreth@midwinter.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 09:35:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITYN1-000806-In
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 09:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbXIGHfI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 03:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbXIGHfI
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 03:35:08 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:38671 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964922AbXIGHfG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 03:35:06 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 4B87B12FD38;
	Fri,  7 Sep 2007 03:35:19 -0400 (EDT)
In-Reply-To: <46E0F998.1080202@eudaptics.com> (Johannes Sixt's message of
	"Fri, 07 Sep 2007 09:11:20 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57998>

Johannes Sixt <j.sixt@eudaptics.com> writes:

> Junio C Hamano schrieb:
>> This is a beginning of "git-merge-pack" that combines smaller
>> packs into one.
>
> This gives a new meaning to the term "merge". IMHO, "git-combine-pack"
> would be a better name.

Yeah, that makes sense, but I think this can and should be done
as part of pack-objects itself as Nico suggested.

So consider that patch scrapped for now.
