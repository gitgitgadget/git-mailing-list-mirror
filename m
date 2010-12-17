From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.7.3.4, 1.6.6.3 and others
Date: Thu, 16 Dec 2010 23:23:27 -0800
Message-ID: <7voc8kkgls.fsf@alter.siamese.dyndns.org>
References: <7v8vzqntl0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 17 08:23:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTUfE-00018E-Eu
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 08:23:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752193Ab0LQHXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Dec 2010 02:23:35 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43922 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869Ab0LQHXf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Dec 2010 02:23:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8826A3FB6;
	Fri, 17 Dec 2010 02:23:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YpTReEkaw0lZKOhWqS4b2h2j7GI=; b=lqhMsi
	0Zztov4m3/GtZ3DIwNB7CDSa1nxzQpuj/IDTukaE7ycZNCry65PG2xq4z6+JmpWR
	VAyaCSC+Gx81NT8U41URNWx9RO3Va5hC9Eh/0iwpK99hP3PFufJFlP0CxNI5lKIf
	jIf6u7iqXOdJVz0gCVES1y2nhvo1zEmFitgbI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cJBk4qoTWsOIRE7WjQ+hixB4jmM5NGwG
	0CTPioyfiHGyv2LnwlK92afeBkz0jC4YZXpouGmCRU3dDKujzwpA80NmuaJp7U9x
	KvrXo28w2kdXOY+R7Ta7M/ttt4tZoXC6nIWQlccjKdG7sfaDu+5ifnkeGsmYrZKE
	pyqoLNM4yX4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 617013FB5;
	Fri, 17 Dec 2010 02:23:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AA6D93FB4; Fri, 17 Dec 2010
 02:23:56 -0500 (EST)
In-Reply-To: <7v8vzqntl0.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 15 Dec 2010 22\:02\:35 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9CF87614-09AE-11E0-92A0-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163865>

Junio C Hamano <gitster@pobox.com> writes:

> The Gitweb fix has also been backported to maintenance tracks of other
> earlier releases (1.7.2.5, 1.7.1.4, 1.7.0.9, 1.6.5.9, and 1.6.4.5) and are
> available from the main repository and shortly will be available from its
> mirrors:
>
>   git://git.kernel.org/pub/scm/git/git.git/
>   git://repo.or.cz/alt-git.git/
>   git://git-core.git.sourceforge.net/gitroot/git-core/git-core/
>   git://github.com/git/git.git/

I generated tarballs and rpm binary packages for these stale-maintenance
releases tonight.  This is just to be thorough; I would not recommend
anybody to use 1.6.X series in 2011 when 1.7.4 series is just around the
corner ;-)
