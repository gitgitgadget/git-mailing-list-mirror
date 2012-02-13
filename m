From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/3] git-p4: move to toplevel
Date: Mon, 13 Feb 2012 13:20:25 -0800
Message-ID: <7vhayuctwm.fsf@alter.siamese.dyndns.org>
References: <1329070423-23761-1-git-send-email-pw@padd.com>
 <7vehtyec64.fsf@alter.siamese.dyndns.org> <20120213203709.GA31671@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org,
	Luke Diamand <luke@diamand.org>,
	Vitor Antunes <vitor.hda@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Feb 13 22:20:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx3K5-0006es-5h
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 22:20:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758169Ab2BMVU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 16:20:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60181 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755923Ab2BMVU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 16:20:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E685C7723;
	Mon, 13 Feb 2012 16:20:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p3WFlSCwqAbLsth54c01XEGtnLY=; b=nJgUa6
	sJQjq9vA0URfdqQtAEEqHcDCpY25rjsp9bdDVUMWVA4EShZNowMP5y7Dcv4t40QU
	I5aDK6ZN8ou9AMdPyDXggnFMPzx2lGz4EYO8WPSeknXjd6qbpTUeknb/pErUiJdK
	Gw7JSC0myPYUDFFs8/rGMIiOFx00yhNHJU8Is=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oYMKB+N7vZfzxX98LrfhtbCNe1wWsLhv
	Eff80nfVOGWKzpbU/1tZfCmjA/skfVbZgqjiCth0tMP4bz/eNKI9ByHuF03FDVf2
	PpREAjkGVSpIzTppxlnZ5sSgxUNQj9S0F4K6/fPiHUDJ5x8scrwtUWj1SOZqtgD3
	YTPM/MtoqWU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE18B7721;
	Mon, 13 Feb 2012 16:20:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3DCC07720; Mon, 13 Feb 2012
 16:20:27 -0500 (EST)
In-Reply-To: <20120213203709.GA31671@ecki> (Clemens Buchacher's message of
 "Mon, 13 Feb 2012 21:37:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8C9FBE94-5688-11E1-9416-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190673>

Clemens Buchacher <drizzd@aon.at> writes:

>> Erm,... do you really need the alias if you add git-p4 in a directory on
>> your $PATH?
>
> With recent git versions, this has stopped working.

Erm, I am confused.

	$ git --exec-path
	/home/junio/g/Debian-6.X-x86_64/git-jch/libexec/git-core
	$ type git-hello
	bash: type: git-hello: not found
	$ cat >~/bin/common/git-hello <<EOF
	#!/bin/sh
	echo hello world
	EOF
	$ chmod +x ~/bin/common/git-hello
	$ type git-hello
	git-hello is /home/junio/bin/common/git-hello
	$ git hello
	hello world

What am I missing???
