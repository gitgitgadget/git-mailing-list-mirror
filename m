From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: remove duplicate block for "git commit -c"
Date: Wed, 24 Apr 2013 16:04:50 -0700
Message-ID: <7vvc7b8r8t.fsf@alter.siamese.dyndns.org>
References: <1366836546-11081-1-git-send-email-marten.kongstad@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, felipe.contreras@gmail.com, peff@peff.net,
	manlio.perillo@gmail.com
To: =?utf-8?Q?M=C3=A5rten?= Kongstad <marten.kongstad@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 01:05:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV8kD-0004gb-Vh
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 01:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193Ab3DXXEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 19:04:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49610 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932071Ab3DXXEw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 19:04:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 507F71926E;
	Wed, 24 Apr 2013 23:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w3jjDZDNoZqn2IQGCyU5HJSw9uo=; b=w8liXv
	yPlD5vcIzQwkJJzTHlo+IhWlZOt14BjrMY+ohDvtnJP/BNeQRbMQz1swJk53I2t9
	7HO07DR82qFS9E7p3Sl5O4MDLZ2le3Nmgpv3TP5abcTWs42NAhlL0iASNRxWFDya
	hV48u87TrFRWgM1m0DWt31F6LWDYe5HQH8Fqs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L90QH2aCl4S1Q2wwDuD6XvaOLbeCfNsB
	q/o137tdTGQiazR72g8IA7zwEUuyR7jTB/IczbOcPqL0dDCxbBfKOmTKjnvXP6OX
	Rwi+7el1QDUo449DKsGEMqN9MXEGQR6ihCCLySZHRma+pJKwVQjg9nBcRKgZOdPe
	siif/IJfOnA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44C2B1926D;
	Wed, 24 Apr 2013 23:04:52 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C25F51926C;
	Wed, 24 Apr 2013 23:04:51 +0000 (UTC)
In-Reply-To: <1366836546-11081-1-git-send-email-marten.kongstad@gmail.com>
	(=?utf-8?Q?=22M=C3=A5rten?= Kongstad"'s message of "Wed, 24 Apr 2013
 22:49:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5EB00B08-AD33-11E2-9E67-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222336>

This was caused by a mechanical mismerge at d931e2fb252e (Merge
branch 'mp/complete-paths', 2013-02-08), it seems.  The side branch
fea16b47 wanted to add this block, of course, but the same fix was
done independently in 685397585 already.

Thanks for catching it.
