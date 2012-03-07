From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/3] Use startup_info->prefix rather than prefix.
Date: Wed, 07 Mar 2012 15:39:37 -0800
Message-ID: <7vy5rcj806.fsf@alter.siamese.dyndns.org>
References: <cover.1331158240.git.jaredhance@gmail.com>
 <a2980b437f2eb81b6bc28ad4ebbf05429485729e.1331158240.git.jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 00:39:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5QSO-0008Cv-6I
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 00:39:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758831Ab2CGXjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 18:39:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64989 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757034Ab2CGXjj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 18:39:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0ECD6753;
	Wed,  7 Mar 2012 18:39:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=F9cExzePViiWofrL9+x6kipV8pE=; b=QnZzLRb827MEVDF3L/xG
	P7vcmISOQUQzjenBX6A8fg+a4sk7cUiPeVKJxjyopyL2+FS57Y0IbwJpuwu7er1i
	hque0WtZD7kYIk4M5xVYpzGMWjp+fVdX2aADOQdJKQOJwvZJPoGe51AkxVmmFJyU
	1pOPEzQkKW003W6+avsqdWc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=KFDWggt56LR2P25v3vfvjjCHlA3PTtKlwAu748qjwoyv4F
	Ohh+sotwRqPCnD19p5qo8S4AMWv2fohcyLJDjGzDRA731OD7xK6E9zwoJF1f+hrv
	8FIhC4dKdhLeIRWuUP6PevtlAoiqjfvfD/F4rcdJ13Wii6tOovh8ADiYSld0Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D942F6752;
	Wed,  7 Mar 2012 18:39:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F03B6751; Wed,  7 Mar 2012
 18:39:38 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CDD44276-68AE-11E1-BA85-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192505>

Nothing seems to have changed in this patch since the last round.

My impression has been that we agreed with your comment

    Note: I'm not quite sure if I actually agree with the first change. It makes
    sense right now if git.c is the only caller, but in the future, it might become
    less flexible.

and decided to drop this patch at least for now.
