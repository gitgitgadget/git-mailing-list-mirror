From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 26/48] merge-recursive: Allow make_room_for_path() to
 remove D/F entries
Date: Mon, 18 Jul 2011 16:39:27 -0700
Message-ID: <7vaacbcg5s.fsf@alter.siamese.dyndns.org>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
 <1307518278-23814-27-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 01:39:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QixPS-0003EO-Ri
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 01:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817Ab1GRXja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 19:39:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37812 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751230Ab1GRXj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 19:39:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E74941E1;
	Mon, 18 Jul 2011 19:39:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=kprRqvRRLx0Aoyg2WjCeXbsoLhc=; b=X74NbQE8V/pUbjPLWddz
	WAngYU0HjNavl4z6IafGaP1o2gw0jDPR0Z3pBDFNeQrHlPg90u8CvhYYMRwnwOCi
	Mup9w2dhIF/bOzi5naXjteKTJ8wLv2q7Gyl8bxr0snEApiiz/O0O8g3HeYCtsRPo
	G8JPAAizgInW+aEOyGHS1WY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=vqKzsGE9aEh7iJeWYwS/+3nQDX8s5NiPr5NtQFVJZbt8qv
	18SbamCZtgPGOxbkeiMQ/NC+FuE+8YpfamSnD/e89SMck5FICWU5Ib2hmL6CMm86
	1lWq5TyP35XxjOePA+lHZrzdErTlyG8brfbf94eOELjp3lOMHlNzfAGdzh5CI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6678141E0;
	Mon, 18 Jul 2011 19:39:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EFDF941DF; Mon, 18 Jul 2011
 19:39:28 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2DEED718-B197-11E0-93DF-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177422>

What 23/-26/48 tries to do feels quite sane.
Thanks.
