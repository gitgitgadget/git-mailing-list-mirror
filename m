From: Junio C Hamano <gitster@pobox.com>
Subject: Re: HTTP push not respecting .netrc
Date: Wed, 12 Jan 2011 16:42:56 -0800
Message-ID: <7vy66p1vn3.fsf@alter.siamese.dyndns.org>
References: <AANLkTik84-zRwi+0dGGFoTUrj6Zr3bxO=fE9P_3MuZdZ@mail.gmail.com>
 <AANLkTi=4cE711TtqE0E-05s9Pk72C8OymNf_-5NhrfXS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Borowitz <dave@bwitz.com>, git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 13 01:43:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdBHW-0002uc-Bc
	for gcvg-git-2@lo.gmane.org; Thu, 13 Jan 2011 01:43:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756492Ab1AMAnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jan 2011 19:43:09 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36193 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755961Ab1AMAnH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jan 2011 19:43:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DDF193A68;
	Wed, 12 Jan 2011 19:43:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z/P4Irvi3VMWrwMqlJH3yOEW/DA=; b=QIK6L6
	uVvPGz6FlZxA5F53r6gtMeDQBBIa+DUalohcvLG4TZjurnhp5TJvpdwUc1QxkV9h
	90R5l3ZiGUm0DOfnQ3mWA3PDbIHeXwLJLXKriBn6Qc8968SHAcSC1BCaG20Vfd8i
	ZI3ImE2COKQn3xFq0hw6bUPUTmu23g0G013ro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YrlAOhfky4vK+6bRi/AKV6P4nFLPAsTc
	85dXC2La4tFo3heESH++PZG9nomvZoYbqfip+h51F9iTiTOG10m+0hyjQg3HRz74
	pDPle0dBrPGCrdVJo2a7r0Sv7Gz/XpECsKeOvHkO21FmqliqIa/3UX4E5a6hcM6G
	FMNElUKMF3E=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A7FCD3A64;
	Wed, 12 Jan 2011 19:43:45 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 71EC33A5F; Wed, 12 Jan 2011
 19:43:41 -0500 (EST)
In-Reply-To: <AANLkTi=4cE711TtqE0E-05s9Pk72C8OymNf_-5NhrfXS@mail.gmail.com>
 (Tay Ray Chuan's message of "Fri\, 31 Dec 2010 12\:03\:24 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2D6CA026-1EAE-11E0-A9F3-C7CE2BC26F3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165029>

Has this been resolved to satisfaction?  Just being curious...
