From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 6/7] Remove unused and bad gettext block from git-am
Date: Tue, 24 Jul 2012 13:40:49 -0700
Message-ID: <7v1uk0gaem.fsf@alter.siamese.dyndns.org>
References: <cover.1343112786.git.worldhello.net@gmail.com>
 <dc805486adc18bf70cea73f9c6363bb3c4cf6c2b.1343112786.git.worldhello.net@gmail.com> <20120724182700.GI2939@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 22:40:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Stlub-0003cS-R4
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 22:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756050Ab2GXUkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 16:40:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63801 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755637Ab2GXUkw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 16:40:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFAD66DF7;
	Tue, 24 Jul 2012 16:40:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mhGVM4ZYh0i62IgJMc6mzMJMH/Y=; b=KQoJHY
	8hANp0DylWiBbrqK5detZwZy+RjsUp2gX28vKRYcrkVsAll1qdHKvTfJ8En+aqgf
	R80k7T8/gR2Jftyl6kDZG538FJYlwUSilJsevYGJ9fwp5/yClDW8k16Aj0jdv8bD
	NOc1GrPtPp0Wn51LTJfsYK9fW672QNMyRJEgE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n742W1dU1/8fQu2Wa/AaYEiM+83h2roN
	Fk3bckJdxteKnE43+iWxgOmiW5le9M+lWcqgddiyKPeZyzGuEjBUDsgEELYBWxKs
	gvuUPF+9z3PCBb6UhrpFSlCwslaX5xnTOGc/AWp7ceeJsLvQXRVmhn4fUxb3pzVO
	xA4bxe8rC78=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CCE146DF6;
	Tue, 24 Jul 2012 16:40:51 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3A9AD6DF5; Tue, 24 Jul 2012
 16:40:51 -0400 (EDT)
In-Reply-To: <20120724182700.GI2939@burratino> (Jonathan Nieder's message of
 "Tue, 24 Jul 2012 13:27:00 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DB5699B0-D5CF-11E1-8D30-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202069>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> -	-d|--dotest)
>> -		die "$(gettext "-d option is no longer supported.  Do not use.")"
>> -		;;
>
> Luckily the support was removed 4 years ago and I don't think anyone
> is going to run into this, so a different justification could apply.

Still I'd prefer a deprecation/removal not buried in an unrelated
topic.  Can we just leave it untranslated, and send a removal patch
during pre 1.8.0 timeframe?
