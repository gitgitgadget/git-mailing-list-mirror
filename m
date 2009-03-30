From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Add feature release instructions to gitworkflows man
 page
Date: Mon, 30 Mar 2009 11:14:43 -0700
Message-ID: <7vljqmdgj0.fsf@gitster.siamese.dyndns.org>
References: <1238391319-4953-1-git-send-email-rocketraman@fastmail.fm>
 <1238391319-4953-2-git-send-email-rocketraman@fastmail.fm>
 <7vk567ijlf.fsf@gitster.siamese.dyndns.org> <49D10875.2060008@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Raman Gupta <rocketraman@fastmail.fm>
X-From: git-owner@vger.kernel.org Mon Mar 30 20:16:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoM29-0008Kd-Q6
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 20:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689AbZC3SOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 14:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbZC3SOu
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 14:14:50 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59533 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbZC3SOt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 14:14:49 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4A559A0C9;
	Mon, 30 Mar 2009 14:14:47 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9A37BA0C8; Mon,
 30 Mar 2009 14:14:44 -0400 (EDT)
In-Reply-To: <49D10875.2060008@fastmail.fm> (Raman Gupta's message of "Mon,
 30 Mar 2009 13:59:17 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A6F14416-1D56-11DE-AEBA-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115183>

Raman Gupta <rocketraman@fastmail.fm> writes:

> Junio C Hamano wrote:
> ...
> If you wish to remove discussion of 'next' from this document, that is
> probably better done in a separate followup change. Though personally
> I think its a useful concept for readers to learn about as they are
> setting up their own workflows.

I do not have a particularly strong feeling about 'next' either way.

As the document states at the top, it lists ingredients from git.git
management and it is left up to the readers to adopt parts that suit their
needs, while not using others.  In that spirit, the description of 'next'
as "ahead of master that is supposed to be rock solid" may be a good thing
to keep.  It is orthogonal if the project wants to rewind and rebuild
'next' after every feature release---they do not need to (and we didn't do
so for quite some time).  One valid choice by readers is to adopt the
concept of 'next' in their project but never rewind and rebuild it, and
you made that clear that it is optional.  So I think this part of your
patch is good as-is.

>> Other parts (except for the "branch -f" bit I've already told you
>> about in the other message) looked good.
>
> I'll add some discussion about the branch -f bit -- I hope you agree
> that in this document that is distributed with git, some
> beginner-level explanation of the difference between the branch -f and
> the merge approach is warranted?

Surely and thanks.
