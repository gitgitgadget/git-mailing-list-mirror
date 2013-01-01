From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] Use %B for Split Subject/Body
Date: Mon, 31 Dec 2012 21:56:47 -0800
Message-ID: <7vtxr1bg4g.fsf@alter.siamese.dyndns.org>
References: <1357012655-24974-1-git-send-email-greened@obbligato.org>
 <1357012655-24974-2-git-send-email-greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Techlive Zheng <techlivezheng@gmail.com>
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Tue Jan 01 06:57:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tpuqf-0005cA-NH
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 06:57:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940Ab3AAF4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 00:56:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64266 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751932Ab3AAF4u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 00:56:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3B5360D3;
	Tue,  1 Jan 2013 00:56:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3DdBqTW0tABQphzwYYthHPormRs=; b=fnDmEG
	9XJX9cnxdwr0To6q4ybtdoYBFiWDs5NeaArSfDbK48IcaOs9pUwA1guneanFgLIY
	5DT7gb3Q4OBLoUGICjS285K2OrtbXsijBSqZ1qbCLcTAbU6Ea8VxF33pamiOXbu0
	BeE6GXPJ/AFFjM4h/laNq5NCcrYo/MdxtbZlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o/gIDQAGQ5baIMpeUkV1cbE+TzUkIU0y
	XUnphlPgOgIrx9akyVtiroAwkdwDjY2sWnvGM0hbPjpillMfviNVkpnFwc8/xSAs
	grSrvEQ1rvjLHQBVP2WRrrnHfrd5SSD67Lkknf40xdDtLyFFx9ic9OKsIdQ1P3Wj
	Zb9650zrD5Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D513160D2;
	Tue,  1 Jan 2013 00:56:49 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6996560D1; Tue,  1 Jan 2013
 00:56:49 -0500 (EST)
In-Reply-To: <1357012655-24974-2-git-send-email-greened@obbligato.org> (David
 A. Greene's message of "Mon, 31 Dec 2012 21:57:28 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0874010E-53D8-11E2-9E70-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212415>

"David A. Greene" <greened@obbligato.org> writes:

> From: Techlive Zheng <techlivezheng@gmail.com>
>
> Use %B to format the commit message and body to avoid an extra newline
> if a commit only has a subject line.

Is this an unconditional improvement, or is it generally an
improvement but for some users it may be a regression?  I am
guessing it is the former but am just making sure.

> Author:    Techlive Zheng <techlivezheng@gmail.com>
>
> Signed-off-by: David A. Greene <greened@obbligato.org>

Please don't do "Author: " which does not add anything new.  That is
what "From: " is for.  Instead it needs to be a sign-off.

Also, is that a real name, I have to wonder?

Thanks.
