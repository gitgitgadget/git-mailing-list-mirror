From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-svn: add support for merges during 'git svn fetch'
Date: Wed, 28 Oct 2009 00:17:47 -0700
Message-ID: <7vaazcugv8.fsf@alter.siamese.dyndns.org>
References: <1256006523-5493-1-git-send-email-sam.vilain@catalyst.net.nz>
 <20091020211637.GA32474@dcvr.yhbt.net>
 <20091027124056.6117@nanako3.lavabit.com>
 <20091027071405.GA3236@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sam Vilain <sam.vilain@catalyst.net.nz>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Oct 28 08:18:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N32nK-0007qY-Aa
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 08:18:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757509AbZJ1HR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 03:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757506AbZJ1HR6
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 03:17:58 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42913 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757481AbZJ1HR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 03:17:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 749CD881D8;
	Wed, 28 Oct 2009 03:18:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=XXsBAo6lb2KBTVi/wyx7S+YS1og=; b=deCYJR6Y6YArflsVa0DN7Bx
	f8MvrxCs4wDtcN9k8uXnrvrFdZvBmzc8gu0+ekYs29HJ/Gy/054/YCoWtHtJEDfj
	kBuvdMhGeuYs016LJ0hjChUnx8s1ufNcqNYS80w6ooyhIUIsBOYPmqaRNWkHeLa/
	O89cXbGcot+e+8mfKSCM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=TMeKdp9onKh2C6PGbdYnRtzVXpBFHgb9UilA2z6Ad9Uk86A4t
	Pvke2yKORxJeKj7FT/lR340QGcQ2s+UGVo/qSJStTvWQwUGPxZuU38Odb/YCNNps
	7hZUmxNc3L62QxVYydnKtdskYjRMiKDB27vzr00lt0FvFbx8UizML2Xm6A=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 34C26881D7;
	Wed, 28 Oct 2009 03:17:56 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 66878881D4; Wed, 28 Oct 2009
 03:17:49 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 03A87CC4-C392-11DE-90C3-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131415>

Eric Wong <normalperson@yhbt.net> writes:

> Thanks for the ping, I got sidetracked and forgot about this.  I've
> fixed up minor formatting details, acked and pushed out Sam's changes to
> git://git.bogomips.org/git-svn along with one I small fix I originally
> sent out a bad patch for.

Thanks; pulled.
