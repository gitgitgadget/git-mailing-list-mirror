From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] pre-push hook support
Date: Sat, 29 Dec 2012 08:48:01 -0800
Message-ID: <7vlicgg5z2.fsf@alter.siamese.dyndns.org>
References: <1356735452-21667-1-git-send-email-aaron@schrab.com>
 <7v1ue9hb06.fsf@alter.siamese.dyndns.org> <20121229145025.GA3789@pug.qqx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Aaron Schrab <aaron@schrab.com>
X-From: git-owner@vger.kernel.org Sat Dec 29 17:48:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TozaF-00088C-Gg
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 17:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236Ab2L2QsH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2012 11:48:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37032 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753123Ab2L2QsF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2012 11:48:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CCF8ADE9;
	Sat, 29 Dec 2012 11:48:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=esmgdKzeV07WBQN8hqwclWRErNo=; b=PbB5t/
	Ir4sJTuRW24unyO4fy8QbbjOWQR2m5v4g886y2xb/G04rVlSrMI9sk/pnSLrdIEK
	PApduPSs0zhzJpbnQhQkGS8H3b4FyQS2Un7MvaZveIfFSiCrTkVMjjXOVSFrhOl/
	mDmyojkaGvsUvQzNfPKrNJp8fGs8fdNqQjiTg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gX7ql0TOTxLAJwvhYSihfIq/cc5iO9Et
	EzBEG6xEDpEVpnbXV/IUOGXqkbQ9JV+rCuK/wTizV0vpOOsm6jIdtf2dd4PuaMV8
	5MKCKSdj3/kfDauUokFRb404Q89GkcltNIGG8v39AwizJDAKxMvPvbTaIKs6/5o4
	EI7fsX4Nb10=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88B0AADE8;
	Sat, 29 Dec 2012 11:48:03 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E55E9ADE6; Sat, 29 Dec 2012
 11:48:02 -0500 (EST)
In-Reply-To: <20121229145025.GA3789@pug.qqx.org> (Aaron Schrab's message of
 "Sat, 29 Dec 2012 09:50:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 82D6ECA2-51D7-11E2-9095-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212313>

Aaron Schrab <aaron@schrab.com> writes:

> At 18:01 -0800 28 Dec 2012, Junio C Hamano <gitster@pobox.com> wrote:
>>Will it be "all-or-none", or "I'll allow these but not those"?
>
> Currently it just uses the exit code to communicate that back, so it's
> all-or-none.  I think I'll keep that in the updated version as well.

Thanks; that sounds sensible.
