From: Junio C Hamano <gitster@pobox.com>
Subject: Re: tr/pty-all (Re: What's cooking in git.git (Dec 2011, #04; Tue,
 13))
Date: Wed, 14 Dec 2011 19:23:14 -0800
Message-ID: <7vfwgmplgd.fsf@alter.siamese.dyndns.org>
References: <7vobvcrlve.fsf@alter.siamese.dyndns.org>
 <20111214070916.GA14954@elie.hsd1.il.comcast.net>
 <201112141717.15021.trast@student.ethz.ch>
 <20111214230713.GA13128@sigill.intra.peff.net>
 <20111214232151.GB13128@sigill.intra.peff.net> <20111214233119.GA2354@elie>
 <20111215002530.GA2566@sigill.intra.peff.net>
 <20111215005057.GB2566@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4g?= =?utf-8?B?VGjDoWkgTmfhu41j?= Duy 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 15 04:23:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rb1uj-0002JZ-Ru
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 04:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758618Ab1LODXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 22:23:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64010 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755974Ab1LODXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 22:23:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 728D771D5;
	Wed, 14 Dec 2011 22:23:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oqzlBi8E/HpVuuf6lZKtAe8aKoc=; b=wK23MY
	6+OoKBdDszk4GRzIpPvMORi7sl4lqfxp4GMu/tK1uqryHSCMMySn1g6ja4py31l8
	qcr1EXwAe6W8586SJk6EPnufzELLdtFinoMmZMor+IS0uT7/hlknkFI++pbM1Hth
	xrWOJIxNlaR37/yL9A0BOZK24oyJXi88XzDUA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eDx7qKfN5jdXoRL62yaBeTvcGbZlqUQL
	YjFo09ldpsq4/i7yS5E7N84GIBQNGRZThvX2PD3EfpjEAZUE9OKSEnDITbKrCrNU
	7XYt1oTOzg2+2gLrSfM8HgOEuWWb2dL4BHrGAuX2axIWpL5qRYaBR+E2CQjL1RjU
	phhgPudk1P4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 680BF71D4;
	Wed, 14 Dec 2011 22:23:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F2D8E71D3; Wed, 14 Dec 2011
 22:23:15 -0500 (EST)
In-Reply-To: <20111215005057.GB2566@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 14 Dec 2011 19:50:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 209BA118-26CC-11E1-98EB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187187>

Jeff King <peff@peff.net> writes:

> This correctly detects the bug in t7006. I can't decide if it's clever
> or ugly.

I would say it falls on the latter side of the line by small margin. Let's
do the /dev/null thing and be done with it.
