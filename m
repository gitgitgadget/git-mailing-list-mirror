From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] symbolic-ref: trivial style fix
Date: Tue, 15 Oct 2013 16:34:37 -0700
Message-ID: <xmqqbo2q9khe.fsf@gitster.dls.corp.google.com>
References: <1379780993-4190-1-git-send-email-felipe.contreras@gmail.com>
	<xmqq4n8ich89.fsf@gitster.dls.corp.google.com>
	<20131015231628.GG9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 16 01:34:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWE8S-00071q-7v
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 01:34:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933952Ab3JOXek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 19:34:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37220 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933597Ab3JOXek (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 19:34:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A7A454BB83;
	Tue, 15 Oct 2013 23:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=riVF9GMCHB3MRItv9fs21aEGbWI=; b=VxjVzn
	L/FcvOyGI4p7gxDC6SreO3UIMNNFxbaCZPzAeTv9ZDQe9/nJqMFIXLU38Xpri/5k
	7pVGCsIcB/9PyIMhcRVlHWY6p/41Oda2VM0/kar+QkpheDIwsqMZcHEG69KPEVIi
	OATgxEc38GhVyrFxszP7oTQuiGpV6v4zQWcK4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mzrUvYaMFwRBj4/6jfs8+z1X+zJYzpgr
	oEOPTc5HV8KubV1BJaBYWvirZgMP37kn7KuNSVyPDbJP7n8ntY6tQZE/K8E1TbIP
	oSYI1KKcTHasPNu3TJlVPQX6dWQKWbQgZ3NEdiTEZqalANG0uhB5vcmEnxfGMHV2
	NpYRaFniQe0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 930F54BB82;
	Tue, 15 Oct 2013 23:34:39 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC4AA4BB81;
	Tue, 15 Oct 2013 23:34:38 +0000 (UTC)
In-Reply-To: <20131015231628.GG9464@google.com> (Jonathan Nieder's message of
	"Tue, 15 Oct 2013 16:16:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5BCD40DE-35F2-11E3-8311-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236220>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> -		     &&	dfa->nodes[node].type == CHARACTER
>> +		     && dfa->nodes[node].type == CHARACTER
>
> It took a little staring to see what changed here.  The preimage has
> a tab, probably from an autoformatter gone wild.  I don't think fixing
> it should interfere with importing new versions of compat/regex, so
> the change seems fine.

xdiff/xemit.c had the breakage of the same nature. Perhaps the
commit log message should mention these two.
