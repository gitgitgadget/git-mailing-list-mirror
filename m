From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7, resend] gitweb: ref markers link to named shortlogs
Date: Tue, 02 Sep 2008 16:26:54 -0700
Message-ID: <7v1w02i0xt.fsf@gitster.siamese.dyndns.org>
References: <1220384825-19824-1-git-send-email-giuseppe.bilotta@gmail.com>
 <200809030116.13676.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@ucw.cz>, Lea Wiemann <lewiemann@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 01:28:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KafID-00067w-Gz
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 01:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754180AbYIBX1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 19:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754169AbYIBX1G
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 19:27:06 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38631 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754140AbYIBX1F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 19:27:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 310EC70813;
	Tue,  2 Sep 2008 19:27:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D6A097080E; Tue,  2 Sep 2008 19:26:56 -0400 (EDT)
In-Reply-To: <200809030116.13676.jnareb@gmail.com> (Jakub Narebski's message
 of "Wed, 3 Sep 2008 01:16:12 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A612C768-7946-11DD-AB9E-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94738>

Jakub Narebski <jnareb@gmail.com> writes:

> On Tue, 2 Sep 2008, Giuseppe Bilotta wrote:
>
>> This patch turns ref markers for tags and heads into links to
>> appropriate views for the ref name, depending on current context.
>> 
>> For annotated tags, we link to the tag view, unless that's the current
>> view, in which case we switch to shortlog. For other refs, we prefer the
>> current view if it's history or (short)log, and default to shortlog
>> otherwise.
>> 
>> Appropriate changes are made in the CSS to prevent ref markers from
>> being annoyingly blue and underlined, unless hovered. A visual
>> indication of the target view difference is also implemented by making
>> annotated tags show up in italic.
>> 
>> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
>
> Acked-by: Jakub Narebski <jnareb@gmail.com>

Thanks (and thanks, Pasky, too).  Will apply.
