From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Support for setitimer() on platforms lacking it
Date: Sat, 08 Sep 2012 21:47:19 -0700
Message-ID: <7vk3w3u7jc.fsf@alter.siamese.dyndns.org>
References: <001e01cd8de2$a07f3930$e17dab90$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Sun Sep 09 06:48:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAZRM-0004SA-Qg
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 06:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508Ab2IIErW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 00:47:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41522 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751411Ab2IIErV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 00:47:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2057D9F34;
	Sun,  9 Sep 2012 00:47:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zfd8ySiqyH8QEZg+aucw1b983aI=; b=sfDlY2
	b3LgamDPYC574rJiYqIuAnnQqzLwPqcLZB8tdw0f1k2ITkBUtySw+tJBMhy/rRGo
	DlhRno45QL3Z88hWJZk77V6H+qmP1Yr/lTXyB/IGF78PbeCWFkBmEmse8A4mDPsR
	le6QSZXSXU+dojzaogLRxCfwskpeBK5AoawbU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fDZwAlkN8hZ/aI/5V3m+zzdIkfSvdTFr
	JvcT9LVIr7hADjvWSG3dQ5fgwy2/rV+4sE0JAjq8rxtnRAeEjGorhYE5g2hulgrh
	Iz5oEGWplqE5QRtwL3Joy9eEM9wh6SAT89AS4afhlOOJtLDD3PhnFSutNbJKdbCq
	v9EGX+jnXFQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C0569F32;
	Sun,  9 Sep 2012 00:47:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 813E39F31; Sun,  9 Sep 2012
 00:47:20 -0400 (EDT)
In-Reply-To: <001e01cd8de2$a07f3930$e17dab90$@schmitz-digital.de> (Joachim
 Schmitz's message of "Sat, 8 Sep 2012 18:54:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 70805C00-FA39-11E1-8A77-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205040>

Will queue (together with the latest MKDIR one).  Thanks.
