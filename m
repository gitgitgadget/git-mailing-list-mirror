From: Junio C Hamano <gitster@pobox.com>
Subject: Re: commit a1f6baa5 (wrap long header lines) breaks my habit
Date: Tue, 24 May 2011 09:27:46 -0700
Message-ID: <7vboys83nh.fsf@alter.siamese.dyndns.org>
References: <20110524160253.GA7723@scotty.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
X-From: git-owner@vger.kernel.org Tue May 24 18:28:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOuSd-0000Lq-DV
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 18:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756341Ab1EXQ1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 12:27:54 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43266 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755736Ab1EXQ1x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 12:27:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6DA485717;
	Tue, 24 May 2011 12:30:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B3LC4I/X536ASasFWYQ8616Q5G0=; b=D/mHga
	WZ220tr9e9jVuV2vekWZRtpT25TD2GiJL/6xx6alHVSiqiabz3CSAFSfrMNvCw70
	24KSiJbfFAJ8A5AyNi1LMooeDFvdsZPTb8zXr0qYyACNgzqVFvYjuMcbf91wQSDP
	xNNWE9fQN4N+1USsAXI53PpKAYe0cuBKQ0gU4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v62DetaSxW8GEbIYdGWH5fhr4Pl6tI9t
	yVv6umwro6wSFNBer7BzD72GHhhQ259B5E2ih9q5fIILd4RtRwZpi2syDRyn1tm0
	ZrqkfX851U84HKeYBHzIgCI8IWhMdc+78FTbzm5L1NP/yCAJFhofWhx4OxfH9egJ
	zLg7vOqj2pc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2D5175716;
	Tue, 24 May 2011 12:29:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 459F55715; Tue, 24 May 2011
 12:29:56 -0400 (EDT)
In-Reply-To: <20110524160253.GA7723@scotty.home> (Stefan-W. Hahn's message of
 "Tue, 24 May 2011 18:02:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1129C3BC-8623-11E0-9E2F-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174327>

"Stefan-W. Hahn" <stefan.hahn@s-hahn.de> writes:

>    git format-patch -k --stdout a..b | git am -k -3

Why -k to am?
