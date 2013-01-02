From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] test: Add target test-lint-shell-syntax
Date: Tue, 01 Jan 2013 18:22:59 -0800
Message-ID: <7vk3rw5nng.fsf@alter.siamese.dyndns.org>
References: <201301012240.10722.tboegi@web.de>
 <7v7gnw8slq.fsf@alter.siamese.dyndns.org> <50E37BD3.6060709@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jan 02 03:23:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqDzH-0001AH-J6
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 03:23:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476Ab3ABCXE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jan 2013 21:23:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35145 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752415Ab3ABCXC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jan 2013 21:23:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 430CBABFA;
	Tue,  1 Jan 2013 21:23:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5eCVgBsGrhpR
	2t4tmsT8Rfbr6Mc=; b=SzT2QctMCVuh8RLdBOq6/xCQG4AzDsZ3lPJEGFmc8qNu
	pjhKgZULSVWTsGmwIIMO8va69LnUqz9zX2IuLAqxrfnLTIiOKjvaBfRbl/AFq6Y9
	ab9+zGN09dek+rlDhIu3sGF4CQRA/UjrX8b5ZA94XL4BciyCZh+NUHn+1tNNgAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=GBbWk0
	6/95zcGoUNWRDugklP9HxaxUvlVy8EP0oWM/g9R06BkkVn8KCpnVFNka+54WpI2W
	Y635qK0hq9IoCAl+ojDnympnDbnuVGKpPaFFHmIskws9vRJjwuau4emG8ksXioVp
	9CEpchPVoqgA/ozOd1GB5igN9/71UN8NrgHPI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33BD9ABF9;
	Tue,  1 Jan 2013 21:23:02 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F813ABF7; Tue,  1 Jan 2013
 21:23:01 -0500 (EST)
In-Reply-To: <50E37BD3.6060709@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of "Wed, 02 Jan 2013 01:14:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 54EA1E32-5483-11E2-A0DA-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212488>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> The suggestion is to run it every time the test suite is run, at the =
begining.
> And it seems to be fast enough:
>
> $ time ./check-non-portable-shell.pl ../../git.master/t/t[0-9]*.sh
> real    0m0.263s
> user    0m0.239s
> sys     0m0.021s

Hmph.  OK.
