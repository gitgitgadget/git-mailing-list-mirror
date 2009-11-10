From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 18/24] merge: do not setup worktree twice
Date: Tue, 10 Nov 2009 12:11:55 -0800
Message-ID: <7vws1y6sxg.fsf@alter.siamese.dyndns.org>
References: <20091109150235.GA23871@progeny.tock>
 <1257779104-23884-18-git-send-email-jrnieder@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 10 21:12:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7x4T-0000aw-N5
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 21:12:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758028AbZKJUL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 15:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757992AbZKJUL6
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 15:11:58 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35373 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757980AbZKJUL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 15:11:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D1827BFB7;
	Tue, 10 Nov 2009 15:12:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=70EcN68sGTBF+wWankvatmAbenY=; b=FnKBFZqzUl2AsejIIkLyRTe
	+2WPHQR/Oyq+OB2Ja5JLBgXXlNXoFX2tcsn+UC5K3IIzcEfZbRXZHYm8BGTwx8OA
	k9iFQ0+2G+YOWAkVTo9Ry/OzB3NFnxTs+v3BVRhtWjDgaW6+pQ1ZltPISLu3U0Em
	L7UAfUS/WnyBXSydQS1s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=UKfIDWp/IPS6SfTQ+Y3mOn6IAxjmrwOb3hjuh6acrnTJ37Xrs
	iLTE1Pns/TPTsUQ7xfrlSh/LEIm+o8ohl5zk2YI4cgYpJ0W68qpeRMaEu1l6tFgl
	yhmiJGmPHMoJIoTHIWLtjfiRwLYHaG8RHdgRY8e0/YU2qTdnpsSyaWTUaQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E0A9D7BFB6;
	Tue, 10 Nov 2009 15:11:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 263FA7BFB5; Tue, 10 Nov
 2009 15:11:56 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4DA4895A-CE35-11DE-9A99-7B3EEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132590>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Builtins do not need to run setup_worktree() for themselves, since
> the builtin machinery runs it for them.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> This matter since '-h' cannot suppress _this_ setup_work_tree()
> through the builtin machinery.

I think this should directly go to 'maint'.  I ejected it from the
series.

Thanks.
