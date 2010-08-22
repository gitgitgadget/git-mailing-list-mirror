From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Tell ignore file about generate files in /gitweb/static
Date: Sun, 22 Aug 2010 00:23:12 -0700
Message-ID: <7v1v9r6rhb.fsf@alter.siamese.dyndns.org>
References: <4C6FFC5D.2090506@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Mark Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Sun Aug 22 09:27:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1On4xo-0004hz-GM
	for gcvg-git-2@lo.gmane.org; Sun, 22 Aug 2010 09:27:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861Ab0HVHXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Aug 2010 03:23:20 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:32944 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847Ab0HVHXS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Aug 2010 03:23:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BAFECD84F;
	Sun, 22 Aug 2010 03:23:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=KYMW7QUulCtv5vx2W9zIaGy
	MPHrWpQYtdeTNAylDbc/XZACXj6nwO+d6x+kj1y/yVgGvVEH9V/51QxKazuDD08Q
	BfRV5JbuEhjnECxCApa4qOdWAyKDN6qQgal0h7Cz9xiSdYf/+LiZnk38GUzM2okA
	lwrFeqJf9WKZQlrf57Ck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Ghsf3Dn0cyiyudF3PGHS3587t/1ML8sl3OyXcFCTmE9ZLCyva
	0qGvlbiBDwICNTZsMsPosD1VSZPWNgjH6aWWknDDyCF7m/xTVE6TGbSrhJJgytVD
	sdwB883lVTp5ZLaQySX8kx1dnYIkVKUIopQEiKFeII9tMwYsRvptgQmkIU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 29355CD847;
	Sun, 22 Aug 2010 03:23:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8CDE2CD844; Sun, 22 Aug
 2010 03:23:13 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2179BB5C-ADBE-11DF-8AC4-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154170>

Thanks.
