From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/3] git-p4: move to toplevel
Date: Mon, 13 Feb 2012 12:00:35 -0800
Message-ID: <7vehtyec64.fsf@alter.siamese.dyndns.org>
References: <1329070423-23761-1-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
	Vitor Antunes <vitor.hda@gmail.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 21:00:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx24o-0002GJ-VT
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 21:00:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757830Ab2BMUAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 15:00:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55078 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757822Ab2BMUAh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 15:00:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CCFE6253;
	Mon, 13 Feb 2012 15:00:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=zbcYWuHOou4w514pFljnGcRx7EQ=; b=OeM6XuZd9DmmKT3BOtMX
	W7I+6A9j74El41yXM2Kvq8X+D8LdsjKj9GFI2gP9uRIFrJOpcHRK0sajVykdnVGz
	YEjOUE9d1PRNlUdFnxG5G9u3MH3lq4Vt4Dx1OnylMz67ga4b+x+HRTQYhKxLc2zx
	k1KBEbpQh1UgU9iW6zoo5o4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=pXpNKiT5m5+luWdtno1wsVmh0rCfOidyOe4SC8GOVQovIv
	xjUL0Xq+98ZQn3wPGr2FsAyDFVaYgPo7FHmD/M+w9QfMP5cO3vjT/ADgLh0SM+A8
	UmyB0upfZL8EJFrZrHO4YUSHy9a6VKzU0SKetbgP9rZzz6WmH30Nz75dHJmWI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63CDE6252;
	Mon, 13 Feb 2012 15:00:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D25D26251; Mon, 13 Feb 2012
 15:00:36 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 65540EAE-567D-11E1-AB4C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190657>

Pete Wyckoff <pw@padd.com> writes:

> Users install git-p4 currently by copying the git-p4 script from
> contrib/fast-import into a local or personal bin directory, and
> setting up an alias for "git p4" to invoke it.

Erm,... do you really need the alias if you add git-p4 in a directory on
your $PATH?
