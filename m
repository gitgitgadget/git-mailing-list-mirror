From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/8] push: update remote tags only with force
Date: Mon, 03 Dec 2012 10:53:52 -0800
Message-ID: <7vd2yrrmpr.fsf@alter.siamese.dyndns.org>
References: <1354239700-3325-1-git-send-email-chris@rorvick.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 19:54:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tfb9l-0002z6-9u
	for gcvg-git-2@plane.gmane.org; Mon, 03 Dec 2012 19:54:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201Ab2LCSx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2012 13:53:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60197 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750792Ab2LCSxz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2012 13:53:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 622C7AE35;
	Mon,  3 Dec 2012 13:53:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z39PFn5dW5Nhrrj2YjeNAi8IYAE=; b=Z5YK0F
	IbN4LM9ozjCME+9yyqQA6d0ElEPwJN0ScTTgvbrLiuJL/IvCpsJPO2bVjQhq/PWj
	rKaAZLlO0u7aNErWhA6M7eQqImnug2zHuNQ/qN0wcuPwi9pqRbKUsW2wt6qWBA5V
	ZM+s91VWRGKlVOm6V6urew3JROvibkHVltJUg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CEGeEzDVVgM6mUpO7Xq3bYF5QtoDXEHl
	vfeZ1XNAq+EhS0uhqqlMb0QUEXWzSVIjEljr/0axaCxceUUTlgBY+cfUMoN8IxyH
	zSsQroOdMvXyAkwH60xzCLSbmVqdwc2P91fc60ezNvrL5zVwFuRZsgdRr6UIJpWK
	WeDWGo7J1Js=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E973AE34;
	Mon,  3 Dec 2012 13:53:54 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C3E12AE33; Mon,  3 Dec 2012
 13:53:53 -0500 (EST)
In-Reply-To: <1354239700-3325-1-git-send-email-chris@rorvick.com> (Chris
 Rorvick's message of "Thu, 29 Nov 2012 19:41:32 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C8C7A2AE-3D7A-11E2-90F0-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211051>

Thanks; will queue.
