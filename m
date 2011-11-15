From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git 1.7.7.1 (Win7) work slower.
Date: Tue, 15 Nov 2011 00:08:46 -0800
Message-ID: <7vehx9x0xd.fsf@alter.siamese.dyndns.org>
References: <49277.1321343947@aster.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: mardu@aster.pl
X-From: git-owner@vger.kernel.org Tue Nov 15 09:08:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQE4b-0007G5-Kb
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 09:08:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623Ab1KOIIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 03:08:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37289 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752146Ab1KOIIs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 03:08:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4405D314C;
	Tue, 15 Nov 2011 03:08:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SFIYhLaYdYaBLeXiBsCIvqy9Afo=; b=MEMHxp
	uEePIsCJYbaWfb4F4zsrxyUtnxhQeedue9lZPOF7IetUf2MCEfp+pYG+kAxJqz6B
	ZhiW6sry5fdZ2ZOH+KbImY8Jb+U8ZxiO8mzs+UV59+a1eKIjvajVDIqYLAjjhIFH
	Xlz4e+SHxL+pcKYWUEqyWo/QYNV7h/iEntFAs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aWF3Ug784ndH+lImgmRVxLD/+QE59zmw
	Mk7k6gmsxhxOuObbSvOYJ5E2S1unVrKrKNpmpyWQJ9jc7I6vQoKZVs0co33KDApv
	tMArWUz4WsPx5dSgIReVIPp1XlHZnS2+ixYAnUSjUXh6ztF8Y6SPlPXYI3L72mJb
	KTONi+a01Ug=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B8BC314B;
	Tue, 15 Nov 2011 03:08:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C3B9B314A; Tue, 15 Nov 2011
 03:08:47 -0500 (EST)
In-Reply-To: <49277.1321343947@aster.pl> (mardu@aster.pl's message of "Tue,
 15 Nov 2011 08:59:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0B90F89A-0F61-11E1-A5B8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185442>

mardu@aster.pl writes:

> The latest Git version for Windows (1.7.7.1; GUI) work very slow (it means that I
> have to wait tens seconds or even few minutes for open the application, scan
> files, read history and other...).
> I don't see changes in speed in another aplications installed on my computer.
> The previous version Git (1.7.6), which I had installed, it has worked normaly.
>
> OS:Windows 7 x64 (Home Premium, SP1),
> CPU: Intel Core i5 M520 2.40GHz
> RAM: 4GB

Wrong mailing list? I suspect you meant "msysGit <msysgit@googlegroups.com>".
