From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cleanup precompose_utf8
Date: Fri, 17 Aug 2012 10:20:33 -0700
Message-ID: <7vsjblv3j2.fsf@alter.siamese.dyndns.org>
References: <7v393mxkpk.fsf@alter.siamese.dyndns.org>
 <1345215190-95976-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tboegi@web.de, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 19:20:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2QDx-0006cJ-LB
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 19:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757695Ab2HQRUh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 13:20:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50569 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753668Ab2HQRUf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 13:20:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FD837352;
	Fri, 17 Aug 2012 13:20:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=HjqTL/
	MwW/ghklxxMD+f+9xa5ldBav8ybXXo60NgoJTv0agnq5wSEHhlYw73Y9S3AJ0PdV
	S3f4Ogyijs0MmmYhbIm39BKFX3ltnubFYgV2G1ryZEmp/f4UazR4lsGHaiTEd4dd
	paPeZo32kaWPxjLwfuYfxbG2R0+KCiYvzK07o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q+MSXP1bg7jzdIVtDOysqDSupwCExcwt
	vZy3mOrtM1jts3du73BQwKssRULJI5nwdGcz5ErWhUD0sMyal2UnlDuVorXbP4wq
	BXmDn5mTxeJ1r2g2F+Hf2Jt/gZeZskOHOkgj/iTm3iKaeDBJYMP2PWfoeIWbf+QW
	I3E7w0KZB0k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B30D7351;
	Fri, 17 Aug 2012 13:20:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A852D7350; Fri, 17 Aug 2012
 13:20:34 -0400 (EDT)
In-Reply-To: <1345215190-95976-1-git-send-email-robin.rosenberg@dewire.com>
 (Robin Rosenberg's message of "Fri, 17 Aug 2012 16:53:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DAD1AE30-E88F-11E1-A868-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203627>

Thanks.
