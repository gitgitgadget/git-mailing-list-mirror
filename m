From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/16] pull: cleanup documentation
Date: Thu, 31 Oct 2013 12:42:26 -0700
Message-ID: <xmqqzjpp447x.fsf@gitster.dls.corp.google.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
	<1383211547-9145-4-git-send-email-felipe.contreras@gmail.com>
	<xmqqiowd71kv.fsf@gitster.dls.corp.google.com>
	<CAMP44s3AKnZUJy0O0Hg+G=ER2bRn1nHMBeoJQ=ugCzO4d2WZ-g@mail.gmail.com>
	<xmqqob655kqi.fsf@gitster.dls.corp.google.com>
	<ADB546B4-992E-4B54-953E-B721BECD19B2@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Thu Oct 31 20:42:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vby8X-0002NR-Gp
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 20:42:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753125Ab3JaTma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 15:42:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42057 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752036Ab3JaTm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 15:42:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D28264DBE3;
	Thu, 31 Oct 2013 15:42:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=57C83Co7b4jHOLH1+iLnTqvCIEE=; b=FU1rIg
	WBo/7tAyI+jeTlgv2yWlSn7jAegY3voKxbB1Y9VXOGT681VSHkmgeqPOzUlszmWi
	Gy/5eEpQKCCUsqPlo5a2ZYAlRkitFPUZTyEgJ8HAtYvgcWCc/lnPpUAEehfsU97q
	CRoUL+1OaXXu2E9LZIuy3wdKRmJsmiRVccHVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gcboE7UwwEBWTx6MuB3PuSJ2UUkVhPIO
	TsxaqIGlrxZIxOkewT/ToQOOlv0NA2qRyI+dwjP6ocJ0+1VNsjmd2jLt4Jyk7pDF
	+fJhbc+SCboN2FLAPvhafXMl5bEndbq6TxNLnORrqG4AglJ+oJFR/W5ihy8l4ldf
	uZr647uFHdU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C25334DBE2;
	Thu, 31 Oct 2013 15:42:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 290444DBE1;
	Thu, 31 Oct 2013 15:42:28 -0400 (EDT)
In-Reply-To: <ADB546B4-992E-4B54-953E-B721BECD19B2@quendi.de> (Max Horn's
	message of "Thu, 31 Oct 2013 20:27:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 93019CFC-4264-11E3-B974-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237169>

Max Horn <max@quendi.de> writes:

>> ... The "reality" is more like this:
>> 
>>      origin/master in your repository
>>      |
>>      v
>>      A---B---C master at origin
>>     /
>>    D---E---F---G master in your repository
>> 
>> if you really want to write origin/master somewhere in this
>> illustration.
>
> Actually, I kind of like that. After just reading the existing
> phrasing in git-pull.txt, I doubt that a newbie would catch the
> difference between "origin/master" and "master at origin". With this
> illustration, it's very clearly conveyed that there is a difference.

Yeah, after re-reading the part of the documentation with the
illustration replaced with the above, I was coming to the same
conclusion.
