From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] git push usability improvements and default change
Date: Wed, 11 Mar 2009 13:35:20 -0700
Message-ID: <7v7i2v4x2v.fsf@gitster.siamese.dyndns.org>
References: <1236638151-6465-1-git-send-email-finnag@pvv.org>
 <7vfxhmdyvn.fsf@gitster.siamese.dyndns.org> <20090310100400.GC11448@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Wed Mar 11 21:37:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhVAk-0002Ap-NI
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 21:37:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbZCKUfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 16:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbZCKUf3
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 16:35:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40313 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbZCKUf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 16:35:29 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 15B01A0BB9;
	Wed, 11 Mar 2009 16:35:25 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 146C5A0BB8; Wed,
 11 Mar 2009 16:35:21 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2666223C-0E7C-11DE-B960-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112975>

Finn Arne Gangstad <finnag@pvv.org> writes:

> On Mon, Mar 09, 2009 at 05:07:08PM -0700, Junio C Hamano wrote:
> ...
>>  * What's the point of having --current option, when you can already
>> say HEAD, i.e.  $ git push origin HEAD
>
> It does something very different. Maybe --tracking would be a better name.
> --current does basically this:
> ...
> The goal here is to be able to:
>
> git checkout -b junios-next origin/next
> git push --current  <=>  git push origin junios-next:next
>
> git push origin HEAD would do git push origin junios-next:junios-next,
> which was not the intention.

Ok, now that sort of makes sense, and is very different from people would
expect from --current, which I think most people would associate with
HEAD.  "tracking" or "track back" would be a better name.
