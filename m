From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/6] Change 'git' to 'Git' whenever the whole system
 is referred to #1
Date: Tue, 22 Jan 2013 18:32:39 -0800
Message-ID: <7vr4lck4s8.fsf@alter.siamese.dyndns.org>
References: <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net>
 <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net>
 <7vvcark1f2.fsf@alter.siamese.dyndns.org>
 <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
 <1430594044.632790.1358795873467.JavaMail.ngmail@webmail20.arcor-online.net>
 <7vsj5slqz1.fsf@alter.siamese.dyndns.org>
 <7vfw1slpig.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: davvid@gmail.com, git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Wed Jan 23 03:33:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Txq9A-0004b0-Ci
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 03:33:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240Ab3AWCcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 21:32:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43181 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751819Ab3AWCcl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 21:32:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53459BB41;
	Tue, 22 Jan 2013 21:32:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ARxGEbIXXiXiR7wMz0nbVk+fuYc=; b=o3O6xK
	91i6vt+kGav6MaRd/osDqY5wAiQnSYY3Kv1nY+444aSfrgTvYc7QaoGce97GWZ+Q
	mmkULAoyZZRxnakLz0fCgKAYHZph89oBCNW6gYyKiFge+8W+AExbcbp/IG4AEdaF
	fZBF3fli7n3PX+qK/L+J0Uy19NAG3BKB8a5AU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lDO1zhjcR+u/XATMz9TxOfR1hMQuowA0
	SVhiNTRlDv3mAler+ErIbdGd4hhSS5WtXfIxSefcjl5IA0y0IpQi17Q5PUl7Zvwc
	GXO2prYPcXLCR0BU1C+6GYLfw6g7gBsQDvs6E1629eyBxNzh8S69xkw1GMh81Hpa
	tio0rfy5a1c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4620CBB3F;
	Tue, 22 Jan 2013 21:32:41 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A4D71BB3A; Tue, 22 Jan 2013
 21:32:40 -0500 (EST)
In-Reply-To: <7vfw1slpig.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 22 Jan 2013 16:19:35 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 28B697CC-6505-11E2-A059-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214272>

In Documentation/git-rev-parse.txt, there is this bit:

 --resolve-git-dir <path>::
        Check if <path> is a valid git-dir or a git-file pointing to
        a valid git-dir. If <path> is a valid git-dir the resolved path to
        git-dir will be printed.

I think the author invented the word "git-dir" to mean what we
ordinarily call $GIT_DIR (i.e. the directory that contains the
repository data), and used "git-file" to mean what the code and
error messages call "gitfile".  I think it is better to leave these
in lowercase, but we would need them in the glossary, probably after
rewriting the latter to "gitfile".  The former may want to be
rewritten to "gitdir" or even "$GIT_DIR".
