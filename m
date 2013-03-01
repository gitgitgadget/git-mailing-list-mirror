From: Junio C Hamano <gitster@pobox.com>
Subject: Re: suggestion for a simple addition: git update-ref --ff-only
Date: Fri, 01 Mar 2013 15:33:23 -0800
Message-ID: <7vehfyelvg.fsf@alter.siamese.dyndns.org>
References: <20130301231859.GA334@achernar.madore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Madore <david+news@madore.org>
X-From: git-owner@vger.kernel.org Sat Mar 02 00:33:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBZSa-0002xW-8a
	for gcvg-git-2@plane.gmane.org; Sat, 02 Mar 2013 00:33:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448Ab3CAXd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 18:33:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39281 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751245Ab3CAXdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 18:33:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67DCCA1F6;
	Fri,  1 Mar 2013 18:33:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BBbupd12J02zpvsyM+/3QVJO8LM=; b=Ii9BiX
	WnjhoT6gpL6ZR/JBiR2RnB1eZdl91LS5ZQxIWBYWOsIPTYZKGGl5si3ll+MNprL3
	DUlcIoenseaTPv+jeAqQcuiEe9QBmacdHbFEE72/0vKu3svy3Kzd8Q3hy4csPobH
	yUyEl7H2nuOiSwejTWxkxjSJBx1YRkOtSbRvA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sdRxAJo06szo6mooRMslXcA4NsHnacq/
	PacQDY+88twvMoXSnFsnNVu2XucrIzK8aeaGjuxffaelZccjVtbsdCgGbBoHpget
	1eNCxro886dMbdGRs2lhKKPDy88EXzgaEobxjbYVmoLxYHmblgRQAILigk2+PnXo
	ZNjEtwbf90k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CD89A1F5;
	Fri,  1 Mar 2013 18:33:25 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D60FAA1F4; Fri,  1 Mar 2013
 18:33:24 -0500 (EST)
In-Reply-To: <20130301231859.GA334@achernar.madore.org> (David Madore's
 message of "Sat, 2 Mar 2013 00:18:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6974670E-82C8-11E2-B2B6-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217307>

David Madore <david+news@madore.org> writes:

> Hi list,
>
> I'd like to suggest a very simple, but IMHO quite useful, additional
> option to git-update-ref: an option --ff-only which would cause the
> command to refuse unless the current ref is an ancestor of the new
> one.

Mild NAK.

What you want may be "git push . new_commit:refs/heads/foo", by the
way.

The "update-ref" plumbing does not want any such frill.
