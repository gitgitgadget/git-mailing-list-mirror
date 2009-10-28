From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool--lib: add p4merge as a pre-configured
 mergetool  option
Date: Wed, 28 Oct 2009 16:37:57 -0700
Message-ID: <7v1vkngkdm.fsf@alter.siamese.dyndns.org>
References: <d411cc4a0910271536u5817802at43f7477dd8ccabc7@mail.gmail.com>
 <20091027230043.GA11607@hashpling.org> <20091028090022.GA90780@gmail.com>
 <d411cc4a0910280837h52596089je9ab4d03383d43cc@mail.gmail.com>
 <d411cc4a0910281439v3388c243v42b3700f73744623@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Charles Bailey <charles@hashpling.org>,
	David Aguilar <davvid@gmail.com>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 00:38:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3I69-0001Vw-5J
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 00:38:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755161AbZJ1Xi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 19:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755132AbZJ1Xi0
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 19:38:26 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43715 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862AbZJ1Xi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 19:38:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DB6696A585;
	Wed, 28 Oct 2009 19:38:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SoPqnAbLSflJaMo2uiO74hYUSlA=; b=fKxRrJ
	sgI5OZyPU5/JoPGjz2AaFYj0Z4Kf2QdmtDtWtrIrwy3qFBwOVgGPNaNk1u4uLXJD
	E6yMAJQ3he3UaMhlH9bdOjORGfBzJK0XKA8MowsDXGC7mLA8ovRMvQQ1g91tFEXq
	PGi5Gz2/HFq4aHBjrqyxAHWi+stD5WQY0ghsU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=itjT2rwSgaujQz9b8HnfkIh5ym4au7pP
	f2batFGLCcfIG5bo35Pkvxcn6tUi/hrWJKfJm8uJk9k3ITS/2ysSjiIQ9dUKWEzy
	odPScAptYqG1DrgOydRRmTsuCeftSJ01R4IvflR71pwCPSzRN9bEjzsN1U2Eb480
	JYj6217DVA8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 924BF6A582;
	Wed, 28 Oct 2009 19:38:25 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 984186A57B; Wed, 28 Oct
 2009 19:38:15 -0400 (EDT)
In-Reply-To: <d411cc4a0910281439v3388c243v42b3700f73744623@mail.gmail.com>
 (Scott Chacon's message of "Wed\, 28 Oct 2009 14\:39\:32 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FCB6CFEA-C41A-11DE-829C-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131512>

Thanks.  Is Jay happy with this version?
