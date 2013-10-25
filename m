From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-parse --parseopt: add the --sticked-long mode
Date: Fri, 25 Oct 2013 15:01:15 -0700
Message-ID: <xmqq1u39j9hw.fsf@gitster.dls.corp.google.com>
References: <20131016223306.GN9464@google.com>
	<1382732291-5701-1-git-send-email-boklm@mars-attacks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Vigier <boklm@mars-attacks.org>
X-From: git-owner@vger.kernel.org Sat Oct 26 00:01:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZpRc-0001er-3Q
	for gcvg-git-2@plane.gmane.org; Sat, 26 Oct 2013 00:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056Ab3JYWBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 18:01:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34994 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751514Ab3JYWBT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 18:01:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E2664DDE8;
	Fri, 25 Oct 2013 22:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EtK0/0rB9eSP2XaP2/Jqcf/mKko=; b=OcrpW7
	vkm74hpOVHZzXpF182twGK0jHZCvYN5xQu5jpump0tCCVJM78aCnJQ0ZYmbwFWs0
	vgU/5F6UfB04vym+KOc4fHQNWxOvDpQlrxoSsDW2DP6282xxvk1yWgeWopMIA3VF
	3qbkSDzbdzs6dsLKPnTI4sEKQvlZzqxbPNx6w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mQujdL0pSvbc5Pe7bOJVU/znq2T4/ja/
	R11roVhTcI4iFNI7Cr+jYN5n5bLW25Cvk1LImzUzaOtM2AM9e92SnFRxh3zmFeP2
	6ns3B9IJjEzpL8GpGRV/E0Kz7fk5yI6oZryPR0nm10xYBvXd5UmeoIezeOkWAhH5
	05Z0Li/CMXk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C8B84DDE7;
	Fri, 25 Oct 2013 22:01:19 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 77BF14DDE5;
	Fri, 25 Oct 2013 22:01:18 +0000 (UTC)
In-Reply-To: <1382732291-5701-1-git-send-email-boklm@mars-attacks.org>
	(Nicolas Vigier's message of "Fri, 25 Oct 2013 22:18:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F9C96CEC-3DC0-11E3-B41B-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236718>

Nicolas Vigier <boklm@mars-attacks.org> writes:

> Add the --sticked-long option to output the options in their long form
> if available, and with their arguments sticked.

Hmph, doesn't verb "stick" conjugate to "(present) stick (past) stuck
(pp) stuck"?
