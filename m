From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: make default of "cleanup" option configurable
Date: Wed, 09 Jan 2013 07:40:30 -0800
Message-ID: <7vlic28ivl.fsf@alter.siamese.dyndns.org>
References: <1357676176-30019-1-git-send-email-ralf.thielow@gmail.com>
 <20130109072952.GC6503@elie.Belkin>
 <CAN0XMO+t2gu9UKJFVXAxt91-hUUhMqqmMoop88KYp0vo3x6c_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 16:41:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsxlv-00036g-JC
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 16:40:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086Ab3AIPke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 10:40:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33142 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932073Ab3AIPkd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 10:40:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06E0FBA9E;
	Wed,  9 Jan 2013 10:40:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KBQ05Ygs2iwqS08PZa9dVfkfRnU=; b=igGhNs
	Id+ZBRDizELAi+pr+oceHAHv5zY+o0nxXX82fDkBDlh3RZoXOLBpZRGcbpdQlwrw
	JyioZWiZcW4LVwE4dllcts6TpeJ7BNYfEQP2Ap9gg9FYmnQROfVaCAgpQA//5OJM
	sahQikEx5Sc1GPpTkNhqtuyvSVjUupgHLvc7s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LbvGIVscX8nc+LiTDVGJ0xVHQYCiQ08E
	gTB1+MbolhNCs6XJyZIJnsiKmqbZl8nNzMWfm1qFcSg8SRzhFjX3oGOfq1IWD99c
	o80arh3I4ELps24IVHD1DUsXpj2xZg5XcZvwceg8nwMIX/+UGuofCqM6FFMvp6aZ
	/aLr1Wq3a7A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF401BA9D;
	Wed,  9 Jan 2013 10:40:32 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 62F45BA9B; Wed,  9 Jan 2013
 10:40:32 -0500 (EST)
In-Reply-To: <CAN0XMO+t2gu9UKJFVXAxt91-hUUhMqqmMoop88KYp0vo3x6c_g@mail.gmail.com> (Ralf
 Thielow's message of "Wed, 9 Jan 2013 09:16:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E7139EA6-5A72-11E2-82E5-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213061>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> When a user uses a script/importer which expects that the "default" option
> is used without setting it explicitly, and then the user changes the default,
> isn't it the users fault if that would break things?

Not necessarily.  There are many people who use scripts written by
others, without knowing how they work.  You could blame that the
script is broken, but not the poor user of that script.
