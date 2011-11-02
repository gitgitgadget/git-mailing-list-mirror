From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t3200: add test case for 'branch -m'
Date: Wed, 02 Nov 2011 12:43:25 -0700
Message-ID: <7vpqhaia3m.fsf@alter.siamese.dyndns.org>
References: <4EB153B4.6070404@atlas-elektronik.com>
 <1320246425-2141-1-git-send-email-stefan.naewe@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>
To: Stefan Naewe <stefan.naewe@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 02 20:43:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLgij-0002Kc-Ed
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 20:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778Ab1KBTn3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 15:43:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40564 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750704Ab1KBTn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 15:43:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5D7F686D;
	Wed,  2 Nov 2011 15:43:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N7WuDyLeDcKHEHRrtjsCNHTD4jw=; b=eIeCT6
	N7fmdqayyIyPvRXlWOPc0wkV+TXljZM8OEgX75UzBLCMM93BGe6bjkRfJ58puGG2
	sqAQlTopVtFDg2AYcTiE+2bRRnDvHTsgSHS0246Z+FW8Sdy2a7l2v4XpRc4JKvAN
	eZXDPJ4fZ/0UzAKkK5i8XsjkmWmwntqMdRVO8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nHtA4W3UXFvrzQkcuXYc9gpgRxAe1VQM
	CXEPWGNzJC1duqQgkb/bhUihvWswy6LYV8N6vDtaWqwN0JDKsEtVDPHdFbOQYq6u
	uO8EfYnylR7iokU/1BBPU0ga7ApXNl88XEaDPTyfqq3vA0xU9ek0JeG0xFp93G7j
	4dsZnjRtPmE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBF0E686C;
	Wed,  2 Nov 2011 15:43:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 61666686B; Wed,  2 Nov 2011
 15:43:27 -0400 (EDT)
In-Reply-To: <1320246425-2141-1-git-send-email-stefan.naewe@gmail.com>
 (Stefan Naewe's message of "Wed, 2 Nov 2011 16:07:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EF2C26DC-058A-11E1-AC3B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184659>

Thanks, both.
