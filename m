From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] git help: group common commands by theme
Date: Thu, 07 May 2015 11:44:56 -0700
Message-ID: <xmqq7fskp6qf.fsf@gitster.dls.corp.google.com>
References: <cover.1430770308.git.sebastien.guimmara@gmail.com>
	<vpqfv7ap25j.fsf@anie.imag.fr>
	<xmqqoalxbo0w.fsf@gitster.dls.corp.google.com>
	<vpqbnhw4w3r.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?Q?S=C3=A9bastien?= Guimmara 
	<sebastien.guimmara@gmail.com>, git@vger.kernel.org,
	sunshine@sunshineco.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 07 20:45:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqQnC-0005s0-7Y
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 20:45:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbbEGSpB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 14:45:01 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63535 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751196AbbEGSo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 14:44:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 639C34D76C;
	Thu,  7 May 2015 14:44:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Acvb/K0wwELLHHnZiT6Nwc+cb/s=; b=bSRM0x
	a6U8VWkDTGY4D6zE5SkBNb22hNpN21LM4tCq8yykfrLRHiBHsd0AuP7sAZgImvBb
	mealHsHrfxsexBgjsBgMupiTVr9AEjrSr8wK+p2CyQTC3kG0oRPt6bA9sHFwT31v
	Tp8uLyjVH17b7npOiGKgfeklvDNqEPt4U/Nnk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Zshv95YJ4sIL6Ee/1JoZ6ySxVYm+R6n5
	o63PSKl9hJbi0rdqonYyJYzIkjXYNVqsRgch49/9R8lSFekc+eE1pMDwQn3+GviT
	uP5g8ymKDS8tF3cptmdxHa0jh5JiJUsi1fOE6XDj0jvc0VC8T5479wRh02XcrCgi
	xfUC9Upuusg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 553F34D76B;
	Thu,  7 May 2015 14:44:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CC42D4D769;
	Thu,  7 May 2015 14:44:57 -0400 (EDT)
In-Reply-To: <vpqbnhw4w3r.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	07 May 2015 10:42:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 28E33B44-F4E9-11E4-A6A8-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268576>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> And the answer may confuse that someone even further (it is not
>> necessarily "rm", but is often "reset").  As a list of simple
>> command set to help the dip-your-toes-in-water process, a new user
>> may be better off starting with "add", "add ." and "commit -a", and
>> learn from the last part of "git add --help" that there are "rm" and
>> "mv" (both of which happen a lot less often than "add").
>
> If one wonders how to remove a file from Git, expecting that user to
> look at the doc for "git add" to find out seems really backwards to me.

Yeah, but you are moving the goalpost.

What you are reponding to is my reaction to your earlier "the
obvious question of someone who just learnt 'add' would be 'and how
do I do the _opposite_?'".  And I would expect such a person to look
at 'add' to find 'SEE ALSO' section.
