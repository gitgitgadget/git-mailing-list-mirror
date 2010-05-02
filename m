From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 5/5] pretty: add aliases for pretty formats
Date: Sat, 01 May 2010 20:13:58 -0700
Message-ID: <7vaasjyozt.fsf@alter.siamese.dyndns.org>
References: <1272656128-2002-1-git-send-email-wmpalmer@gmail.com>
 <1272656128-2002-6-git-send-email-wmpalmer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, raa.lkml@gmail.com,
	jrnieder@gmail.com
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 02 05:14:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8PdK-000542-Rj
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 05:14:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756058Ab0EBDON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 23:14:13 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43716 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752222Ab0EBDOL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 23:14:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CAF4AFFDC;
	Sat,  1 May 2010 23:14:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=TOshEus4vR1DyqqZdS7JQ8bkGkU=; b=WYVzEzbLwyWr7H+elJDIIVB
	S8Qe2dM7g4s9lLzxBR7BEMDdqT4bXh9P3835dVBQW3XrplQxkNe2DofJn/GIRtoD
	jh58DGjQInwby5DvoOuD95zUxcNl8uPfmZh7mNzNSm1SrtxbFzZMdSxGfEi52lIi
	BkA+Je5knA7vbaMArGJk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=gQlvBfRVB6OAq98ye/56iNR4kezYkZ/NFlQjvnjjQ9LMLzT7/
	Y6ds6g+XmJlQWCqgvvBEU+awCMKeElIyzlU1elRYv509kJok8NwY22ijUvr/DUjy
	yrGyvKWG6ZAcKdiMxpJiktnkame7xEV5ourD1t6JbfVBC0kRypVKywdrn4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B32C0AFFDA;
	Sat,  1 May 2010 23:14:05 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D4AA5AFFD9; Sat,  1 May
 2010 23:13:59 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C40BD590-5598-11DF-AC3F-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146130>

This looks sensible.

I didn't follow the config namespace discussions, though.  Is everybody
happy with the naming used in this patch?
