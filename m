From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] status&commit: Teach them to show commits of modified submodules.
Date: Fri, 02 Nov 2007 17:01:08 -0700
Message-ID: <7vfxzoyz7f.fsf@gitster.siamese.dyndns.org>
References: <1194004427-26934-1-git-send-email-pkufranky@gmail.com>
	<7vd4us1jds.fsf@gitster.siamese.dyndns.org>
	<46dff0320711021650q4e56d025q63a961176c682a14@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Yin Ping" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 01:02:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io6TR-0003AO-SL
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 01:02:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761564AbXKCABY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 20:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761946AbXKCABX
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 20:01:23 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:35470 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755854AbXKCABW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 20:01:22 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 3A59C2EF;
	Fri,  2 Nov 2007 20:01:41 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id C3B4590103;
	Fri,  2 Nov 2007 20:01:36 -0400 (EDT)
In-Reply-To: <46dff0320711021650q4e56d025q63a961176c682a14@mail.gmail.com>
	(Yin Ping's message of "Sat, 3 Nov 2007 07:50:51 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63195>

"Yin Ping" <pkufranky@gmail.com> writes:

> On 11/3/07, Junio C Hamano <gitster@pobox.com> wrote:
>> How does this work when you are a toplevel developer and do not
>> have the submodule cloned and checked out?
>>
>> Our code should treat having the submodule directory and not
>> having it when there is a mode 160000 entry in the index equally
>> likely.  Cloning and checking-out is _not_ the norm (nor the
>> exception).
>>
> When submodule is not cheched out, it is never modified.

How so?  Can't you update the index alone?
