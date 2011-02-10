From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [1.8.0] Remove deprecated commands
Date: Thu, 10 Feb 2011 13:08:04 -0800
Message-ID: <7vlj1n38ej.fsf@alter.siamese.dyndns.org>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org> <4D4852EE.6080605@lsrfire.ath.cx>
 <20110202005748.GA13803@elie> <4D543FB4.1040709@lsrfire.ath.cx>
 <20110210205620.GD21144@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 10 22:08:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PndkU-0001SZ-AB
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 22:08:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757056Ab1BJVIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 16:08:17 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34893 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757003Ab1BJVIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 16:08:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 234DD457B;
	Thu, 10 Feb 2011 16:09:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=agRAdzYTGoL31g1iBNEi70XKiBw=; b=Tds8ny
	mt9+lMUdYsAFY+0Z3eYq/whax2ZN4799qWVOtRyYOoToYQHYmqYc9bARp8QkwMiJ
	N598mtwoE0VB1oun6qZsyk+9aqOk2yL0HmzGdzOowirQH5Gu5ox9w2W55muqgnJO
	Se7lwaSTxF/mmYVDTda2eFKChpMg/dRcira9M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KNnPyT30o707KxWhUTgbqcQvbfyLjdnW
	XkFoh50eBIvPmKr99myxOuUTJcpg+4qoruLL+OfM2WHkL4H3XA5llIgLEoa5mOdd
	+3RvuyDHeAxc8GRFZnPVS5s5cWOyeCNCcMN+x5iWOGKM//St7Vd2mUEpg5FFbE3K
	Klu9q0nZXZw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E5C16457A;
	Thu, 10 Feb 2011 16:09:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D4CB04579; Thu, 10 Feb 2011
 16:09:06 -0500 (EST)
In-Reply-To: <20110210205620.GD21144@elie> (Jonathan Nieder's message of
 "Thu\, 10 Feb 2011 14\:56\:20 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0176E4E6-355A-11E0-B567-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166499>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Ah, peek-remote and ls-remote seem to have been introduced at the same
> time.  ls-remote could use all git-supported protocols, while
> peek-remote could only use git protocol.

Yes, peek-remote was a backend for ls-remote, just like http-fetch was one
of the backends for fetch.
