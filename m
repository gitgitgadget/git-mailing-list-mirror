From: Michael G Schwern <schwern@pobox.com>
Subject: Re: Fix git-svn for SVN 1.7
Date: Tue, 31 Jul 2012 02:54:43 -0700
Message-ID: <5017AB63.6080909@pobox.com>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
 <20120730203844.GA23892@dcvr.yhbt.net>
 <7v1ujsl8ut.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org,
	robbat2@gentoo.org, bwalton@artsci.utoronto.ca, jrnieder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 11:54:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sw9AG-0008GV-LY
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 11:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754742Ab2GaJyw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 05:54:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61082 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754498Ab2GaJyv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 05:54:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DC1F793E;
	Tue, 31 Jul 2012 05:54:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=s17AFxzFdfFK
	W/jeHCjwa+M8chM=; b=TlLKR8WuEQtFGJGnrVWVsYnMu/T44teRJ+nUmaqJFI5M
	Klyojqk1jnyRshXuEjUiIKrMOZ+6E/rhB/07GqHZms9BQwRr8ucjvwIKIRR+tLBd
	69dzAfjXiKsP0HmsJcAZgspBWnVSrKu7B+2UP0Kt56+nQAavgNDtuXWIBs8ElK0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=WtBtDp
	Y5WxqlSllar6HXIPDCecxXgUdeQfuLAu5ZDTAJBjM13k+E7tgdd5KDUraskpbMjL
	X/amwQq2T4CrM2Xci5Hbff4dOewnfZclB7oInj35eYs6lDr/S9dHK/+EAXwOL9jV
	8DBWsle0yllCn536pOYKuQq8jQA4EYS7UR2Yw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38F8D793D;
	Tue, 31 Jul 2012 05:54:50 -0400 (EDT)
Received: from windhund.local (unknown [71.236.173.173]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BB67F793A; Tue, 31 Jul
 2012 05:54:48 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0)
 Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7v1ujsl8ut.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: C48B4A48-DAF5-11E1-B1B9-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202643>

It just doesn't matter.

Why are we arguing over which solution will be 4% better two years from now,
or if my commits are formatted perfectly, when tremendous amounts of basic
work to be done improving git-svn?  The code is undocumented, lacking unit
tests, difficult to understand and riddled with bugs.

Either solution would be a vast improvement.  The most important thing is that
one of them actually gets done.  If both solutions offer a huge improvement,
do it the way the person actually writing the code wants to do it.  It'll be
more enjoyable for them, they'll be more likely to complete the work, and more
likely to stick around and code some more.
