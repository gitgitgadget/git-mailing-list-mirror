From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] submodule: add 'deinit' command
Date: Tue, 05 Mar 2013 07:45:22 -0800
Message-ID: <7vppzdvoj1.fsf@alter.siamese.dyndns.org>
References: <5112C6F6.4030607@web.de>
 <CABURp0oQcPotK20QcqCG1pGQPVoa4RnN2nDA=iQoKS99gnPEAQ@mail.gmail.com>
 <511BEA75.6000002@web.de> <7vip5w6l8s.fsf@alter.siamese.dyndns.org>
 <5121384B.10009@web.de> <7v38wufu5t.fsf@alter.siamese.dyndns.org>
 <51227EFE.6030908@web.de> <51351018.20301@web.de>
 <20130305072944.GA4677@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Phil Hord <phil.hord@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	"W. Trevor King" <wking@tremily.us>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Mar 05 16:45:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCu3r-0003PJ-Sj
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 16:45:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756702Ab3CEPp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 10:45:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58894 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756037Ab3CEPpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 10:45:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EDD5B6E2;
	Tue,  5 Mar 2013 10:45:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=crE5XC4NLIrz2+Sofwnc+vY61D0=; b=QrQTVX
	EIUAM+ZrEy80MY0EfPHdj44Ph6tW97U4yLGLSM4mihxEqy+jO3XhxOaW5goTqKOO
	zTHHtCcZWeZCd0m1cHpVTB5i412TEBg3DK/VdohsGdbSFa5PPSHeajOJc26QZG9p
	t/LR5+6x+ju9Tmd6S4L6VTEh+rlQqZgQLTIk4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B79xbs8yufI78+n1fKAX2TshSYAfBD1a
	WBkT0toYpKN9Be+bi10nugJkzJhHE4Fa8EsIgx3o/DNOGMkPgh0oFNJ0CHkUsrTv
	afyVhmVs3LQVoLFM58mIrN8f8ioUMQVjIoGrdIGZ1E9+VP/86OzsvlNEU/4hKkIO
	mJ7bCflY/xM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CB5AB6E1;
	Tue,  5 Mar 2013 10:45:24 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 01845B6DD; Tue,  5 Mar 2013
 10:45:23 -0500 (EST)
In-Reply-To: <20130305072944.GA4677@sandbox-ub> (Heiko Voigt's message of
 "Tue, 5 Mar 2013 08:29:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B19E009A-85AB-11E2-AC8B-2F862E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217455>

Heiko Voigt <hvoigt@hvoigt.net> writes:

>> +			if test -z "$force"
>> +			then
>> +				git rm -n "$sm_path" ||
>> +				die "$(eval_gettext "Submodule work tree '\$sm_path' contains local modifications; use '-f' to discard them")"
>
> Minor nit. IMO, there is an indentation for the || missing here. Maybe
> Junio can squash that in on his side?

Sorry, but I do not see an indentation nit here.  The format looks
perfectly sane to me and in fact any other indentation would be
wrong.

Puzzled...
