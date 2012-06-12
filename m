From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4] rebase [-i --exec | -ix] <CMD>...
Date: Tue, 12 Jun 2012 13:29:21 -0700
Message-ID: <7v4nqgjmu6.fsf@alter.siamese.dyndns.org>
References: <1339167235-2009-2-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1339325076-474-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <4FD48B70.5080600@kdbg.org> <7vpq9598yb.fsf@alter.siamese.dyndns.org>
 <4FD790AF.5070108@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	tboegi@web.de,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jun 12 22:29:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeXic-0007ip-L5
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 22:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511Ab2FLU30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 16:29:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44644 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752144Ab2FLU3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 16:29:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4655C8ECF;
	Tue, 12 Jun 2012 16:29:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9Dp9xpjkNlwTPbsyrmZzT5ibwhk=; b=xkdR3d
	DlcRwN1Qw59D6jEVBLODC+mPhxO+bSYRcULm2jw7IlomuZhsJ16GIlUo28dJHzEs
	qGwmLkR0pyZ27eXqgWW/B4Dd6V1LRX2xCFTps3/ZhjP+eMRX2XHs0Llmn+Hf36E7
	b3MmQtFETuginYvIru9CidXdrGEWRqFznlByE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b7wz7ErL0GzwDlXRyeD01Hwe5HKt5k9i
	zSTguQ7qerQyAyxrGn+ijwMYE0G8dKxafCwonzgmR/nhbY9ekfSwmryHiyGyLf49
	16rKhTxAX3ledEJlodMi7RQMklHvl0TdnvjzJdH1NQmLWPk7pu5xcS+tdJBouJTs
	XeqWPABuNus=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0F6D8ECE;
	Tue, 12 Jun 2012 16:29:23 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 543FF8ECA; Tue, 12 Jun 2012
 16:29:23 -0400 (EDT)
In-Reply-To: <4FD790AF.5070108@kdbg.org> (Johannes Sixt's message of "Tue, 12
 Jun 2012 20:55:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4BFA7BA6-B4CD-11E1-9233-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199848>

Johannes Sixt <j6t@kdbg.org> writes:

> Checking the usage blurb rather than the error message even has
> advantages: it is immune to changes of the error messages and to i18n
> poisoning.

Yes, to a degree.  There is no guarantee that the error message
stays on a single line in a particular l10n ;-).

> In this light, the version you have queued is fine.
