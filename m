From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-svn: Fix merge detecting with rewrite-root
Date: Sat, 13 Mar 2010 12:41:35 -0800
Message-ID: <7vaauc9cow.fsf@alter.siamese.dyndns.org>
References: <1267034942-31581-1-git-send-email-tuomas.suutari@gmail.com>
 <20100313094355.GA10052@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>,
	Tuomas Suutari <tuomas.suutari@gmail.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Mar 13 21:41:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqY9i-0006AN-BX
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 21:41:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935639Ab0CMUlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Mar 2010 15:41:49 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41433 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759248Ab0CMUlt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Mar 2010 15:41:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 916FCA1AB9;
	Sat, 13 Mar 2010 15:41:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y/Vwg4jLzSbrlJaU2/lcLQBmJTs=; b=dpqdWz
	o567p5dqStFPa4D2LpSVXGYVAIpkub74HtDiuR8d32HeClhIq0E75/AwBzkmUzmy
	PywCNGjEfnJ5ZbqMS7qEGg8I1q5UrYV6V2R4r+OAz/rO5UjNdMagxmmeoOodK9k+
	4QjR7cSIlfpWSaDustRncWfqIBQ29rI4DPtzM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nDk22tqeDuohsI3cOb/+Si6j9l6JhdLk
	tlljlQcfIrU2BibSo2QujPaj+Rkrf+Z3fW/74apm46Oi95sPCxiemVEliOo3wmHr
	n3othidwPeBd9VTNBqq2cPIeN+ejYnZWDHFSMmOnjuZrhMDhwnFWBeuyjirrjSvv
	kMBwJOiYng8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 43527A1AB0;
	Sat, 13 Mar 2010 15:41:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 60DF9A1AAA; Sat, 13 Mar
 2010 15:41:37 -0500 (EST)
In-Reply-To: <20100313094355.GA10052@dcvr.yhbt.net> (Eric Wong's message of
 "Sat\, 13 Mar 2010 01\:43\:56 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D564F760-2EE0-11DF-AB38-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142104>

Thanks; pulled.
