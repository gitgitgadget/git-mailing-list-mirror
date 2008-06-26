From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Ask for "git program" even against git-daemon
Date: Wed, 25 Jun 2008 17:07:51 -0700
Message-ID: <7vd4m5vz1k.fsf@gitster.siamese.dyndns.org>
References: <20080625044409.GE11793@spearce.org>
 <7v8wwu6qxr.fsf@gitster.siamese.dyndns.org>
 <7v4p7i6qs1.fsf@gitster.siamese.dyndns.org>
 <7vy74u5bkk.fsf@gitster.siamese.dyndns.org>
 <20080625053848.GJ11793@spearce.org>
 <7v4p7hxhbd.fsf@gitster.siamese.dyndns.org>
 <7vvdzxw2eo.fsf_-_@gitster.siamese.dyndns.org>
 <7vr6alw28s.fsf_-_@gitster.siamese.dyndns.org>
 <20080625232727.GU11793@spearce.org>
 <7viqvxw0i7.fsf@gitster.siamese.dyndns.org>
 <20080625235724.GV11793@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@lavabit.com>, Miklos Vajna <vmiklos@frugalware.org>,
	pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jun 26 02:09:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBf2v-0001Sa-Fa
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 02:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362AbYFZAII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 20:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbYFZAIH
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 20:08:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54232 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbYFZAIF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 20:08:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4AB8CB443;
	Wed, 25 Jun 2008 20:08:04 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 12D5EB442; Wed, 25 Jun 2008 20:07:55 -0400 (EDT)
In-Reply-To: <20080625235724.GV11793@spearce.org> (Shawn O. Pearce's message
 of "Wed, 25 Jun 2008 19:57:24 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F2803838-4313-11DD-942D-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86378>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> "Shawn O. Pearce" <spearce@spearce.org> writes:
>> >
>> > But I wonder if this patch is even worth it at some later point
>> > in time.  Are we also going to change git-daemon to stop accepting
>> > "git-" form?  Is it a worthwhile change?
>> 
>> This was merely responding to...
>> 
>>     From: "Shawn O. Pearce" <spearce@spearce.org>
>>     Subject: Re: [PATCH] Keep some git-* programs in $(bindir)
>>     Date: Wed, 25 Jun 2008 00:37:41 -0400
>>     Message-ID: <20080625043741.GD11793@spearce.org>
>> 
>>     Daniel Barkalow <barkalow@iabervon.org> wrote:
>>     > ...
>>     > Should they use "git upload-pack" [...]
>> 
>>     IMHO they should in the future use "git upload-pack".
>
> Sorry I wasn't clear. I was talking about the SSH transport only.
> For git:// we could just always send git-upload-pack, like your
> transitional patch does.  Then we stay compatible with even very
> old git:// servers.

Ok, if that is the plan, then we wouldn't even need to futureproof
git-daemon at all.

Not having to change anything is good ;-).
