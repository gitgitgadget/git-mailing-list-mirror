From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 10/13] credentials: add "cache" helper
Date: Mon, 16 Jan 2012 22:51:54 -0800
Message-ID: <7vy5t6stx1.fsf@alter.siamese.dyndns.org>
References: <20111210102827.GA16460@sigill.intra.peff.net>
 <20111210103407.GJ16529@sigill.intra.peff.net>
 <20120110015038.GA17754@burratino>
 <20120110044430.GA23619@sigill.intra.peff.net>
 <20120110045733.GA12460@sigill.intra.peff.net>
 <20120117060232.GA27343@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 17 07:52:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rn2tl-0008A5-Fd
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 07:52:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087Ab2AQGv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 01:51:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42828 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751886Ab2AQGv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2012 01:51:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E56B433E;
	Tue, 17 Jan 2012 01:51:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uu/zt9NgoJ79iBglHW2yxNbfQ6I=; b=UEkt3y
	cMRDNCOYqAGRJbg7svMnZ/VFHAolf/vxevkHkMl8tTd6kYFGypRRcrz7SIaUgpLt
	TEsEhqKQf4WVzBauP/bVfcAuidmQ9axlJzCWU/dBEh4kG8xa9qGFX5cn/n2urnMQ
	Bj+cueSzDP7iZCgM3OYDX8Bj6fQWmtpWULrq4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ncFVhifXqrLWC+C68B5DbgVLErREwVe+
	kMuqWLeaOQOmu96/TNi3t1fYqHFqfZ9MCRRD5M617C9hxIHCg+QXZeGNCbnPy61l
	kyV65eOfEifP/+a1LIIapcP+oZFoyXdjKkS3fyKNXL37kh5J4wGqcn1/LlUuH1Be
	LIR1Wnfldik=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15872433D;
	Tue, 17 Jan 2012 01:51:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 85F44433B; Tue, 17 Jan 2012
 01:51:55 -0500 (EST)
In-Reply-To: <20120117060232.GA27343@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 17 Jan 2012 01:02:32 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BE795DD8-40D7-11E1-BFA5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188695>

Thanks, really appreciated.
