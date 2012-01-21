From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] "git diff FILE BRANCH:FILE" erroneously report FILE does
 not exist in BRANCH
Date: Sat, 21 Jan 2012 14:08:57 -0800
Message-ID: <7v62g4btdy.fsf@alter.siamese.dyndns.org>
References: <4F1B13BB.8070603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 21 23:09:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Roj7U-0004EQ-SU
	for gcvg-git-2@lo.gmane.org; Sat, 21 Jan 2012 23:09:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720Ab2AUWJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jan 2012 17:09:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34010 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751659Ab2AUWJA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2012 17:09:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B344746C;
	Sat, 21 Jan 2012 17:08:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PcOCOe4WjA9yVUNx6U6NDS+4gB4=; b=qnQ/Nf
	l4WTz2rWaLvzpV6pqqn5YWoG0026ARmaYNeSPTnC1FGYYuauSFmN2JvFqM47YH1F
	XxfR4DSi1++7mi6rhIBye1j97oc44waIeooJ1Vvy3ZOkUgo8rI+oyzheAsm2FXa1
	pimHRzY8JRklfTZlrxOJ5vnRRqdKuozOeCFtw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MEd8DbKSBJjWLYMca93GSf2yd69G3BlH
	aB3zg86gVkAPuLV++1cR7EguLdUtrr8DEFWw+5mISZmsc4XzNRqj5skZGs50dMOn
	9+TfCoPdtMT66AnjULRe+PJ+QO+8BmRP7lb/dx5oByHOUqFQ31HA8Bob1ZT2QkDL
	HxFMaVrBcMI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92651746B;
	Sat, 21 Jan 2012 17:08:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 287EF746A; Sat, 21 Jan 2012
 17:08:59 -0500 (EST)
In-Reply-To: <4F1B13BB.8070603@gmail.com> (Stefano Lattarini's message of
 "Sat, 21 Jan 2012 20:36:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 84C20236-447C-11E1-8801-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188935>

Stefano Lattarini <stefano.lattarini@gmail.com> writes:

>   && git diff README master:README

http://thread.gmane.org/gmane.comp.version-control.git/188355/focus=188414
