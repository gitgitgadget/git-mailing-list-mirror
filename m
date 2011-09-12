From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2011, #04; Mon, 12)
Date: Mon, 12 Sep 2011 15:56:21 -0700
Message-ID: <7v7h5d2wd3.fsf@alter.siamese.dyndns.org>
References: <7v4o0h7byd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pascal Obry <pascal@obry.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Johannes Sixt <j6t@kdbg.org>,
	Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 13 01:07:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3FbI-0007BS-SH
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 01:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755791Ab1ILXHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 19:07:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54800 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755668Ab1ILXHX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 19:07:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E0294A9E;
	Mon, 12 Sep 2011 19:07:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=af9WCv8KaiH+caxItEk3XHC5+NY=; b=FJdGKIUvpvI0xKkmEkKx
	XKvaaXiGjEffOcGgqQaNtxEasYC9+qTVne+ob4Ijeujwe0/ZA1mzx451pCY4cnEQ
	yjxgoe6c1lu3nczYlZtvbihJ2DtYpd8jIAnQHteYBK74a8TeP9yqWM5UMv77Fjqm
	TEYF3gL+mIhT0CplTAK4eGU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=owf344DmKHWyycrS6YHLuneWV/R7bR6L2DBQis43gKHVL2
	agZuwboS4DyzCeWPLXn4aMsd3iUwlkvsSXcIDtBNRZ7RKt9XXNibWlS0NoElZY0T
	0spCW5oZKTARjvWFCBJGUuZTCqiTxu/CAa//rZ37xD3YGyTTp7aCyZKs34BDE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 861004A9D;
	Mon, 12 Sep 2011 19:07:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A9CE4A9B; Mon, 12 Sep 2011
 19:07:22 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F88F77F2-DD93-11E0-BF84-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181252>

Junio C Hamano <gitster@pobox.com> writes:

> [Stalled]
>
> * po/cygwin-backslash (2011-08-05) 2 commits
>  - On Cygwin support both UNIX and DOS style path-names
>  - git-compat-util: add generic find_last_dir_sep that respects is_dir_sep

Honestly I lost track of this one. How would we want to proceed on this
topic after 1.7.7?

Asking help from Windows folks.
