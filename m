From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What exactly does 'needs update' mean?
Date: Fri, 24 Sep 2010 23:06:26 -0700
Message-ID: <7vk4manyql.fsf@alter.siamese.dyndns.org>
References: <4C9D8643.1040001@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 08:09:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzNxH-0001hy-8i
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 08:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756019Ab0IYGGg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 02:06:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44236 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754788Ab0IYGGf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 02:06:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E77D8D97B6;
	Sat, 25 Sep 2010 02:06:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p+TRUS9GON/C4v3VkysvYYJMyLQ=; b=gza0XQ
	oJ2JELfkbUsFXZv+FxNAYjv/1bRceX9iAAGIwoxHJaFFMY2a/GuyZqo8QUGMUHtr
	aGsQ2/JKfI/RojybMA31R7wGFReJ5KEUji3AlTANaUobzbUaiLYyfJDhuVzemho/
	5s+GRs8wa9sQmQVaFb92nH1VjATLjE7emvLjA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yDTitIhfwPLSjVWHt+C6uyVKzukQLxHp
	ynux/URco37EAcoM6X6SEwif8dVYsvir5jPjmzMWwoq3++4GOzqrxSRmfhln6NRl
	TnwHI9pZwfRFXBWb+V4rQHtuTgk+z/U/pec+Z5aWGWrUBqGbNJWljdSJTA+u0JFr
	D9hxxzifVcc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C4448D97B3;
	Sat, 25 Sep 2010 02:06:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E9BCD97A4; Sat, 25 Sep
 2010 02:06:28 -0400 (EDT)
In-Reply-To: <4C9D8643.1040001@workspacewhiz.com> (Joshua Jensen's message of
 "Fri\, 24 Sep 2010 23\:18\:59 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0A823786-C86B-11DF-96B3-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157122>

Joshua Jensen <jjensen@workspacewhiz.com> writes:

>  I've come to accept the term 'needs update' when I've forgotten to
> stash or commit before certain Git operations.  However, I got
> cornered today and was asked to explain what it means.  I had to admit
> I don't know.

It came from "you need to run update-index on that path, as you have local
modification in the working tree".
