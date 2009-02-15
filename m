From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC - draft] List of proposed future changes that are backward
 incompatible
Date: Sun, 15 Feb 2009 15:36:19 -0800
Message-ID: <7v3aefi87g.fsf@gitster.siamese.dyndns.org>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.10.0902151544510.14911@asgard.lang.hm>
 <alpine.DEB.1.00.0902152358330.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: david@lang.hm, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 16 00:37:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYqYd-0008FL-4f
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 00:37:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807AbZBOXg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 18:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752625AbZBOXg2
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 18:36:28 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59244 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331AbZBOXg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 18:36:28 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D7FC92B360;
	Sun, 15 Feb 2009 18:36:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0E1FB2B343; Sun,
 15 Feb 2009 18:36:22 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0902152358330.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Mon, 16 Feb 2009 00:01:08 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 769FC63E-FBB9-11DD-9B86-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110089>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Sun, 15 Feb 2009, david@lang.hm wrote:
>
>> On Sun, 15 Feb 2009, Junio C Hamano wrote:
>> 
>> > Thanks.
>> >
>> > * git-push to update the checked out branch will be refused by default
>> >
>> >  Make "git push" into a repository to update the branch that is checked
>> >  out fail by default.
>> >
>> >  http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=108007
>> 
>> If I understand this one, it will cause grief for quite a few people.
>> 
>> I have a public repository that I push to and then have a trigger that checks
>> out the current version, compiles it, publishes the compiled version, sends an
>> announcement, etc
>
> So you have to set a config variable.  Big deal.
>
> Compared to that, the thousands of new Git users will no longer be bitten 
> by the "do not push to a non-bare repository" issue without a useful error 
> message.
>
> Please, please, publicize that if there is somebody who is doing the same 
> as you (which I deem a dangerous workflow; I certainly do not use it 
> myself) that they will have to adjust their receive.denyCurrentBranch 
> variable.

Yuck.  I wasn't expecting a discussion itself here.  This was a request
for help and comment for a future message that will ask to start the
discussion.

No need to *stop* discussing, but please retitle the thread so that we can
later see which ones are discussion of a particular topic, and which ones
are proposal for addition of new items.
