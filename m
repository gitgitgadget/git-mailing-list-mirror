From: Junio C Hamano <gitster@pobox.com>
Subject: Re: List all SHA1 hashes in repo
Date: Sun, 23 Mar 2008 11:23:06 -0700
Message-ID: <7v8x097111.fsf@gitster.siamese.dyndns.org>
References: <c6c947f60803230617if9606baxea21fa99dc3df37c@mail.gmail.com>
 <alpine.LSU.1.00.0803231459100.4353@racer.site>
 <540004BB-49C4-456B-ABA3-62659D85C15E@ai.rug.nl>
 <alpine.LSU.1.00.0803231532150.4353@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Alexander Gladysh <agladysh@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 23 19:24:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdUrW-0006MX-Oz
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 19:24:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754162AbYCWSX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 14:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbYCWSX0
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 14:23:26 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59390 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbYCWSXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 14:23:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 56E08120A;
	Sun, 23 Mar 2008 14:23:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 98F5311DB; Sun, 23 Mar 2008 14:23:16 -0400 (EDT)
In-Reply-To: <alpine.LSU.1.00.0803231532150.4353@racer.site> (Johannes
 Schindelin's message of "Sun, 23 Mar 2008 15:33:20 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77936>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Sun, 23 Mar 2008, Pieter de Bie wrote:
>
>> On Mar 23, 2008, at 2:59 PM, Johannes Schindelin wrote:
>> > > The git rev-list --all gives nice list, but, as I understand, that 
>> > > is only commit objects, and there are much more of SHA1 hidden 
>> > > inside.
>> >
>> > Just add --objects.
>> 
>> I thought --all --objects only shows reachable objects?
>
> Ah yes.  But usually the objects in packs are reachable...
>
> So you're right, it does not really show _all_ objects.

"rev-list --objects --all"?
