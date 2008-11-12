From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] t7700: demonstrate mishandling of objects in
 packs with a .keep file
Date: Wed, 12 Nov 2008 10:10:47 -0800
Message-ID: <7v7i78q0go.fsf@gitster.siamese.dyndns.org>
References: <20081103161202.GJ15463@spearce.org>
 <muOuA1nLBoljLnZoguxeFeKt-8Q-I9Y3ljvxnLWLt9KyA8HwVtMa4Q@cipher.nrlssc.navy.mil> <20081112080909.GA29176@coredump.intra.peff.net> <NRnq_JA3Ngz2v6EUhSwtVu5zewgvJgLsW85zZZqzrYE@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Nov 12 19:13:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0KD6-0007fy-1h
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 19:13:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751982AbYKLSLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 13:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751859AbYKLSLo
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 13:11:44 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64866 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854AbYKLSLo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 13:11:44 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E86A11684C;
	Wed, 12 Nov 2008 13:11:42 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3076416857; Wed, 12 Nov 2008 13:10:48 -0500 (EST)
In-Reply-To: <NRnq_JA3Ngz2v6EUhSwtVu5zewgvJgLsW85zZZqzrYE@cipher.nrlssc.navy.mil> (Brandon
 Casey's message of "Wed, 12 Nov 2008 11:30:26 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5C0DE108-B0E5-11DD-9F1F-C128113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100796>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Jeff King wrote:
>> On Mon, Nov 03, 2008 at 02:37:05PM -0600, Brandon Casey wrote:
>> 
>>> This version replaces the use of 'head -n -1' with a grep, and should work on
>>> all platforms.
>> 
>> Hmm. I'm not sure what happened, but the version in 'next' has "head -n
>> -1" in it.
>
> Well, there were so many revisions, I probably should have re-rolled the
> whole series....
> ...
> if that's the way we want to go. I'm not partial to the phrase honor-pack-keep,
> but I don't think ignore-pack-keep is appropriate, and it's the best I've come
> up with.

Ok, care to send in a series in incremental updates format, please?
