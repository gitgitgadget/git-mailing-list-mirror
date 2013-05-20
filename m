From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-svn: introduce --parents parameter for commands branch and tag
Date: Mon, 20 May 2013 15:37:23 -0700
Message-ID: <7vobc5th0c.fsf@alter.siamese.dyndns.org>
References: <1368476549-17886-1-git-send-email-tobias.schulte@gliderpilot.de>
	<1368648883-9412-1-git-send-email-tobias.schulte@gliderpilot.de>
	<20130520221340.GA8781@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tobias Schulte <tobias.schulte@gliderpilot.de>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue May 21 00:37:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeYhu-0006Wx-Kt
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 00:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756172Ab3ETWh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 18:37:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38277 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751010Ab3ETWh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 18:37:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7A2820B87;
	Mon, 20 May 2013 22:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=52QPU8A5OW6G6cAiwLKPYlSjGkY=; b=mzkRQq
	6ezbS56dGs6z9UbJnAXpZMDfV8ALvL+xoHRCYBeIt81CH0v1/QmTXIuJ3s09EkFz
	f7TMB14rV6mihhJAhIuLS8P8BP45R23iV4RPUAw2hLUkvlNOtnUv4thlChn9E0H4
	WewL3OiV47846uqSL0QHqSESJEMFaqECpS1oU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F3Jox2BFkOh3LnSPOcRNchlt9DPkNgAg
	OEvUeySeKmg+026tJtAZZ0AfPlKpejO+Rr5vte07aBbZGLOVFyTx6mFZkg0ckhMz
	Z/Rv3WwMJS8r2s1bABhiNP3xtE+muL7SZVXLq3EW2ySWNbzrCUwIHgs639InZeWs
	Um6aA/+fhE8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF8C320B86;
	Mon, 20 May 2013 22:37:25 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3FF7120B84;
	Mon, 20 May 2013 22:37:25 +0000 (UTC)
In-Reply-To: <20130520221340.GA8781@dcvr.yhbt.net> (Eric Wong's message of
	"Mon, 20 May 2013 22:13:40 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D8047790-C19D-11E2-B119-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224990>

Eric Wong <normalperson@yhbt.net> writes:

> Tobias Schulte <tobias.schulte@gliderpilot.de> wrote:
>> This parameter is equivalent to the parameter --parents on svn cp commands
>> and is useful for non-standard repository layouts.
>> 
>> Signed-off-by: Tobias Schulte <tobias.schulte@gliderpilot.de>
>
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
>
> Applied and pushed, thanks.

Thanks; is it a good time for me to pull?
