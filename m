From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Makefile: Make dependency directory creation less
 noisy
Date: Sun, 11 Sep 2011 14:45:30 -0700
Message-ID: <7vvcsylpmt.fsf@alter.siamese.dyndns.org>
References: <4E6D0EA2.5080406@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Sep 11 23:45:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2rqM-0006I1-7C
	for gcvg-git-2@lo.gmane.org; Sun, 11 Sep 2011 23:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755255Ab1IKVpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Sep 2011 17:45:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39930 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751496Ab1IKVpd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2011 17:45:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06D724489;
	Sun, 11 Sep 2011 17:45:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=ok+uYl
	zGbbDmYPGikVx8EokcQ1R+bWqZ8A1Kn5pGftW5Wyo6L69Xgk1Muq3jzQNjFhW4S7
	7tfYvZTZh2OLTuwIaJ8PzdViByzL8cAVmM01RLKGaUB6oXbPxId0Omf+TNirFprz
	K2ppPq67YxbQHpampmmoSN5Ucovlaxfvmijpc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C29fJs6prc1b9u/XcGt7+G9uUZEK6edb
	CgIvDHnpWF1AFI1wW4Ck1N/8ZR/SRsTMfT0rTB/CE5BgML8VIngAqQlrvHh9vg5V
	EavyYJIQxeFgHk8T1Z63Fr+sZfs5YWyv8kNmpt3Mr7pFhtyJafPipDAN+6oDh0N/
	ClF0jc/qEaM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F32E94488;
	Sun, 11 Sep 2011 17:45:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8A110447E; Sun, 11 Sep 2011
 17:45:31 -0400 (EDT)
In-Reply-To: <4E6D0EA2.5080406@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Sun, 11 Sep 2011 20:40:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5F3C3A74-DCBF-11E0-87C2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181199>

Thanks.
