From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2014, #01; Tue, 4)
Date: Mon, 10 Mar 2014 12:57:45 -0700
Message-ID: <xmqqfvmprfly.fsf@gitster.dls.corp.google.com>
References: <xmqqiortijxp.fsf@gitster.dls.corp.google.com>
	<531D764E.2000809@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Mar 10 20:57:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN6Ki-0007v8-N8
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 20:57:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752919AbaCJT5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 15:57:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59134 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752900AbaCJT5v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 15:57:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73B977326A;
	Mon, 10 Mar 2014 15:57:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fpHSvo1y42kJrJrGkui/Lx+1ZXQ=; b=mnJ1Sf
	gzHNU+aDvOwDA8BwPaYG6YG5UpIegEnM2PH2YbTE62MjDRTipqZqnPs0cKCyAXP/
	gn6wMAZwk5JAdq/qnmgYAsNptDr6/KmYYBcG8nc5nUEKVL9Mb+dn9928RxQxfJwV
	jpQIYEH3ejYb+J4moNEOvvOS0xKdFXx+M0/FA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SlFa8CwOoPORT6jRii+bjBTpyjCRoW3s
	Whe3NHOwaUIuGY4EhES736fDJCCQQVLa+u+0httkg5cv544XRBwufhQaj0PodZGD
	Rrek+p2IBduXyOt+smjB1H6Img9R00gf5Vz/KS1Do8/bSgvNAsu6tkcDLOIloldx
	kL55gDvH6gM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 635D773269;
	Mon, 10 Mar 2014 15:57:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7DA007325F;
	Mon, 10 Mar 2014 15:57:48 -0400 (EDT)
In-Reply-To: <531D764E.2000809@viscovery.net> (Johannes Sixt's message of
	"Mon, 10 Mar 2014 09:22:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 41470D76-A88E-11E3-8FA2-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243804>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 3/5/2014 1:10, schrieb Junio C Hamano:
>> * nd/gitignore-trailing-whitespace (2014-02-10) 2 commits
>>  - dir: ignore trailing spaces in exclude patterns
>>  - dir: warn about trailing spaces in exclude patterns
>> 
>>  Warn and then ignore trailing whitespaces in .gitignore files,
>>  unless they are quoted for fnmatch(3), e.g. "path\ ".
>> 
>>  Will merge to 'next'.
>
> The new test does not pass on Windows.

Thanks, will mark not to merge to 'master' yet.
