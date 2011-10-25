From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/WIP 05/11] symbolize return values of
 tree_entry_interesting()
Date: Tue, 25 Oct 2011 12:24:38 -0700
Message-ID: <7v4nyw50y1.fsf@alter.siamese.dyndns.org>
References: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
 <1319438176-7304-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 25 21:24:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RImcA-0000hU-E4
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 21:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323Ab1JYTYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Oct 2011 15:24:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63185 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751019Ab1JYTYl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2011 15:24:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B78AC5F33;
	Tue, 25 Oct 2011 15:24:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uDbd3+/6pulFV9olearZMrwPXN8=; b=pVnI8j
	yoaoOzweR+WmC1rzNXdM3wsgj/jVwkk+HlGLa0qILVewB8HVhimDUX/32/Su6K6A
	DQHs61CMsaBlcWg8jiQX78umX2Gmlp1ps8I2xygB3cjlMbIlTDZTfoztkoKQOT9f
	x7flGbo5LPmnxYg4FL1k85YxN2Y2Q2PdMOxR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vjsaqisi/nL5378b9umosgx6PJ9dRAOh
	8q5/wY/SQecGapTlQLIvqtP9z4qOgYMYzO55NJGfgFP8CDjvhlCnSoh3kcU5jo08
	HuSfdH5HFnMRUkvScnlaMgbYD6Arfvs/E7gO2t7y3jLkAcQRomqCf9BxwzHMQRME
	WAzFZPxFjzQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A856D5F32;
	Tue, 25 Oct 2011 15:24:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C0715F31; Tue, 25 Oct 2011
 15:24:40 -0400 (EDT)
In-Reply-To: <1319438176-7304-6-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 24 Oct
 2011 17:36:10 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FBFE42C0-FF3E-11E0-A1D1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184233>

Makes it a lot easier to read for first-time readers. Nice.

Just one minor formatting nit of lacking SP near ":", though.
