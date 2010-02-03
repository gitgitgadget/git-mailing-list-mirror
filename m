From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gitk translation updates needed?
Date: Wed, 03 Feb 2010 11:46:10 -0800
Message-ID: <7vsk9ihzlp.fsf@alter.siamese.dyndns.org>
References: <20100201151647.GB8916@spearce.org>
 <7vy6jbunu8.fsf@alter.siamese.dyndns.org>
 <7vd40nundv.fsf_-_@alter.siamese.dyndns.org>
 <201002031113.11212.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git <git@vger.kernel.org>
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 20:46:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NclBB-0002gA-3H
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 20:46:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932638Ab0BCTqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 14:46:20 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52652 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932160Ab0BCTqT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 14:46:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DF67B96CD1;
	Wed,  3 Feb 2010 14:46:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Os968rbeKho9hjddTYxDXNjm76c=; b=aZb+ZT
	Dlrlo51/8hZVqWN6AA1TC267dH+xzjTIkoUGJvapC03Hp2dEdEZ8W88oEGCrQc6i
	8N4FFbJx4QI8Nbp68H78WsLhyqid5DJoeNnxYiSekKk3mdkDSjeoJ6sgZ4wUal5e
	+vIMvgjvxVGAn4WQEEfGYmjLpPfugHWQiYWjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ApKuxdd8wZHlkQhlNaJLAUOQY4C69DVW
	JaYvSCqhg+Fbp7KFeQpHjdCOoC+Cb+I+1E23w+RsR86PyaNT0WdtIn2gX2AaExX5
	qkFJb8RxPOFsC+UQyts/foUUurxSrB/ysiln4gX/VU5szFGh/TL53uZx+8AH6PeZ
	3P7IgwtYIew=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A7D0596CCE;
	Wed,  3 Feb 2010 14:46:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C84CF96CCC; Wed,  3 Feb
 2010 14:46:11 -0500 (EST)
In-Reply-To: <201002031113.11212.barra_cuda@katamail.com> (Michele Ballabio's
 message of "Wed\, 3 Feb 2010 11\:13\:10 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CA48C8CC-10FC-11DF-A925-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138872>

Michele Ballabio <barra_cuda@katamail.com> writes:

> On Wednesday 03 February 2010, Junio C Hamano wrote:
>> Generating catalog po/it.msg
>>  msgfmt --statistics --tcl po/it.po -l it -d po/
>>  282 translated messages, 1 fuzzy translation, 6 untranslated messages.
>
> I don't get any fuzzy translation here, but I used to, so I guess it
> regards the copyright message. If that's the case, maybe msgfmt
> mishandles the (C)opyright sign (or maybe gitk uses a weird encoding,
> I don't know).

Sorry, I omitted a step in my report:

 $ make po/gitk.pot
 $ msgmerge -U po/it.po po/gitk.pot ;# and for other languages...
 $ make po/it.msg

Why doesn't gitk ship with pre-generated po/gitk.pot, by the way?
