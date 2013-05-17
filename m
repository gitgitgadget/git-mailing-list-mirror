From: Junio C Hamano <gitster@pobox.com>
Subject: Possibly delaying 1.8.3 final for a week
Date: Thu, 16 May 2013 18:37:17 -0700
Message-ID: <7vvc6i1j5e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 17 03:37:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud9bx-0003eY-Jb
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 03:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388Ab3EQBhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 21:37:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62420 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751220Ab3EQBhU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 21:37:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A96E710CF8;
	Fri, 17 May 2013 01:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=f
	e5jHuBsIx0A5hhFl+l06hNqN+E=; b=B+JzVJIKgRYKtoIhv6bN3ONWtuPBeLf3H
	y3jvfsem6GIcL3SsrfbyAXSxdgGgX1j4zMRUoyOgyTnc2J7Erq14i4MbxbkHfQ+o
	3iE1Z1+3Qxi0rf4rxlj7W0BHhCVaXiU8tNEMkqRuV3zMdrYWHGYoApFHMYaS+spP
	tclEkAaDH4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=ZBL
	0fn2feiPKbg6hDKQ0ceKTy3pHfGJU91laDCpEObqTMF0nA4sWnYoKBuXrnl5AGRI
	l497mbl28CJm0Hkgarc6+F3S52/NpxNfjURL96izK9BDd9oAdpNqLEg3uoj1cSKZ
	mI69HIBMpoluNcQLMcOZGRNXie3rFThplSizeb+Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A049010CF7;
	Fri, 17 May 2013 01:37:19 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2961A10CF6;
	Fri, 17 May 2013 01:37:19 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5008C264-BE92-11E2-868E-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224646>

I am contemplating to do a -rc3 tomorrow (just like 1.8.2 cycle had
the final -rc3 at the end), instead of the planned final as shown in
http://tinyurl.com/gitCal/ to give testers a bit more days (among
other things).

Today's 'master' has a couple of hotfixes from Felipe, and hopefully
this would be the last "code" change before the final.  We may want
to merge down some small documentation fixes we already saw and have
been sitting in either next or pu, but I haven't looked them over
again to form a firm opinion yet.
