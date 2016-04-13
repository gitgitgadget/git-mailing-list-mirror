From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 0/2] Fix relative path issues in recursive submodules.
Date: Wed, 13 Apr 2016 14:03:35 -0700
Message-ID: <xmqqoa9djk60.fsf@gitster.mtv.corp.google.com>
References: <1459469849-9643-1-git-send-email-sbeller@google.com>
	<56FE8898.20906@ramsayjones.plus.com>
	<CAGZ79kYE3E7stNc3Xbzr-qvncLGt4qRPMbv897k5h0B50-Rogg@mail.gmail.com>
	<570E9C46.6080905@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Norio Nomura <norio.nomura@gmail.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 23:03:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqRwv-0001Rx-6Q
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 23:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753349AbcDMVDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 17:03:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61030 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750871AbcDMVDk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 17:03:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D333D1287D;
	Wed, 13 Apr 2016 17:03:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e5Tc5F5u/8vbXTn3NoxpnemsWPk=; b=qZpdHd
	tZtFNSuwDgJpmt/Q8Ckzodu6t+1JkDDZ9Y8Y4m/wCeLQKeZAD/WdIlZhdOjmsP1Q
	bx30YWqjuxHq2xbMP0HCLMdQW848/4noA+PMHVs7hvlLCG0lOm3XAuxluao+2PLE
	X90V5HShm/g64UwuqJV0qezh8MZINkYOqOPy0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=etXXYofqF7ylbbDfyw/nvCZBTGRwMFWW
	2IQl3dPUVTsE2LCMcwrfAPxZGRlXZIat1hTMdOHvmRoaFNYjmkiYNvkguUCvwn2O
	PGMntl5idDZaW2N73TtnwZQbaMotxANQ1AYnsrmKGCKI+0kMsmfY7Bjf0vNAikpi
	q2NmOraEiV8=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C98841287C;
	Wed, 13 Apr 2016 17:03:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 25B6F1287B;
	Wed, 13 Apr 2016 17:03:37 -0400 (EDT)
In-Reply-To: <570E9C46.6080905@ramsayjones.plus.com> (Ramsay Jones's message
	of "Wed, 13 Apr 2016 20:21:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 30E72050-01BB-11E6-A83D-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291485>

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Also, I note that t7406-submodule-update.sh test #4 is failing.
> (looks like absolute vs relative paths)

I think that is $gmane/291363

http://thread.gmane.org/gmane.comp.version-control.git/291334/focus=291363
