From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Rewriting history with git-filter-branch and leaking objects (?)
Date: Fri, 17 Aug 2007 14:11:55 -0700
Message-ID: <7vzm0pg92c.fsf@gitster.siamese.dyndns.org>
References: <20070817171851.GB13891@glandium.org>
	<86k5ruxdxz.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Aug 17 23:12:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IM96z-0000mg-5N
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 23:12:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758164AbXHQVMB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 17:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757652AbXHQVMB
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 17:12:01 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:52734 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755607AbXHQVMA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 17:12:00 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 0F2A91233C9;
	Fri, 17 Aug 2007 17:12:18 -0400 (EDT)
In-Reply-To: <86k5ruxdxz.fsf@lola.quinscape.zz> (David Kastrup's message of
	"Fri, 17 Aug 2007 19:34:32 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56084>

David Kastrup <dak@gnu.org> writes:

> Mike Hommey <mh@glandium.org> writes:
>
>> I've been playing with git-filter-branch, and was wondering how objects
>> from the original branch are supposed to be removed.
>>
>> It looks like removing the refs/original/* refs is not enough.
>>
>> And it also looks like when all references seem to be removed, git-prune
>> doesn't fully do its job...
>
> It is quite quite hard to get rid of objects.  You need to get the
> reflogs for the commits and the files expired.

An easier way is probably to make a new clone in the
neighbouring directory locally.
