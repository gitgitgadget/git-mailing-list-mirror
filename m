From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Comparing commits on two different branches
Date: Mon, 05 Mar 2012 09:38:24 -0800
Message-ID: <7vr4x70wz3.fsf@alter.siamese.dyndns.org>
References: <CAHVO_92V3rRBngrZMLeq17ekKKB41kTmok39uUeZ6aOzxB65dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Mon Mar 05 18:38:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4brl-00054J-2z
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 18:38:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757087Ab2CERi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 12:38:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59288 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756168Ab2CERi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 12:38:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BAF3D773D;
	Mon,  5 Mar 2012 12:38:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VED3un0n9c9i90n4sQmhwNJc86E=; b=EcjOaa
	BRWZpZRk2FRrrU45z9mGrUzF5itR5j8dD7pmQG5RtU9Ime9wm88Q8/bsYSrQoqrw
	oKU/2wfurLpy4bU7xxqyRV/X5QSqcXfQSPSL5CdjQ6L4P6C2KrLn3VjotyDCB41A
	1hKpFODQzYVS3rAus8WVgZUd4u0M5odxf8UPU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OQuuOx6+h4u2oF1+dCwkEQ2Fo0Y3+mmC
	el7VwDnhFF54fo7hj3t3ox8pxTGoygNG4V7LZtq7bKFtuKF2QcrFmYqgrbxnr7AR
	0R9Xp1qH27nN2agNLbU6+pla6rwUkUIYu/txY5zMoDmgoLDo6Z9CMKfaAdP9x7HA
	LnsDg5aYYMg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A62E1773C;
	Mon,  5 Mar 2012 12:38:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C7FC7738; Mon,  5 Mar 2012
 12:38:26 -0500 (EST)
In-Reply-To: <CAHVO_92V3rRBngrZMLeq17ekKKB41kTmok39uUeZ6aOzxB65dQ@mail.gmail.com> (Howard
 Miller's message of "Mon, 5 Mar 2012 16:18:51 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 035C574C-66EA-11E1-BEFB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192258>

Howard Miller <howard@e-learndesign.co.uk> writes:

> I have two branches - I know that one differs from the other entirely
> by a (large) number of commits that I have made over some time.
> Unfortunately, these are now all mixed up with a load of other commits
> that have been merged into both from the upstream project.

"now all mixed up" makes me feel a lot less optimistic, but have you
tried git-cherry?
