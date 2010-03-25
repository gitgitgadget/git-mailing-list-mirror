From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Reuse .git directory.
Date: Thu, 25 Mar 2010 12:24:54 -0700
Message-ID: <7vfx3oxkzd.fsf@alter.siamese.dyndns.org>
References: <10467746.91269539410487.JavaMail.mvaidya@mvaidya-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Mahesh Vaidya <forvaidya@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 25 20:25:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NusgP-0006oM-6H
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 20:25:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754258Ab0CYTZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 15:25:05 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62150 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754139Ab0CYTZE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Mar 2010 15:25:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D61BA5877;
	Thu, 25 Mar 2010 15:25:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3DgXRH6jP28fkhWvmgWhn+6R4hk=; b=W4znKF
	60V3YkMfbjfsi7WNCETBLfOiiH+NadqNfA4QyYXVILnwKT97xkplEqX0wyvQWlMe
	zaHMFn2xhQ6/5Dt20aiyttuasLidipLoLU81lkJsySwxpn77zvRa2DVXqnU+4sQF
	3SiSeEEWvgjLNyYnKLOACQzHUwmTcdoOSIr+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DeH3vS+75V6xMf0nTSXL64/Ske9GB938
	f37OpzBvEpsK9I+SJ3t5eyh6ocXU7dKXbUI6vCq85qgF6TldYemYBgcQmzghVYkw
	FuhZqA4/mHtLxrX0+ulnfZkYfc1xRBT3X29qN4CjUI8FCaruq/l6/mSQB3C0BBLR
	2c1upxq205o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 66954A5876;
	Thu, 25 Mar 2010 15:24:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C2DFAA5875; Thu, 25 Mar
 2010 15:24:55 -0400 (EDT)
In-Reply-To: <10467746.91269539410487.JavaMail.mvaidya@mvaidya-desktop>
 (Mahesh Vaidya's message of "Thu\, 25 Mar 2010 23\:20\:14 +0530 \(IST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 19A960DE-3844-11DF-B0D7-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143192>

git-new-worktree, perhaps?
