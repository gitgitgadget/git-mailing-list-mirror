From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach "log -F --author=<match>" to behave better
Date: Thu, 04 Sep 2008 12:06:06 -0700
Message-ID: <7vk5dr3f4x.fsf@gitster.siamese.dyndns.org>
References: <g9o0ac$qig$1@ger.gmane.org>
 <7v4p4w75b7.fsf@gitster.siamese.dyndns.org>
 <7vprnk5n3c.fsf_-_@gitster.siamese.dyndns.org>
 <20080904133344.GA3197@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Thu Sep 04 21:07:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbKBK-0005YN-2y
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 21:07:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753610AbYIDTGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 15:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755480AbYIDTGQ
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 15:06:16 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63553 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754554AbYIDTGO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 15:06:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 05F4E5B220;
	Thu,  4 Sep 2008 15:06:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 43AE25B21F; Thu,  4 Sep 2008 15:06:09 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8AAA9A4A-7AB4-11DD-82D4-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94949>

Teemu Likonen <tlikonen@iki.fi> writes:

> One of the problems was that with
>
>     git log -E --author=pattern
>
> the pattern is interpreted as basic regexp but with 
>
>     git log --author=pattern -E
>
> as extended rexexp.

I think Jeff fixed that one already on 'maint'.
