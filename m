From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-remote-mediawiki: un-brace file handles in binmode calls
Date: Wed, 03 Jul 2013 12:10:32 -0700
Message-ID: <7v8v1nfoif.fsf@alter.siamese.dyndns.org>
References: <1372842859-16598-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, celestin.matte@ensimag.fr
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Jul 03 21:10:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuSS6-0003Ay-V4
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 21:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965078Ab3GCTKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 15:10:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52656 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964960Ab3GCTKq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 15:10:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 321F32D10D;
	Wed,  3 Jul 2013 19:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=Dgl77F
	fGshM33Iq7V9l2MjUxd5imFQzwohRzA/tWkno7jxSJVf51MduUNXyTdKmbzmwSt6
	zejCE8ka+uu8tD1Z1nayh1OXElpdCpAqSd9QPKjOssvxMOwN+MNLaHy+f1588kvR
	ZpM7KbqFhXCJn0m4uhNGSz718RT23QcfdKMaY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BmdeXO1opbcn2Ye7nCLxHikUUlZAdTVw
	G09EPKAMuVtaMZCVI7/M7ToIL22o7k32SiDvegSbpJAvzmOAFNE9S49Nbp4tpdvz
	YPab+VU5TpxXjLW+ldrdEKMDx09gkrIjFmjbxD64KR5pXP56pxiF5waUS4LqC7R+
	hF/p6iWxjCc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5E782D10C;
	Wed,  3 Jul 2013 19:10:43 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EE0272D0FA;
	Wed,  3 Jul 2013 19:10:33 +0000 (UTC)
In-Reply-To: <1372842859-16598-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Wed, 3 Jul 2013 11:14:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3C7D1F2C-E414-11E2-85B2-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229512>

Thanks.
