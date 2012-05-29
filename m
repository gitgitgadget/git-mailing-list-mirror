From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] Do not autosquash in case of an implied interactive
 rebase
Date: Tue, 29 May 2012 11:43:07 -0700
Message-ID: <7vr4u24ymc.fsf@alter.siamese.dyndns.org>
References: <1337867575-7212-1-git-send-email-vfr@lyx.org>
 <1337867846-5336-1-git-send-email-vfr@lyx.org>
 <7vehq8tajh.fsf@alter.siamese.dyndns.org> <4FC3428F.4060202@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Tue May 29 20:43:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZRO0-0003qY-Nd
	for gcvg-git-2@plane.gmane.org; Tue, 29 May 2012 20:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755008Ab2E2SnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 May 2012 14:43:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47065 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754064Ab2E2SnM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2012 14:43:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F3FB8107;
	Tue, 29 May 2012 14:43:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k87dNOKC3dfONC8tcBdvAK2kwRM=; b=j4sg+x
	0GfS79c4vjUPTYiEG5SKn2gi7CkvfLtCEKODwQce8r2GLcxkyXEroGDFZOcZjMsP
	Msl+wYGED6xWbdKiWI0iUukV3NchQTdeMrnprsnwVc+5IjePRhN33NF2BUeWElOC
	B0khvMRzOVAKAfusois/YFK9i6hqlqIvsVoa0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xMMj3IioQ5CCb6nNXmEdFazGKThEvXUy
	nyepj+XNw9OkMOtx1pozufOGKFSUVz0cbZZoB04MCf687PWiyI0nxBoxwN6wVLJ+
	NYi/5y2OG+lPzoCIXVW9MYFRZw8jQAPVe/EmAm04QrU1LUkp41stVhRHkhc121QP
	+SENtr8Fmcs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1183C80FD;
	Tue, 29 May 2012 14:43:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F4E180F8; Tue, 29 May 2012
 14:43:10 -0400 (EDT)
In-Reply-To: <4FC3428F.4060202@lyx.org> (Vincent van Ravesteijn's message of
 "Mon, 28 May 2012 11:17:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 23AEA952-A9BE-11E1-A0AB-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198749>

Vincent van Ravesteijn <vfr@lyx.org> writes:

> Or did you mean that you want to imply "--interactive" when
> "--autosquash" is explicitly given ?

Come to think of it, it might have been a saner UI design when
f59baa5 (rebase -i --autosquash: auto-squash commits, 2009-12-08)
added this option, but if we want to go that route, we do need to
address the concerns I raised in my response.

But as things stand, i.e. with --autosquash that does not imply -i,
your patch is good.

Thanks.
