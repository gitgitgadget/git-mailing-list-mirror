From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/7] add simple tests of consistency across rebase types
Date: Mon, 03 Jun 2013 22:49:18 -0700
Message-ID: <7vehcia0ip.fsf@alter.siamese.dyndns.org>
References: <1369982987-18954-1-git-send-email-martinvonz@gmail.com>
	<1370292135-1236-1-git-send-email-martinvonz@gmail.com>
	<1370292135-1236-2-git-send-email-martinvonz@gmail.com>
	<7v1u8ide2b.fsf@alter.siamese.dyndns.org>
	<CANiSa6hGLKATn3uUJKoi4917R4qoiyRHHJWo-p8vFrCZsg5joQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 07:49:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujk7a-0004Ov-G1
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 07:49:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755438Ab3FDFtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 01:49:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35001 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754466Ab3FDFtV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 01:49:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6981C1F66A;
	Tue,  4 Jun 2013 05:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1PvRjmfU5DZcp8NmDTEb3yJhy0Q=; b=TKKZEu
	0B7lFzeWZxfkWVx7wKujXngKvAuH4GQSt2psxbqh9KnMhm0mJvJhlxUi2DzOA+Cs
	GaZSav9MiAuRLCXhJ4xrBzM6nVq1s7J6icux9eW+pLJHUvKAPI7e0yJ0eS1CnTpy
	hcKpzIdtm3ZfuibWEwVDvu3660H9XNzHS3jfA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=orrv+YEuVs/0ZNgNtzOllOsprNQfjUE/
	V5AscCSJG+AJxDZ1JFUjqw2Sp8gdU6+lDcS+2Ifjuw+eUDRCv8iKdaewisGjbk/t
	iGQ6hiGEi7nDvLenvAs38PF5XMuA/lmonr/Qtn9eYlbY6JGDBIode5KKavEWjNTE
	StXW/C+douE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D72A1F669;
	Tue,  4 Jun 2013 05:49:20 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D0D521F666;
	Tue,  4 Jun 2013 05:49:19 +0000 (UTC)
In-Reply-To: <CANiSa6hGLKATn3uUJKoi4917R4qoiyRHHJWo-p8vFrCZsg5joQ@mail.gmail.com>
	(Martin von Zweigbergk's message of "Mon, 3 Jun 2013 22:14:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 801AD770-CCDA-11E2-A75F-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226315>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> Thanks. Will wait another day or two for further comments before I
> send another version.

Thanks; I just noticed that your patches lack S-o-b:.
