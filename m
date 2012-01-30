From: Junio C Hamano <gitster@pobox.com>
Subject: Re: i18n: Avoid sentence puzzles
Date: Mon, 30 Jan 2012 10:57:12 -0800
Message-ID: <7vty3dauif.fsf@alter.siamese.dyndns.org>
References: <201201301231.21090.schwarzerf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Frederik Schwarzer <schwarzerf@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 19:57:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrwPn-0003ox-5t
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 19:57:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367Ab2A3S5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 13:57:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37067 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752124Ab2A3S5O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 13:57:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DF5B6FE9;
	Mon, 30 Jan 2012 13:57:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kVmaOXag3ca8jntJAFN3bgd2FWQ=; b=pX30/B
	4cwAgxwFtG8aFpEiVGK1+FRf7wLSjbC1qQIzwgcwfR8r6cVxfn0+E4jgoE/CVdlH
	O+WIStHPBKeLX9oRhUBiXUtxnP9qSE8f9Ure1p4UyjMnkMO1pAKks0J7mqbf2t5F
	OJdru6cDjELdKp+zam7wiR7abiK3+slP/XpuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JNkn+D5ofxz8eXTFvhvnAk81X/j1WIG7
	XHow91WBF0uGIwVzupAM8k/ovqz7leNVZqrzhK3DH4AHHvymg7keUbbziK0oIkO7
	2/sVinHeFCQa6rb6TtuTqE2U9kRc3KmkH10u2JHHFYFTKXc6p5fbZwutO9e6Jswy
	6gRed3eL0mk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 057646FE8;
	Mon, 30 Jan 2012 13:57:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8DA666FE7; Mon, 30 Jan 2012
 13:57:13 -0500 (EST)
In-Reply-To: <201201301231.21090.schwarzerf@gmail.com> (Frederik Schwarzer's
 message of "Mon, 30 Jan 2012 12:31:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 389CAC04-4B74-11E1-90CB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189397>

Frederik Schwarzer <schwarzerf@gmail.com> writes:

> So my question would be: Is it considered worth it to extend the code 
> for translators' and translations' sake? If so, I would be glad to 
> help with that.

The sample you supplied for 'branch' vs 'remote branch' is a good change
in the logic to choose what translatable message to use, and I do suspect
that there are other instances of problems of this kind.

I am expecting that we may see some activity to the logic in that file
during this cycle, and we would need to be careful not make people step on
other people's toes, though.
