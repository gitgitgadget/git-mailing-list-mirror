From: Junio C Hamano <gitster@pobox.com>
Subject: Re: merges and git log --stat
Date: Thu, 06 May 2010 16:58:45 -0700
Message-ID: <7vhbmkh9ai.fsf@alter.siamese.dyndns.org>
References: <20100506192616.GS4599@neumann>
 <7vsk64hjq4.fsf@alter.siamese.dyndns.org> <20100506203639.GV4599@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri May 07 01:59:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAAy3-0005c9-IS
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 01:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309Ab0EFX6y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 May 2010 19:58:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35057 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259Ab0EFX6x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 May 2010 19:58:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 071FFB02EE;
	Thu,  6 May 2010 19:58:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=fyBOsDqvHs6x
	w/x853mj9FR8nFM=; b=cwBYlXL8Ke+CdTybC4Gir6yBJf9B8SPpnMrZxXfVkI1Y
	lo9W8pqHAF0Y20H5DLAsHRWoCSaFo+CNK3Xx8fWsEnDLBsBnfDBZ3bxc2I5/Sx6e
	RkLboN8IrryHeVnacUMDoYvbrHl/P90MKRSCT4+yYvWtRL8xYrbQ8NP7Y7hBrBo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=RExxGZ
	XMFBV9A0LVjoq4e1AyMuo6zVwwP/I7ZIOwULUymoWGlgkYZuh0HwRWV1RUBc/ADa
	ZnD4Tk6kUxVam2lMGoE2ElSjOCOR37ogni4IjHlUpNNcNXUKl2uUqL3jEzIwv5bX
	yH4abqLBliIxihsmgUxs/5eR61c9qNZ7ucHD4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D6E12B02EA;
	Thu,  6 May 2010 19:58:49 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D2B8B02E6; Thu,  6 May
 2010 19:58:47 -0400 (EDT)
In-Reply-To: <20100506203639.GV4599@neumann> ("SZEDER =?utf-8?Q?G=C3=A1bor?=
 =?utf-8?Q?=22's?= message of "Thu\, 6 May 2010 22\:36\:39 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 50ED5BCA-596B-11DF-9734-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146514>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> ..  Anyway, it seems that I can easily get what I need with a
> bit of scripting, so it's not a major issue.

Yes, you would need to script it if you count adding "--first-parent -m=
"
on the command line as "scripting" ;-)

	$ git log --stat --first-parent -m
