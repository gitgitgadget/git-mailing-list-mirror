From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feature: support for file permissions
Date: Thu, 24 Oct 2013 15:40:06 -0700
Message-ID: <xmqqmwlyl2d5.fsf@gitster.dls.corp.google.com>
References: <CAGxGTk5eOGoUjrweZ9gLwBE6ev7oCZcu-aWWK2ydtpLkWgx8ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Renich Bon Ciric <renich@woralelandia.com>
X-From: git-owner@vger.kernel.org Fri Oct 25 00:40:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZTZh-0006Vg-BG
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 00:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755143Ab3JXWkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 18:40:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54285 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754415Ab3JXWkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 18:40:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D90F44DA65;
	Thu, 24 Oct 2013 22:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=s6nH1/EsMLAOMBoN/rVeenftOHM=; b=QWpmM7
	zwyVnUbWlSZrqaFMvWSptpuHe7wimT/pe4axJ4+OSaoOPoBUBTI2pLkKzpAkZNE9
	yDs3rywmrHckpyZdFaTOfMmf4Bvuvld7XJP/zhyGG/Dpbr1ylNLCOo9HoCNt9Q4q
	fUzjOGpdP3DV2EJPKivPtglbSlxnf930ENEek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g7X/n7SrJvs9MelDhV/zPI9T1a67MvTO
	c0x/7xz6+rTelbce1ViCgx/RxhxbAAHehiJ9g+F4Mv04dT8Sdmi77Y5N3mmAyNz6
	chGJmS7YfsGGo0CaStxyGZUeUsbeWwYbk7asMYN6/urCpJpJS9ZtWrLcg3FD6OZK
	lrtnZqm6rcM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAE234DA63;
	Thu, 24 Oct 2013 22:40:08 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 248E84DA59;
	Thu, 24 Oct 2013 22:40:08 +0000 (UTC)
In-Reply-To: <CAGxGTk5eOGoUjrweZ9gLwBE6ev7oCZcu-aWWK2ydtpLkWgx8ew@mail.gmail.com>
	(Renich Bon Ciric's message of "Thu, 24 Oct 2013 16:32:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3BF55438-3CFD-11E3-903F-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236635>

Renich Bon Ciric <renich@woralelandia.com> writes:

> I think file permissions are really important for source code as well.
>
> For example, in web development, you want configuration files to be
> read only; specially if you're deploying with git.

That is not _source code_; you are talking about deployed set of
files, and as you said, Git is about source code and is not a tool
for deployment.

> Please, consider supporting them.

See the ancient discussion around this:

    http://thread.gmane.org/gmane.comp.version-control.git/375/focus=435

A short answer is that it is not likely to happen.
