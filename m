From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] merge: do not contaminate option_commit with --squash
Date: Wed, 27 Apr 2016 08:14:24 -0700
Message-ID: <xmqqeg9raxtb.fsf@gitster.mtv.corp.google.com>
References: <874mb0kkkk.fsf@gmail.com>
	<alpine.DEB.2.20.1604180825170.2967@virtualbox>
	<CAH5451kW3t1Y7oW=uHv85jzHwsnQcDK2jdLisauNF-x1LRwqLA@mail.gmail.com>
	<87a8krpehl.fsf@gmail.com>
	<CAH5451mDYhavx_OLfXe6cC2WguCsFWEBBBBOCPyX3E6ZJw27+w@mail.gmail.com>
	<xmqqy48a6fht.fsf@gitster.mtv.corp.google.com>
	<xmqqtwiy6end.fsf@gitster.mtv.corp.google.com>
	<xmqqk2jkdpjr.fsf_-_@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1604270846200.2896@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Christoph Paulik <cpaulik@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 27 17:14:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avRAt-0007gL-Io
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 17:14:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885AbcD0POi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 11:14:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54801 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752440AbcD0POh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 11:14:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8857814C6D;
	Wed, 27 Apr 2016 11:14:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mf+D9K1MQR6JfRwdYOGIU90GcJs=; b=XQ4eZP
	wv9eQioymCAWaXfOqiGMcNF9Y2KpPULCI4cv/g14y18cOv2XtNWGpEO0mA1eohwd
	pzDGe9Gku+kc1KD/xN8U3LNOOYv55Dpw8I4t3Fk2fJYOF88wvPmWisgiEiho5IjV
	Mh908QiKfZ/EXeGeO84mJPbpSHuIQVWpBc3Tk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PU2HIo6FTJQkZapz4tpMh1l/iUuizwWK
	n1qBE5drfcrMar3vrjL/98x25pwQ57/+VvRGSbpjVJoUUbVNjbS3GCV1GOTcKXe4
	AXTi4iHIzak21dnl/6a95hCrPDcjoi7rnWjKIzaPI8W5JyDWqXQuFxoMfe+kSyNM
	Y9YWGtpNs+s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7F55314C6B;
	Wed, 27 Apr 2016 11:14:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D515614C6A;
	Wed, 27 Apr 2016 11:14:25 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.20.1604270846200.2896@virtualbox> (Johannes
	Schindelin's message of "Wed, 27 Apr 2016 08:46:38 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BAB54C9C-0C8A-11E6-B228-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292730>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>>  * Just a preliminary clean-up for the next one which is on topic.
>
> I think it would make for a nice cleanup anyways.

There is a missing open-brace that causes a compilation error,
though ;-)
