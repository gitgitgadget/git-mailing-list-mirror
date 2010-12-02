From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cannot find hash in the log output
Date: Thu, 02 Dec 2010 12:48:20 -0800
Message-ID: <7v8w07rje3.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=5b26aPLm_Byqg=c9=sPpg5jEPDDpf1J9WgOdY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 21:48:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POG4w-00028Y-EK
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 21:48:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756328Ab0LBUs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 15:48:29 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48485 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752971Ab0LBUs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 15:48:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D2AC7343D;
	Thu,  2 Dec 2010 15:48:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=vFTFils+WADBorPR9/HpTb9BoBo=; b=lKuTaq
	XtkgXtQCp6QdLN4kgvhVUVvyHU6B5hzLMp1RyisFP7kvfK/kcWgbZGv+4baEExOp
	PpGRSZD2LT9FwY15R60QmspAJiULMY8MKdIWkiYFEMpUnX0tJcuC4t0GtwLuhVkS
	R/29VzVWEaxCJD0qfTUXXxYoWMtOXEeGmLVhE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UhTqanwQW29ui0T9+r7D38y3QiCWLW3O
	NdVrgSCVoIFmcJ/+xBC/lJkoMrWB/IpmxJMhP7OLflQDqqEKrsbravkVDfaVgy7S
	pmdf/Fk9hXoWeTsYV2GaIl5s/DWI0yC2tmtNqwYQz4PzAXDzVKsix5LHiHvpNHf4
	0/2tmWa+0X0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AD707343C;
	Thu,  2 Dec 2010 15:48:45 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B18B0343B; Thu,  2 Dec 2010
 15:48:42 -0500 (EST)
In-Reply-To: <AANLkTi=5b26aPLm_Byqg=c9=sPpg5jEPDDpf1J9WgOdY@mail.gmail.com>
 (Eugene Sajine's message of "Thu\, 2 Dec 2010 14\:57\:08 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8E32B9B4-FE55-11DF-83CA-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162744>

Eugene Sajine <euguess@gmail.com> writes:

> I have a strange issue (git v 1.7.3.2). I'm cloning the repository,
> navigating to the folder containing some scripts and performing
> git hash-object <one_of_my_scripts>
>
> Then I'm trying to run:
>
> git log --raw --no-abbrev | grep <resulting SHA1 from previous command>
>
> And i don't see anything.

Do you see it in the output from "git ls-tree -r HEAD"?
