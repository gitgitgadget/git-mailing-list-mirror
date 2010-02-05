From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Showing whitespace on minus lines of diff ouput
Date: Thu, 04 Feb 2010 19:03:48 -0800
Message-ID: <7veil0o02z.fsf@alter.siamese.dyndns.org>
References: <76718491002041747t327bf2f5l85e095244f6ee1ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 11:04:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdL2U-0003Bj-Je
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 11:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572Ab0BEDD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 22:03:56 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41944 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957Ab0BEDDz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 22:03:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E9352979B0;
	Thu,  4 Feb 2010 22:03:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LiOf4uVL/Iptmwm+QzvZFGl7/7A=; b=eLSCtU
	bJFYio9ifECVeRIgzFLB8eFFyJ/xCv3Gj6/QAeAjdI9Hexd1IDOfcEBM+sjv4OqP
	LKOhgN41jBN2PW88Xr6f5jQM7DieL1ZpRFc2uGRHbkL1UAVIS25VEpkGveUi1XmN
	LZZ8G4NRLvxsdhqcVVgjfhUHoX6tBEFsfJ+lY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r5FO4SAiGOu4DIYfBkZzM+IhgrU35qT8
	WxvEgp2Gh9K60+jGt+JmVl3K/i2Oth+i6t4aqhLgKTJWgsqFY7adifZLi/fqE7tm
	JI9sFfSyy2rnJUCWSHfF0GuD7R2GYYXb7kVrnYpseVyqbwQLRIXRR1qRG0Sjquuy
	i369HZ4T+K0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BFC6B979AF;
	Thu,  4 Feb 2010 22:03:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 20B52979AE; Thu,  4 Feb
 2010 22:03:49 -0500 (EST)
In-Reply-To: <76718491002041747t327bf2f5l85e095244f6ee1ed@mail.gmail.com>
 (Jay Soffian's message of "Thu\, 4 Feb 2010 20\:47\:52 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 172EED90-1203-11DF-8AA0-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139027>

Jay Soffian <jaysoffian@gmail.com> writes:

> The colored diff output is quite helpful to show introductions of whitespace.
>
> However, if whitespace has been removed, it's impossible to see in the
> diff output since whitespace is colorized on '+' lines, but not '-'
> lines.
>
> I'm looking at diff.c, but wow. Can someone more familiar with this
> file point me toward how I'd make a patch to colorize whitespace on
> '-' lines as well?

Totally uninterested.  "diff -R" would be enough, wouldn't it?
