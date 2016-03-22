From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v2.8.0-rc2
Date: Tue, 22 Mar 2016 10:43:25 -0700
Message-ID: <xmqqoaa6if2a.fsf@gitster.mtv.corp.google.com>
References: <xmqqr3fiaq9f.fsf@gitster.mtv.corp.google.com>
	<56E6D8C4.2010205@drmicha.warpmail.net>
	<xmqqoaahaw99.fsf@gitster.mtv.corp.google.com>
	<xmqqziu19cjz.fsf@gitster.mtv.corp.google.com>
	<56E96096.4020108@drmicha.warpmail.net>
	<CANYiYbFa5i-E0dYYj2dm4pHmQwLJfj3UBc3OspQz93HTP3C3Ng@mail.gmail.com>
	<CAA19uiSUV0C=WQAhgum9MM8r8NixMF8O0XOFxzywSJtBEcGNmQ@mail.gmail.com>
	<xmqqr3f3lhvw.fsf@gitster.mtv.corp.google.com>
	<56F117C7.2030900@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	Ralf Thielow <ralf.thielow@googlemail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 22 18:43:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiQL7-0003VM-FJ
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 18:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395AbcCVRna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 13:43:30 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:55215 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751713AbcCVRn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 13:43:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A934C4E9FE;
	Tue, 22 Mar 2016 13:43:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q5sqouE+Htzc2R0NjM0lmagnj3g=; b=bp1Vb9
	EZiB01xCaDRym2OB4Spw9Yat6ZWSnSlJQTfxEbKuPBdY0BGMBmdw9zUQEWjXUF8A
	PTY2Nz7XXHC7B4c5iK8AnwhLno+aWw1G1/XhWcU2pPc5c+pvxOC7KVYIsbj8rXpW
	9REvxzvjHIK2+tCYwexZkcbc+Y+RlcCJe6wFU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iw8VM58FiGoEFmhefotGHf36ERptwUEo
	ejSXU1VMuRQIOEH1ZLh0/scxJKlXishbQO6mXzgLm5VAhLftKB5UMDYQ6NNsbtwG
	81x79TK1+hXzJiAAMVfTOiTLMnxvec4eGlylMJzoBYEVpnuJmed6qvwVBnsN1IhE
	ZSgoDtdNV4A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9FA514E9FC;
	Tue, 22 Mar 2016 13:43:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 19CCF4E9FB;
	Tue, 22 Mar 2016 13:43:27 -0400 (EDT)
In-Reply-To: <56F117C7.2030900@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Tue, 22 Mar 2016 11:00:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 953A6EEE-F055-11E5-96CB-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289527>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 21.03.2016 21:01:
>
>> If that is the case, perhaps it
>> is also a valid workflow for these collaborating authors of a single
>> document not to update the build product, if they know that nobody
>> cares about how the final output looks like on their individual
>> fork, until their work is merged to some "mainline".
>
> Wouldn't that reasoning imply that there's no point in tracking at all?
> That is, in tracking in the main tree.

Not really.

    >> ... this would create an unresolvable mess
    >> but that is perfectly fine, because you wouldn't even attempt to
    >> merge the build product.  Instead, you would merge the source
    >> material, run the formatter, and pretend as if its output is the
    >> result of the merging of .dvi or .pdf or whatever.

declares "there is no point in tracking at all" for them while
working on their document.  These authors may realize that there is
no point in tracking the build product in order for them to work
together.  And that may lead them to adopt a workflow where they
leave the build product stale on their individual fork.

It is perfectly fine for them to have a (different) reason why they
may still want to keep the build product tracked and kept up-to-date
on the mainline (e.g. they want to give an easy access to non
authors the final document), even after they realize that tracking
build product would not help _their_ work.
