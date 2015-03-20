From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: Add target to build PDF manpages
Date: Fri, 20 Mar 2015 15:42:35 -0700
Message-ID: <xmqqiodvcmuc.fsf@gitster.dls.corp.google.com>
References: <1426850584-9951-1-git-send-email-thosch97@gmail.com>
	<CAGZ79ka7tPA17Y-vPPp5W_4-0UMnHMfM9+eQ8jc4eu23FpM2ug@mail.gmail.com>
	<xmqq4mpfe7xm.fsf@gitster.dls.corp.google.com>
	<CAGZ79kaDnRiUQ6=3gVvsPrkSzkNbACRvgQBSo8gmpRZ8bka84g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Schneider <thosch97@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	"Philip Oakley" <philipoakley@iee.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 23:42:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ5co-0003Sn-Sb
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 23:42:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbbCTWmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 18:42:38 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58866 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751131AbbCTWmh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 18:42:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 578C64233B;
	Fri, 20 Mar 2015 18:42:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xry9cxgQqCU1TBgrNr/YctdTS78=; b=VxiCYS
	tNhy66mS+OAA7gMVmrtIeCHUPpr+3OZ5ghM+Ooq8/NPGEhau7i6VL9Zmc7Vnuc1j
	CnJ1oWUF14pG5+U5SJtmglUJHhpIwUXD8py6Cpup7zIr+3py+hfy5b6+9BrurJec
	0bA48ODu3rQcfD2I4Xfpw1rzHJmnkPjKpBOD4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YaibYEZYkFgHP45eCcuCQ0DerEIrL9It
	u6nQYilPW3Du5VKZamlPpUE8LCQVR2JDQsF1H5j0frC9LK9tov5CZbSmlk0dgzLS
	2nnZZ2qU5FE4r7NmHkX0O1cW+4FxP5mJiIwjBvNq3DwHiy3PNjEjpHCL5IYIsyRf
	Hg4xf28w6NI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E53C4233A;
	Fri, 20 Mar 2015 18:42:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A2B4D42339;
	Fri, 20 Mar 2015 18:42:36 -0400 (EDT)
In-Reply-To: <CAGZ79kaDnRiUQ6=3gVvsPrkSzkNbACRvgQBSo8gmpRZ8bka84g@mail.gmail.com>
	(Stefan Beller's message of "Fri, 20 Mar 2015 15:19:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 67FCE3D2-CF52-11E4-81F1-6DD39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265977>

Stefan Beller <sbeller@google.com> writes:

> ... I'd rather be looking for
>
>    man_or_pdf_when_possible git add
>
> and I could alias man_or_pdf_when_possible to a short name.

The help framework can choose the backend and the format and it
wouldn't be too outlandish to do "git help --pdf add" as Philip
mentioned already.

In any case, this, together with some patches on unrelated topics
that didn't cut today's "What's cooking" are parked on 'pu', so
hopefully people will play with it and report how they find it
useful.

Thanks, all.
