From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git-for-each-ref.txt: minor improvements
Date: Thu, 05 Jun 2008 11:58:33 -0700
Message-ID: <7vwsl31zfq.fsf@gitster.siamese.dyndns.org>
References: <1212673114-15751-1-git-send-email-LeWiemann@gmail.com>
 <1212691205-24399-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Lea Wiemann <LeWiemann@gmail.com>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 20:59:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4KgX-0006MW-4G
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 20:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbYFES6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 14:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754482AbYFES6q
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 14:58:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53128 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754673AbYFES6p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 14:58:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 36CD95825;
	Thu,  5 Jun 2008 14:58:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 90C135824; Thu,  5 Jun 2008 14:58:40 -0400 (EDT)
In-Reply-To: <1212691205-24399-1-git-send-email-LeWiemann@gmail.com> (Lea
 Wiemann's message of "Thu, 5 Jun 2008 20:40:05 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6B91C068-3331-11DD-8EF9-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83958>

Lea Wiemann <lewiemann@gmail.com> writes:

>  <pattern>::
> -	If given, the name of the ref is matched against this
> -	using fnmatch(3).  Refs that do not match the pattern
> -	are not shown.
> +	If one or more patterns are given, only refs are shown that
> +	match againt at least one pattern, either using fnmatch(3) or
> +	literally, in the latter case up to a slash or entirely.

Thanks.  I suspect we might want to make it even more explicit that this
is "match from the beginning" unlike what git-show-ref does, but your
patch is an improvement even as-is.
