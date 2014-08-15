From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-rebase.txt: fix -f description to match actual git behavior.
Date: Fri, 15 Aug 2014 14:57:48 -0700
Message-ID: <xmqqioltza8z.fsf@gitster.dls.corp.google.com>
References: <87bnrq22uf.fsf@osv.gnss.ru>
	<xmqq4mxh5w34.fsf@gitster.dls.corp.google.com>
	<xmqqzjf94f5n.fsf@gitster.dls.corp.google.com>
	<87d2c22cnx.fsf@osv.gnss.ru>
	<xmqq38cx1w0e.fsf@gitster.dls.corp.google.com>
	<87ioltik7g.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergey Organov <sorganov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 23:58:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIPVb-0006E8-OC
	for gcvg-git-2@plane.gmane.org; Fri, 15 Aug 2014 23:58:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbaHOV6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2014 17:58:00 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52620 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301AbaHOV57 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2014 17:57:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 86072320E0;
	Fri, 15 Aug 2014 17:57:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q6+6WMK8GoSX+cuylamWDxWJTTo=; b=TD67sC
	5Fpa/qxGAg9V9CbbcYd6PDQDjE7xdjmOHuo4xyeyWl2yjy6Oywo3dUZz6FUqiqVw
	MKPcQb1x8w5dbQGGRe6TGuy8RebsvnhED9G4lN02cY3xVL1fPMpOAGOj7ZqSfcYg
	JSahxjUUe7N0YEQEW4gjKqJ0+BbuAPzpxXcMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UG3Dd59TEiANKnAdZgVqpsUXpIHB25MU
	XY7DlJ19shluD1IzvGXwA4jqjsJfvYQxA48CCwW5HQSHAi6+qUMOs0oC6SwgaZT/
	rEcnmF62CuYhmGr/MaxnCYGpQ8l05nSGmAYz7FZGcJYSXSYzdKWM03IpzcDxQA6I
	Ip1SrYtM1ZE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7AE94320DF;
	Fri, 15 Aug 2014 17:57:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 45A4A320CF;
	Fri, 15 Aug 2014 17:57:50 -0400 (EDT)
In-Reply-To: <87ioltik7g.fsf@osv.gnss.ru> (Sergey Organov's message of "Sat,
	16 Aug 2014 00:14:43 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 33229674-24C7-11E4-A952-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255307>

Sergey Organov <sorganov@gmail.com> writes:

>> A sentence "--force has no effect under --preserve-merges mode" does
>> not tell the readers very much, either and leaves them wondering if
>> it means "--preserve-merges mode always rebases every time it is
>> asked, never noticing 'ah, the history is already in a good shape
>> and there is no need to do anything further'" or "--preserve-merges
>> mode ignores --force and refuses to recreate the history if the
>> history is in the shape the mode deems is already desirable."
>
> In fact there is no way to force rebase when --preserve-merges is given.
> Neither --force nor --no-ff has any effect.
>
> Maybe some clarification could be given in --preserve-merges
> description, provided it's not clear that "has no effect" for --force
> means that one can't force the rebase in this case.

I am not sure if that is an intended behaviour or simply a bug (I
rarely use preserve-merges myself, so I offhand do not know for
certain).
