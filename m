From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git-sh-setup: make require_clean_work_tree part of
 the interface
Date: Tue, 20 Dec 2011 14:05:54 -0800
Message-ID: <7vzkemj3ul.fsf@alter.siamese.dyndns.org>
References: <7vd3bjj78h.fsf@alter.siamese.dyndns.org>
 <b121d918166dea3b578b075ac6b794967c4bdcbe.1324415678.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Dec 20 23:06:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rd7oz-0007jo-Bw
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 23:06:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392Ab1LTWF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Dec 2011 17:05:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33404 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752216Ab1LTWF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2011 17:05:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C22DF7700;
	Tue, 20 Dec 2011 17:05:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d8SN2ftBLo8S+nEqUgWPPSiFfoY=; b=HP5t72
	IzIWj8TpQqN3GJSzSYwLXa1YcFyL8MO5nHTjI2lFB7Q13RXudebFqVWpQUm2YqKW
	FfwQHcM6dO2n2CaLod3f6egID4A1SfIcFTkK657xblkmhMAwMc0af+T4RIaHav2z
	4NsnChs1GR/5R4eD5kivbD/zLow6Z1cbpwFAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tU8uy1jVW/7bHgTYYXR3JGJFMvPX175l
	IEFe8JA1tg/Ir1FTTJrOaBHiy00ZcfA1vTND4i8F7fJ2J/Jm3tyTxR1g3IAoRu1f
	JIyNx5uy27Z7z7i+v3+mx+EaEK+s+FUyTgUPBuRmCRDs458/X9V/vY9+u9BP7+Sk
	OYExW3iSLoM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B16B976FF;
	Tue, 20 Dec 2011 17:05:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4407076FE; Tue, 20 Dec 2011
 17:05:56 -0500 (EST)
In-Reply-To: <b121d918166dea3b578b075ac6b794967c4bdcbe.1324415678.git.trast@student.ethz.ch> (Thomas Rast's message of "Tue, 20 Dec 2011 22:42:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CA879590-2B56-11E1-87D4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187531>

Thanks, will queue.
