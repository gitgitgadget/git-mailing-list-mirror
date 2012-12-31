From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Add MAINTAINERS file and clarify gui workflows
Date: Mon, 31 Dec 2012 10:32:22 -0800
Message-ID: <7vlicedqdl.fsf@alter.siamese.dyndns.org>
References: <1356891535-5647-1-git-send-email-jason.k.holden.swdev@gmail.com>
 <7va9svffr4.fsf@alter.siamese.dyndns.org>
 <loom.20121231T103639-635@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Mon Dec 31 19:32:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpkAG-0007cc-2c
	for gcvg-git-2@plane.gmane.org; Mon, 31 Dec 2012 19:32:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538Ab2LaSc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2012 13:32:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54571 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751402Ab2LaScZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 13:32:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06511B889;
	Mon, 31 Dec 2012 13:32:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=oc3AH+RSe/PZE2W9sLbOnsj52bk=; b=pDiBnPVuiLowck9MCPdI
	lgyj+FXVBOQqbOesuxVrer5ijuUMWnHQtS7iJ57urE0l28g5f352f3WcDwIw4qqy
	Km5jhaY7GLjclV1qbstzu8rfOHLMdsqjDf3pvviyRHdf7oj5oHRkgb9ko+tGun9G
	TkZ+UuZeT5YS2NdIlU7ppuM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=CGBXHxJMdUk1SocNuatFABr5T95qjfUGel0Sb4SyASPDlT
	Ommbo2uuWg6iIkNTBRKuvCo4tWddya8tCvIDobL/YOgghx5SqhCl9FPnWih97OuO
	SYQdyyC11XbjL/FLRqXBfOO+rYY3bUDdgKoeZQh3045t9fIeWA04RvM+2wRg8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9AACB888;
	Mon, 31 Dec 2012 13:32:24 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 541E5B884; Mon, 31 Dec 2012
 13:32:24 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6BC0F240-5378-11E2-80DF-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212358>

Thomas Ackermann <th.acker@arcor.de> writes:

>> Thanks; I just realized that nothing in Documentation/ hierarchy
>> mentions these; they are only mentioned in "A Note from the
>> Maintainer" I send out every once in a while (kept in MaintNotes of
>> 'todo' branch):
>
> Wouldn't it be a good idea to put MaintNotes somewhere below ./Documentation?

Perhaps.  It started as a living document that discusses the state
of affairs as of the time of posting (there are mentions to "the
most recent such release was ...", etc), and because I wanted to
keep it that way (and also I needed somewhere to keep track of it),
I deliberately kept it outside the source tree.

It is an addendum to howto-maintain-git, and what it covers overlaps
with it, so it will need some clean-ups if we want to go the route
you suggest.

Having said all that, I think it is still a good idea to keep the
occasional "A note from he Maintainer" posting on list, and a
version that needs to rever to another document after losing
overlaps with howto-maintain-git will no longer will be suitable
source for it, so...
