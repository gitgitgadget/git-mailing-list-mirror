From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Documentation/init-db.txt: minor style and synopsys fixes
Date: Thu, 15 Jan 2015 10:55:57 -0800
Message-ID: <xmqqmw5j7u0y.fsf@gitster.dls.corp.google.com>
References: <1421317918-11677-1-git-send-email-kuleshovmail@gmail.com>
	<CAPig+cTHDf6S-R6DEZ3mV+wNhn9KojsoMy_ogg7wG4aPWnvUpA@mail.gmail.com>
	<CANCZXo6j6zXX8yrBV=OZpxZPzsf701f79YyQgvWJ+kQ3Dj0qUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 19:56:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBpaT-00059a-9r
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 19:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755283AbbAOS4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 13:56:00 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53889 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752989AbbAOSz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 13:55:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D28FE2FDAB;
	Thu, 15 Jan 2015 13:55:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BrwSeSlcI6TbMa9LdqpZARCyOO8=; b=iawSF2
	vlhefj8UwsSY2NpXxASi7vE47B/9s5/A5FCIYgHZDFNgFtgmsX+UrOK1baqwVwDh
	kiOF7hHSjNVjPtKTHSWE4OAqTXu4ciWHxWomxbjFcA2d4+68O0ucpLncMSPcDzJg
	UNkcgSFUOwHJLGFbmPPW5YaO2nNiA39FQRstg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q5dwmeEFJBnn0I8s2wjgOK6SEBMAZmjP
	Ust5xgTZQ+EVGcGfJf9XNUtWefh0hfLuRbEia2aPT/bgrKRA141Wx62AuuDtxo7X
	ZbGbSIv3W7dXIBFmyqutPJRlnNGuRczszBAM0olTqa4oFrzGSmP47V+Kmj0yEr15
	wctFqUreBIU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C8BE62FDAA;
	Thu, 15 Jan 2015 13:55:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4CDE62FDA9;
	Thu, 15 Jan 2015 13:55:58 -0500 (EST)
In-Reply-To: <CANCZXo6j6zXX8yrBV=OZpxZPzsf701f79YyQgvWJ+kQ3Dj0qUA@mail.gmail.com>
	(Alexander Kuleshov's message of "Thu, 15 Jan 2015 23:08:28 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 244BE792-9CE8-11E4-A094-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262501>

Alexander Kuleshov <kuleshovmail@gmail.com> writes:

> Yes, right,
>
> how to do it better? Something like: Documentation,
> init-db/init:.....? Or something else?

Subject: init-db documentation: fix synopsis style

>>> +'git init-db' [-q | --quiet] [--bare] [--template=<template_directory>]

s/_/-/ while we are at it, perhaps?
