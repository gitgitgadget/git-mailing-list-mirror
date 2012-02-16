From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Document format of basic Git objects
Date: Wed, 15 Feb 2012 23:12:42 -0800
Message-ID: <7vwr7nz1xx.fsf@alter.siamese.dyndns.org>
References: <1329312140-24089-1-git-send-email-pclouds@gmail.com>
 <7v4nur2806.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 16 08:12:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxvWO-0007fO-3X
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 08:12:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757387Ab2BPHMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 02:12:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62847 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757359Ab2BPHMp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 02:12:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 504CA5138;
	Thu, 16 Feb 2012 02:12:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BOmcUowoRLulucMoExhdIKaxOls=; b=h7BEqG
	Onf8LAYKRN1tLxtxryRPVtGgFbuYA58KqOByfIPVGknH+8d0AyKRWESP59o6REzE
	cmJgH+XPTupp/LRpkpSCuGOqGMpGxOiQrtVyoDQD+pcqQdnoiR7OQ0q4Ck8QmeuH
	PeKIvVdGYNGzXK32GCrNGmH87sbkAQ55icJ+M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IOp8wDDQx6XHMS5mZwiISe8z8q0uvALS
	AqiVi+XN0Dhl2ocyBvkmoUbZ4YDhhz4nunOZwxeqk5lTVY6Ca8c9nBIKp7lWUj4r
	HFWPaQYYO5Ke0M/D5hVhsUygrM7st81UwIW/0g5qAlDGzNCWk2Tdk4ntmPqjH8jq
	DVpvXx3qHFo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 476705137;
	Thu, 16 Feb 2012 02:12:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D16D05135; Thu, 16 Feb 2012
 02:12:43 -0500 (EST)
In-Reply-To: <7v4nur2806.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 15 Feb 2012 11:48:09 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9EEAC968-586D-11E1-A8E7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190874>

Junio C Hamano <gitster@pobox.com> writes:

>> +- POSIX file mode encoded in octal ascii
>
> Add ", no 0 padding to the right" at the end, as I heard that every
> imitation of Git gets this wrong in its first version.

Ehh, of course no 0 padding on the LEFT hand side.

Rice-bowl with left hand, chopsticks with right hand. I always mix these
up.  Sorry.
