From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] submodule: add 'deinit' command
Date: Mon, 18 Mar 2013 18:45:40 -0700
Message-ID: <7v7gl4mabf.fsf@alter.siamese.dyndns.org>
References: <5112C6F6.4030607@web.de>
 <CABURp0pC2FELxM5aUwxuTqS1roZm+fwkCQA+BoXjrd0+yQMmbg@mail.gmail.com>
 <7v1ubk8u6o.fsf@alter.siamese.dyndns.org> <51477EFF.2010505@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <phil.hord@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	"W. Trevor King" <wking@tremily.us>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 19 02:46:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHlcx-000856-Tv
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 02:46:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757011Ab3CSBpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 21:45:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57053 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754724Ab3CSBpn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 21:45:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 040EEB6B8;
	Mon, 18 Mar 2013 21:45:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KDUCoTzBNdjT5hZ72BY1T+vWvww=; b=uo8DGT
	4toi6EAFqcWlqrJoIYQ8F9BnsvPhZOdBYvLFfMBP9awLIC6XUy7vxoAchW3ody34
	kCz7hYZz1ZTYrbAxZGSOF9sgMatwuOiHz/8Kr+ZoNiJZbIuGn0ij9xWIhWe5WHku
	9nfJ2U4+6yuspBCibhXGt/8pU5XrAfaIFNRjM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ea444q91FhkAscFPkOPxKuoOys9VMGUs
	bpPPyj4uPrMPYJhB4+J10OJUVJG7/OKn+ODH8PMrIWN0b2coxPw1HHJ5CuFGI2Ou
	EW9qm/kfR1FfjnDEc7m5pxQ78FhDvkJO1EMNIwWaslY1bC61vR/fjototity2hDC
	MAOegKUBlyE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EBC2BB6B6;
	Mon, 18 Mar 2013 21:45:42 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5DD9AB6B3; Mon, 18 Mar 2013
 21:45:42 -0400 (EDT)
In-Reply-To: <51477EFF.2010505@web.de> (Jens Lehmann's message of "Mon, 18
 Mar 2013 21:54:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B59DF6CE-9036-11E2-8D40-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218467>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 12.03.2013 17:22, schrieb Junio C Hamano:
>> Phil Hord <phil.hord@gmail.com> writes:
>> 
>>> I think this would be clearer if 'git deinit' said
>>>
>>>     rm 'submodule/*'
>>>
>>> or maybe
>>>
>>>     Removed workdir for 'submodule'
>>>
>>> Is it just me?
>> 
>> The latter may probably be better.  
>
> Hmm, it doesn't really remove the directory but only empties it
> (it recreates it a few lines after removing it together with its
> contents). So what about
>
>     Cleared directory 'submodule'

Sounds the cleanest among the suggested phrasing so far.
