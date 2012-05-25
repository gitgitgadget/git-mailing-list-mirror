From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Possibility to choose ~/.config/git/config instead of
 ~/.gitconfig
Date: Fri, 25 May 2012 11:58:28 -0700
Message-ID: <7vobpcrstn.fsf@alter.siamese.dyndns.org>
References: <20120525181526.Horde.VibLf3wdC4BPv7AeKacSMiA@webmail.minatec.grenoble-inp.fr> <CAE1pOi0eY2=eNzuTUVGmHuvfGWvxoXSJUADWr0CfPpVe5ktxow@mail.gmail.com> <7v4nr4t9gc.fsf@alter.siamese.dyndns.org> <20120525182558.GC4491@burratino> <7vsjeortwu.fsf@alter.siamese.dyndns.org> <20120525184408.GA4740@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	nguyenhu@minatec.inpg.fr, git@vger.kernel.org,
	matthieu.moy@grenoble-inp.fr,
	Valentin DUPERRAY <Valentin.Duperray@phelma.grenoble-inp.fr>,
	Franck JONAS <Franck.Jonas@phelma.grenoble-inp.fr>,
	Lucien KONG <Lucien.Kong@phelma.grenoble-inp.fr>,
	Thomas NGUY <Thomas.Nguy@phelma.grenoble-inp.fr>,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@phelma.grenoble-inp.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 25 20:58:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXzid-0005hr-1i
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 20:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757588Ab2EYS6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 14:58:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62658 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756770Ab2EYS6a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 14:58:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37E62821B;
	Fri, 25 May 2012 14:58:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+zg1krnlk5peNCGTbvxfeRTbNuI=; b=Qm/pQy
	5ci/26/amUKWvxRl58L1BHZiOmSEAavy2Z8+pk+bGU2lqYZ4qTk6/3sjYEf7UrGG
	qEqwsKVHcUioW25BWtfIoNbVDmFNNHl/83zYQocuZhoUp2z6P1ziTeWH1j5DZaZJ
	6Mownw3YqsEG6N5I054f4msFh/nUBWJfYkmWc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ho9j6nYrFATO+QbGsZwVYAuhBY5FycgG
	vB7lsoAO3NOUN23NQoamx5dcjiDtimMF8BikY7b3Tg15oA2BoRJ6GWr3nrtbv46X
	+wwvZ9cBGHaWQg4KyF6/fUITUbsNAK0U0Un2qy0dqjGXXgilAO++JllxbXRdMOhh
	hUQPLIP7GOk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D2B8821A;
	Fri, 25 May 2012 14:58:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B133F8217; Fri, 25 May 2012
 14:58:29 -0400 (EDT)
In-Reply-To: <20120525184408.GA4740@burratino> (Jonathan Nieder's message of
 "Fri, 25 May 2012 13:44:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9DEFAA7A-A69B-11E1-ADC0-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198507>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> So it is exactly "I do not want ~/.gitconfig, I want ~/.config/git", no?
>>
>> That is something distro should be able to decide.
>
> Except that there is nothing distro-specific about it.  Do you really
> want the config file to have a different name depending on whether one
> is using Debian, Fedora,...

Not me personally.  But distros want to do that, it's their choice.

> Besides, with my distro package maintainer hat on, I can tell you that
> switching the config file to ~/.config/git and not reading
> ~/.gitconfig would be a complete nonstarter.

Absolutely.  So don't choose to deliberately introduce backward
incompatibliity.  Problem solved.

Why is it bad to keep using ~/.gitconfig in the first place?  The UNIX
convention to exclude names that begin with dot is not working for you?
