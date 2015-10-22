From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Poor git write performance to NFS
Date: Thu, 22 Oct 2015 09:07:42 -0700
Message-ID: <xmqqbnbqubsh.fsf@gitster.mtv.corp.google.com>
References: <56278FD3.3010103@lrz.de>
	<xmqqlhaw5bj2.fsf@gitster.mtv.corp.google.com>
	<5628DED0.3050002@lrz.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Daniel Steinborn <daniel.steinborn@lrz.de>
X-From: git-owner@vger.kernel.org Thu Oct 22 18:07:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpIPC-0003HI-1E
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 18:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965133AbbJVQHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2015 12:07:49 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52275 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752141AbbJVQHq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2015 12:07:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2367A243E9;
	Thu, 22 Oct 2015 12:07:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Fp/+wl+iuwQwZCfU+m3apy2laAY=; b=PUIhe6
	q0h1KDr7lV+F9YReKU+2T2UTmiBnafpH2pCwlzVEro3E4lQwSdP4d+jorbSxg4Zg
	sy3twHC3EfIZvbxmNBgPREEbET6PeFdfiv/RPu3ke61Ry0gNJXy7Emashir1zi6B
	pGefuTcpTZ4NX6d438f872iAQlF0ebeA5Eym4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hGknES65mCN+FlfBUPpQy3RUPHLsD2PB
	WSmQLToyfNlzBko5NirTXLUwFzUJo8/AzPUEVo9ZFk/3gOAQlGes7ss0Q803YaZH
	tDFpPhXxVlpjBIFZMm2ip/GBI+8yNp0I+0orEqdaC5hmwJWboezJJ1wj/xg3hwnT
	WTcBm65Esso=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1C26B243E8;
	Thu, 22 Oct 2015 12:07:45 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 98A4F243E5;
	Thu, 22 Oct 2015 12:07:44 -0400 (EDT)
In-Reply-To: <5628DED0.3050002@lrz.de> (Daniel Steinborn's message of "Thu, 22
	Oct 2015 15:04:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 07A72644-78D7-11E5-8942-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280059>

Daniel Steinborn <daniel.steinborn@lrz.de> writes:

> I removed the git Debian package and compiled v2.6.2 manually. The
> performance is much better now (on the same level als v1.7.12.4).

Thanks.  It is good that we must have done something good within the
past 12 months between v2.1 and v2.6, even though it feels somewhat
unsatisfactory not knowing exactly what that good thing is ;-)
