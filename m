From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: Add a svn-remote.<name>.pushurl config key
Date: Fri, 08 Apr 2011 15:25:09 -0700
Message-ID: <7vipuo1iuy.fsf@alter.siamese.dyndns.org>
References: <1302102336-8800-1-git-send-email-asedeno@mit.edu>
 <1302274674-4231-1-git-send-email-asedeno@mit.edu>
 <7vmxk033ic.fsf@alter.siamese.dyndns.org>
 <20110408205437.GB16540@sigill.intra.peff.net>
 <7v4o6830cc.fsf@alter.siamese.dyndns.org>
 <20110408213201.GA20348@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Alejandro_R=2E_Sede?= =?utf-8?Q?=C3=B1o?= 
	<asedeno@mit.edu>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 09 00:25:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8K7Q-0003Mo-1r
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 00:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753190Ab1DHWZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 18:25:26 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63467 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256Ab1DHWZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 18:25:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CB5455D72;
	Fri,  8 Apr 2011 18:27:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VZzUmQZoD4pCvHRd0rxMiTO52ZM=; b=sPtJWI
	r2JQNJkAPAgoRkFqa+HGRrujLafL0EHife9nK3Cl/fOM4BQ2WUUNH3edflltFcoo
	eeXImEwkEVerjQp1y8meD/RCmls92dZSdV4U3mJFqsDmwZYp6Jy9fMORW6TRcyXJ
	+wvLot+vuwX7UtUhZIEKsYdxnEkaRrLHmnG7U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jK6ZJxVWJHXAHcXOms8lUieThsx/u/sO
	L/dH1QUcnYEvlJ4pH7gd9TKs9raNIUwiAXYF+ytYF0X6pzwJ+VaBPhvWIdR/Dt1E
	CY7ObhJ/ZNNv9JXFq6IIC60nYZ24aaSmn3cWxgmwUReeeg/T445oU+63nOsTLY5h
	JOidQ+Huo20=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 78F805D6E;
	Fri,  8 Apr 2011 18:27:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CAE005D52; Fri,  8 Apr 2011
 18:27:06 -0400 (EDT)
In-Reply-To: <20110408213201.GA20348@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 8 Apr 2011 17:32:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5A9A6CDA-622F-11E0-8FEE-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171167>

Jeff King <peff@peff.net> writes:

> I disagree. Format-patch claims to make an mbox, so it should make one
> that is valid.

OK.  That makes sense (even though I think it would make cutting and
pasting somewhat awkward).
