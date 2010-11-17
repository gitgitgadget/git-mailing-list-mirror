From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/10] t3404 (rebase -i): move comment to description
Date: Wed, 17 Nov 2010 15:12:20 -0800
Message-ID: <7v62vvee97.fsf@alter.siamese.dyndns.org>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
 <1286136014-7728-16-git-send-email-newren@gmail.com>
 <20101031014654.GC29456@burratino> <7vr5f73umz.fsf@alter.siamese.dyndns.org>
 <20101031072640.GA11483@burratino> <20101031073951.GI11483@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	avarab@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 18 00:12:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIrBA-0001Km-8E
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 00:12:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805Ab0KQXMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Nov 2010 18:12:33 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63103 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935679Ab0KQXMc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Nov 2010 18:12:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1650C298C;
	Wed, 17 Nov 2010 18:12:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=mkfSFiiMp8IVHBextqAjJq1JQKo=; b=gqQ5ehLZTksDJisAiimZNBT
	GrfHeaprvV5isnUY+jO3/hBXnnuRYRrYQMQ/b8+sWiM4sX8crHx5C6fTnyZ5s0uW
	74FqD/JhLm5t35oPhkoEbmUQ7cd8FsbqvaqEr+an/XO6EDE7F3qhKaIdhmdK+4B0
	eV5ZU7gJG+PAo7ttREnw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Yk8iHJFUDchpryIXJMXw8A77jahuzaKqJT0Degv5MkljpWXEU
	7kTzH/I3+U7TJwuKpIgwxUspbpWJOHi5CEL+i8EktAC1dXIAotKYxdIYdmLhTnBE
	An33Rx0WvnWsIvUh3UEyFLkG4ZB5M7iBvmjOl2HBQys5QEZZszz6WE2L3A=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CB5A32983;
	Wed, 17 Nov 2010 18:12:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7E98B2980; Wed, 17 Nov 2010
 18:12:30 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2A0349D8-F2A0-11DF-9753-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161637>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Add a comment describing the setup in t3404 to its --help output.

You learn new things every day---I didn't know our tests supported the -h
option ;-)

Yeah, yeah, e1970ce ([PATCH 1/2] Test framework take two., 2005-05-13) was
mine, but I forgot all about it.
