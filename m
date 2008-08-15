From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] bash completion: Add completion for 'git mergetool'
Date: Thu, 14 Aug 2008 17:15:58 -0700
Message-ID: <7v63q3cev5.fsf@gitster.siamese.dyndns.org>
References: <1218753671-58099-1-git-send-email-lee.marlow@gmail.com>
 <1218753671-58099-2-git-send-email-lee.marlow@gmail.com>
 <20080815000541.GE3782@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lee Marlow <lee.marlow@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 15 02:17:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTn0E-0007Md-IZ
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 02:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbYHOAQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 20:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751864AbYHOAQK
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 20:16:10 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43643 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbYHOAQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 20:16:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0D7F15D464;
	Thu, 14 Aug 2008 20:16:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A3B765D461; Thu, 14 Aug 2008 20:16:00 -0400 (EDT)
In-Reply-To: <20080815000541.GE3782@spearce.org> (Shawn O. Pearce's message
 of "Thu, 14 Aug 2008 17:05:41 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5B7D557E-6A5F-11DD-A548-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92447>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Lee Marlow <lee.marlow@gmail.com> wrote:
>> The --tool= long option can be completed with
>> 	kdiff3 tkdiff meld xxdiff emerge
>> 	vimdiff gvimdiff ecmerge opendiff
>> 
>> Signed-off-by: Lee Marlow <lee.marlow@gmail.com>
>
> Acked-by: Shawn O. Pearce <spearce@spearce.org>
>
> ... for both patches in this series.  But this is new functionality
> so it probably won't be in 1.6.0; its too late in that release cycle.

Heh, you are too cautious ;-)

Both "log --merge" and mergetool have been with us for quite some time,
and I certainly do not mind taking [2/2] if not both.
