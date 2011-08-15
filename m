From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/2] submodule: move gitdir into superproject
Date: Mon, 15 Aug 2011 15:23:26 -0700
Message-ID: <7vpqk6jov5.fsf@alter.siamese.dyndns.org>
References: <1313443067-2642-1-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jens.lehmann@web.de, hvoigt@hvoigt.net
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Tue Aug 16 00:23:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qt5ZI-0003VJ-91
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 00:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753266Ab1HOWXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Aug 2011 18:23:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51892 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753133Ab1HOWXa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2011 18:23:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 857254F62;
	Mon, 15 Aug 2011 18:23:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lNvYSrL+Yoip5oUXOqp7NcH5OlA=; b=TfvwTc
	gkEdN7DZJfyBAW2aqE4NDuF2zsozfxqnSM7FI30Qw/xhBVUSr2cTHlBoLQ+UyvuT
	QZMuXCHBNBPxyyEVod9RWa2rTo5HfGR37kj9+Xz9QgoVKGh5lMRxBoxGMI3Cw9qo
	tppCkI+PGIjppFi3FO1lVuIr5Y9oZV+Xmf8iY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FG+idDaaz97p4Uxg2pIwqHhHo9LNOs2N
	aevIiyvCso9Sj/BBFy0xs2SKQpoFqBB0s/lneWNitnzX5uv8aP/FJ7jbcpUo26dz
	xT99Eas7i1SPmQAjPspJfYi4WiUBniZUCNVqfhvVDSGt4+PcrLbjjIUn+LHeg4rT
	6TwbkSsCibA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BBC04F61;
	Mon, 15 Aug 2011 18:23:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F06F54F5F; Mon, 15 Aug 2011
 18:23:28 -0400 (EDT)
In-Reply-To: <1313443067-2642-1-git-send-email-iveqy@iveqy.com> (Fredrik
 Gustafsson's message of "Mon, 15 Aug 2011 23:17:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3387A18A-C78D-11E0-B553-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179391>

Nicely done; will queue. Thanks.
