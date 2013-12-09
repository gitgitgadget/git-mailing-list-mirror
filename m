From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2013, #02; Fri, 6)
Date: Mon, 09 Dec 2013 09:43:46 -0800
Message-ID: <xmqqbo0p2a3x.fsf@gitster.dls.corp.google.com>
References: <xmqqk3fh1qrc.fsf@gitster.dls.corp.google.com>
	<52A37D70.3090400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 09 18:44:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq4sE-0001KF-Mj
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 18:44:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759123Ab3LIRn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 12:43:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57062 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754895Ab3LIRn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 12:43:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED391570A2;
	Mon,  9 Dec 2013 12:43:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=142pdt6q8d6wKrUHeSh1Uk4lrQ4=; b=RyMnF2
	MxAHu5YX+7xiGhZaQsUge0wGlciL2WjrnpcF1VSdOGBB2+zEWoODuzjhkbp2miHQ
	SqYlLOWZlFSGe+MzhR5dE1oJ8sF5j3FPBg7R0pZvBVkzTwaQSkxiZ5uyfWF7FiU+
	zxXlkUIixMASRNLMaLO10H9d3wMkHJ7sle/o4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FOypVtLM1AxMyoP6v7ZzrIZTj95efpJ8
	3kcZmZbyZ21vRoKbOcRKFGKf1DZ8378/2Regf/PnXPEtBfpemY1Jp8JhBW0X0OZY
	mgLx437rJ8pH6j8ehFMAOVDSf8mxOkZ8GfCdZYbJUQldkC133ITv7QdZT6HScVzp
	QEfgV3CU1jc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCDA3570A1;
	Mon,  9 Dec 2013 12:43:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E409E5709C;
	Mon,  9 Dec 2013 12:43:48 -0500 (EST)
In-Reply-To: <52A37D70.3090400@gmail.com> (Karsten Blees's message of "Sat, 07
	Dec 2013 20:56:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 75B8D5C6-60F9-11E3-92ED-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239072>

Karsten Blees <karsten.blees@gmail.com> writes:

> Am 07.12.2013 00:52, schrieb Junio C Hamano:
>
>> * kb/doc-exclude-directory-semantics (2013-11-07) 1 commit
>>  - gitignore.txt: clarify recursive nature of excluded directories
>> 
>>  Originally merged to 'next' on 2013-11-13
>> 
>>  Kicked back to 'pu' to replace with a newer reroll ($gmane/237814
>>  looked OK but there seems to have some loose ends in the
>>  discussion).
>
> I'm unaware of any loose ends, could you clarify?
>
> Btw. $gmane/237814 seems to be a different topic, the version in next (and now in pu) was $gmane/237429.

Ah, my mistake. I thought I still had $gmane/237416 and needed to
wait for the discussion to conclude; in fact, a later one in that
thread $gmane/237429 is what came out of that discussion, so this is
good to go, perhaps with an amend with Acked-by: peff.

Thanks.
