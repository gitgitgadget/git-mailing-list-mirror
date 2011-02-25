From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 3/3] git-add: rename -u to -a
Date: Fri, 25 Feb 2011 11:40:11 -0800
Message-ID: <7vipw7aoo4.fsf@alter.siamese.dyndns.org>
References: <cover.1298644872.git.git@drmicha.warpmail.net>
 <a917b13f6944704d5f923d5790e2a43f99ae63ed.1298644872.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Feb 25 20:40:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pt3Wp-0008EZ-E3
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 20:40:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932711Ab1BYTkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 14:40:24 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54059 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932638Ab1BYTkW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Feb 2011 14:40:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4353D4BA2;
	Fri, 25 Feb 2011 14:41:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tkCUUNQwwfPk4WX1xc7NTd2d594=; b=Osb0dM
	u34qciY+aCJd2RJ9XYrqiR9dG2R8+UdNXPmpYZ6zoOqIi42H9TvHbbu+0WlcPdQB
	uVlaGZG+PSTWfoKzcqbUg+UJBf+J2zigSTK17cfiHlJLbl0j82iUsY6x7UdRP2DJ
	i2gLvpt3iYNFpe1v4K4z2cos7NQkUpBV7qeo8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w6bNcoPoOld/gHhNqMI1Yr0HSWs8sf4V
	1lSTezBLHvuYZ88Bq9lVTr7sbkO6SmcIJ/xYYeQgtyfCtzbv/1xhIHK7HfP3d6T1
	DZN0aYVY6+2TgiZ2t/5DA099clVDqsW+Knp6FDaj59vtIO+jHSUyYqHk627oBcIA
	/NPmoWJqvak=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 11F7E4BA1;
	Fri, 25 Feb 2011 14:41:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8452D4BA0; Fri, 25 Feb 2011
 14:41:28 -0500 (EST)
In-Reply-To: <a917b13f6944704d5f923d5790e2a43f99ae63ed.1298644872.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Fri\, 25 Feb 2011 15\:45\:54 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4051E72E-4117-11E0-B1BB-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167924>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> since it does what "commit -a" does (minus the committing). The long

I somehow find this quite the other way around.

The original "add -u" makes perfect sense as it is a request to say: "to
the index, add _updated_ contents".  Perhaps "commit -a" is the one that
should gain a synonym "commit -u" to ask "please commit updated contents"
(implying "not new ones").
