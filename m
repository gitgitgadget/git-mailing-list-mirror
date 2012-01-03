From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] stash: Don't fail if work dir contains file named
 'HEAD'
Date: Tue, 03 Jan 2012 10:45:55 -0800
Message-ID: <7vhb0cvd3w.fsf@alter.siamese.dyndns.org>
References: <A244F415-73A1-4A77-BC4A-AC7F85946F02@JonathonMah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Jonathon Mah <me@JonathonMah.com>
X-From: git-owner@vger.kernel.org Tue Jan 03 19:46:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ri9N4-0002h5-MK
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 19:46:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754661Ab2ACSp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 13:45:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42100 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754537Ab2ACSp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 13:45:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C3027B72;
	Tue,  3 Jan 2012 13:45:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N7WuDyLeDcKHEHRrtjsCNHTD4jw=; b=MbKeur
	0SgMXr4xUwhk/aBgXTbhzru3Ud49hCEeQ33QAGFA+fDyVUoK77W4ZMw7fvUZ3PBB
	PB4JgoTOcsHUwGn2pIpjDFPOctnD/6zCQ9XDqef2L40w3W3QFR1SXStcC51ng3Vu
	ajJz6caxE5dKXMj5kqGjYdT8al99GMq1IZ/qA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XrGOh6INX4hLNUwvpiShnDs64dhsVfMu
	r1v5XDZc2zAc1JhdP2EeRBHVd80dw7MY/a41QdsCEOX56u6xmu6s1jwS8GO5YePY
	+L6dpjw/81TvmQZCHutzagYk81nZ5Hlg5kj66cCtzwVsKNYp4BUrvQJFUxCTmWZu
	ofZWGToGc1c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 432957B71;
	Tue,  3 Jan 2012 13:45:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CE0727B70; Tue,  3 Jan 2012
 13:45:56 -0500 (EST)
In-Reply-To: <A244F415-73A1-4A77-BC4A-AC7F85946F02@JonathonMah.com> (Jonathon
 Mah's message of "Fri, 30 Dec 2011 16:14:01 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2C17BD5A-363B-11E1-9A38-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187873>

Thanks, both.
