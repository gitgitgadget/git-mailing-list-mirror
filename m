From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/10] nd/clone-detached
Date: Fri, 13 Jan 2012 11:52:43 -0800
Message-ID: <7vvcofxtv8.fsf@alter.siamese.dyndns.org>
References: <1326189427-20800-1-git-send-email-pclouds@gmail.com>
 <1326439322-15648-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 13 20:52:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlnBC-0003BZ-Kj
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 20:52:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758931Ab2AMTwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jan 2012 14:52:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43618 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758929Ab2AMTwp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2012 14:52:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE8B45E31;
	Fri, 13 Jan 2012 14:52:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HYX6BsDRdXqSLZvNoG+x/Yovst0=; b=YVJN9w
	wOQRgjnajF0WrAWDWeyEe8FQRHoH3TEw4k8E8BCfrxTnMn9G36fISBzueYpaJxQd
	0OCJyXATqHMQwLN9p1nUTZfTp4d+Z99BKFxKDMygNhDyjvp6vhFTTcP//iHM/L8t
	i2g81IzucXYvkcl0x2rhOuCt0KOx/pqlY+jws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lmHaEDACmQ0uE+Xx2O66AhsXg824bVU+
	8Ry8L14NxhPwUp7YT/GXOwcp/JWeZt+cQVhTlcxG/6Ky3kVZZn6KeYOZFg/qndZ4
	CDwScm5VSYSAZFFwrrs3Ql4nL8A0S4l5/wqXzHns72cspUonB/quQ0ALbEPzhsDP
	+3BDVjrkC7A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C63445E30;
	Fri, 13 Jan 2012 14:52:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 613755E2C; Fri, 13 Jan 2012
 14:52:44 -0500 (EST)
In-Reply-To: <1326439322-15648-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 13 Jan
 2012 14:21:52 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 28E97E60-3E20-11E1-B4DF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188536>

Thanks, replaced (and updated comment strings read much better).

There were some conlicts I had to resolve while merging this to 'pu'.
I would appreciate it if you can eyeball it to make sure I didn't make
silly mistakes there.

Thanks.
