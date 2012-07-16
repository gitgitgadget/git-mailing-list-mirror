From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/8] git-remote-mediawiki: make mediafiles export
 optional
Date: Mon, 16 Jul 2012 11:15:30 -0700
Message-ID: <7v7gu3373x.fsf@alter.siamese.dyndns.org>
References: <1342440053-3058-1-git-send-email-Matthieu.Moy@imag.fr>
 <1342440053-3058-4-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Asheesh Laroia <asheesh@asheesh.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Jul 16 20:15:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sqppa-0005vQ-Nn
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 20:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753577Ab2GPSPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 14:15:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60956 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752356Ab2GPSPc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 14:15:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 877FF89C6;
	Mon, 16 Jul 2012 14:15:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2uDxji+6K2GIyIY3tursw0cLZ+A=; b=V5B+AX
	5UioQMkQWegakpDxI8e/T+Hl9gDRh7L7ALR5aU1kBT9pFU0HWjoAeKlZJfPwZnVU
	MvYVF2IttInQMSuBxufZ79yStA2w2IUIJtQ71MPcQJCs+PWM4/tyoQvLCWgShycM
	qoVPopJsL7UGYfGq6GE20rMA7db/krVmDwPWs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d2LwRtboK2NMGLYy3SWidZrz5gWfzMBQ
	mDrPg43fUIsPJMKEorc5rAJpqa7fz6XRv8AgKzoFNoSEln59IgxMjYVclqtS/cqL
	kEjIDaIRx5VFqaXZD6Bml6eTLO0qbq63xvblfEsopm25j5X8t4u7GiuiQXQ+aOk2
	07eMvq8cgAA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7529F89C5;
	Mon, 16 Jul 2012 14:15:32 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E8F4D89C3; Mon, 16 Jul 2012
 14:15:31 -0400 (EDT)
In-Reply-To: <1342440053-3058-4-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Mon, 16 Jul 2012 14:00:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3AEC712E-CF72-11E1-BF2F-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201540>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>

It would have been nicer to hint why people may want to omit
mediafiles from their export under what condition somewhere in the
documentation or at least in the proposed commit log message.
