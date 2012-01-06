From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] xdiff: print post-image for common records instead of
 pre-image
Date: Fri, 06 Jan 2012 11:10:34 -0800
Message-ID: <7v39bslk9h.fsf@alter.siamese.dyndns.org>
References: <7vlipx4q3r.fsf@alter.siamese.dyndns.org>
 <4F072B9C.1030005@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Joey Hess <joey@kitenet.net>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Jan 06 20:10:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjFBa-0005ak-I9
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 20:10:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030526Ab2AFTKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jan 2012 14:10:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34580 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758972Ab2AFTKh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2012 14:10:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 982D55682;
	Fri,  6 Jan 2012 14:10:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=XB1byl
	VU6gZC7fO/wAR4JI2wWxbx6ZjW5p+8iWkDtC80ux+FaPtRL55lw/qryeRhQV0VPI
	gO6zTd4bGTXpERLzeS2SPdCyc2sj8c2A3m0evx+UTuJ8Gbai4UoUVuRZvUaAA/4A
	UmoeuvczfpgHrsCTpdW3KiCmayrgS5BALxtJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kvyAfZrzWPwqaaKdBC9bahUNO4yqw08k
	+bCjKchJcQ8nCmx2IRrTbdK6sOqhc/69ES1Ol+ZmzS7DwDvV2NbX7t3dZXJzRQ9f
	vvDZ43qM41UigJblKnDnvMT8pHOxPYw4v4sr2FXk2OHY5+8e3L1TosjWWu+DKt5j
	keurzK5T+sY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F4785681;
	Fri,  6 Jan 2012 14:10:36 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E55F567E; Fri,  6 Jan 2012
 14:10:35 -0500 (EST)
In-Reply-To: <4F072B9C.1030005@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Fri, 06 Jan 2012 18:13:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1D03627C-389A-11E1-B4D4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188039>

Thanks.
