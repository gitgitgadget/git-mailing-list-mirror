From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-clean: Display more accurate delete messages
Date: Mon, 10 Dec 2012 10:53:02 -0800
Message-ID: <7vvcc9agdt.fsf@alter.siamese.dyndns.org>
References: <1354788938-26804-1-git-send-email-zoltan.klinger@gmail.com>
 <7v8v9bjd44.fsf@alter.siamese.dyndns.org>
 <7d290bdc-8654-4526-ba73-89408fa99a16@DB3EHSMHS002.ehs.local>
 <CAKJhZwROXsTa4wu-C9rhfGysetL+cZRDECyFUn5VTb833pWzMQ@mail.gmail.com>
 <7v38zecrqc.fsf@alter.siamese.dyndns.org>
 <5b69a9f1-0860-41da-914c-d55a17e54092@TX2EHSMHS026.ehs.local>
 <7va9tlbx8v.fsf@alter.siamese.dyndns.org>
 <aecaf65e-2b7f-4309-a7b5-622c7779de17@DB3EHSMHS018.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zoltan Klinger <zoltan.klinger@gmail.com>, <git@vger.kernel.org>
To: Soren Brinkmann <soren.brinkmann@xilinx.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 19:53:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ti8Tj-0007Nk-DY
	for gcvg-git-2@plane.gmane.org; Mon, 10 Dec 2012 19:53:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466Ab2LJSxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2012 13:53:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41889 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983Ab2LJSxF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2012 13:53:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD86697E9;
	Mon, 10 Dec 2012 13:53:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NMIV9GqxdyWPZqK0z0SVwxICups=; b=hPzhNE
	wpjxlzplNWKH3kV0khXXpsvQcRQWChKoCbd80jvmuHrNqktFSOuB2R1Fudn6vXR5
	hL+TUklTLpGIqltTrXG1iD+4gJuDwBIESufQ7TA8P8e+On6uUMB8jx4efzqktlpY
	+BFs83ak6vgRbmcK91gviy4cccYBL4FA2Lyhw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m7+gQJU4ojDes4hvPBeafpVYVaIi0q8I
	TdKj1PsiEIdWljrmVUbY9Xfpm4uzYIf6t2CJ+NJI2ES2YE7xZx58dod+AD+loEyn
	tRHiSPEsRvDiM8Y9B/hHNo2DhQd8+tl2RwlsdxGO0ekcl/Dlz+JQKHQtLmPU8JyP
	cmd/Hd1cigY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB89D97E8;
	Mon, 10 Dec 2012 13:53:04 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50F7197E6; Mon, 10 Dec 2012
 13:53:04 -0500 (EST)
In-Reply-To: <aecaf65e-2b7f-4309-a7b5-622c7779de17@DB3EHSMHS018.ehs.local>
 (Soren Brinkmann's message of "Mon, 10 Dec 2012 10:16:23 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D42B3478-42FA-11E2-8D08-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211269>

Soren Brinkmann <soren.brinkmann@xilinx.com> writes:

> But either
> way, the output of git clean should match what it is doing. And at least tell me
> if it didn't remove certain dirs or files.

Oh, no question about that part.  I was reacting to --force --force
in general, and an unrelated git repository inside a working tree is
just a subset of the issue.
