From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2016, #01; Wed, 2)
Date: Thu, 03 Mar 2016 14:18:13 -0800
Message-ID: <xmqqoaav19zu.fsf@gitster.mtv.corp.google.com>
References: <xmqq37s84mui.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 03 23:18:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abbZi-0003Uu-TX
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 23:18:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758341AbcCCWSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 17:18:18 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57619 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758051AbcCCWSR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 17:18:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8EC5F4917C;
	Thu,  3 Mar 2016 17:18:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lRVJUrE90G8PFyqKe3wR+algJJI=; b=r+tBuv
	RZwkubPnjM7RBk64ElydSfIRxxhqME5GS413uuHObmkxL24DlizbyNPZwPN4YgPd
	tbgJzDsaN/9Lt06GgeUT9CaNKqcOiU5qh51WRxGXURaaO5kw09LT7nS4SCp35IGg
	4Jt/v22sclqY48KFB/j+hvs4ZC4gLwU31XvwM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=twY2/9cJJnO9vs+zCYWjE1n+SjMzMEoK
	uTAL4/fyPcp2flvLiFQXx+9xk4mYbWgUxf0bXn4tsmAOvzGiG/7alXa+Y6d0J5pq
	XMCOBxjfAz2WqTgz1lk6wRT/0KQ2iKzzFZQCDtQkYw/gwgYJ0r8AyB7mjJTeue7k
	rswC7xdPDFM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 86D464917B;
	Thu,  3 Mar 2016 17:18:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 07EF04917A;
	Thu,  3 Mar 2016 17:18:14 -0500 (EST)
In-Reply-To: <xmqq37s84mui.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 02 Mar 2016 13:00:05 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D2F32C20-E18D-11E5-8866-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288216>

I do not want to issue "What's cooking" report daily, so here is
just a highlight of what will be merged to 'master' by -rc1:

Will merge to 'master' by 2.8-rc1
 + mg/httpd-tests-update-for-apache-2.4                         02-25/03-01    #1
 + jk/pack-idx-corruption-safety                                02-27/03-01    #4
 + tb/avoid-gcc-on-darwin-10-6                                  02-28/03-01    #1
 + nd/i18n-2.8.0                                                02-29/03-01    #4
 + jk/tighten-alloc                                             02-29/03-01    #1
 + sb/submodule-parallel-fetch                                  03-01/03-01    #1
 + js/pthread-exit-emu-windows                                  03-02/03-02    #1
 + nd/clear-gitenv-upon-use-of-alias                            03-03/03-03    #1

The last one is J6t's fix to t0001 test that was broken under valgrind.

Thanks.
