From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Rename V15_MINGW_HEADERS into CYGWIN_OLD_WINSOCK_HEADERS
Date: Sat, 17 Nov 2012 23:46:46 -0800
Message-ID: <7va9ufjqu1.fsf@alter.siamese.dyndns.org>
References: <201211170809.50395.tboegi@web.de> <50A7A161.9020805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 08:55:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZzj0-0001bk-By
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 08:55:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361Ab2KRHqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2012 02:46:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61914 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751068Ab2KRHqt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2012 02:46:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA61A86AA;
	Sun, 18 Nov 2012 02:46:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9EUDjy86P3h0m4hOpupP4BrY35A=; b=U/7LIU
	nZIptgFcBkRkcZrZTFkfcfx4pp03d8eeczBkWx+gVom+wPVJV+AKwsnecSCKpVal
	NtLeZ1//p5Xf5JJ07d7o7B40aoKwTPtE6lEpEfVreqyOTbZv0ExT2n2ZL8gHIpM5
	RyhBNe7R60HbXQZPMhaWQmEu350eBzHdlCJ+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D1EzCd+jHqK5je5vPTbSKBIIOgpnP3Yf
	d1f43BmODEehjFw5GIGnVMcUCXEpaIvK0+oXVJ0no/nfq7hAs9ynZ3PrO3WK+uhu
	XV5UMOZFwApvwT1fq37N8YcN5UXd55ICkXqQ1Tu0AGpOsuZG2vV5ARiiqmynBVQm
	S5yPwy30MO4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1BD286A9;
	Sun, 18 Nov 2012 02:46:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3548686A8; Sun, 18 Nov 2012
 02:46:48 -0500 (EST)
In-Reply-To: <50A7A161.9020805@gmail.com> (Mark Levedahl's message of "Sat,
 17 Nov 2012 09:38:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1B7604C4-3154-11E2-AF2C-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209991>

Mark Levedahl <mlevedahl@gmail.com> writes:

>> ...
>> -		V15_MINGW_HEADERS = YesPlease
>> +		CYGWIN_OLD_WINSOCK_HEADERS = YesPlease
>>   
> WINSOCK is certainly a part of the win32 api implementation, but it is
> is the entire win32api that changed, not just the tiny bit dealing
> with sockets.
> Basically, WINDOWS.h, and everything it includes, and all of the dlls
> it touches, and the .o files, changed.
> ... So my suggestion in the bike shedding
> category is to
>
> s/V15_MINGW_HEADERS/CYGWIN_V15_WIN32API/

Sounds sensible.
