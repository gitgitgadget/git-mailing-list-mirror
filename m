From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [msysGit] git rev-parse broken on Git for Windows
Date: Fri, 30 Jul 2010 09:44:20 -0700
Message-ID: <7vd3u4rkbf.fsf@alter.siamese.dyndns.org>
References: <4C526260.6000104@workspacewhiz.com>
 <201007301102.15274.trast@student.ethz.ch>
 <4C52E125.1020004@workspacewhiz.com>
 <201007301643.50730.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Giuseppe Scrivano <gscrivano@gnu.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	<msysgit@googlegroups.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jul 30 18:44:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeshR-0006XP-ND
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 18:44:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753572Ab0G3Qol (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 12:44:41 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56500 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016Ab0G3Qok (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 12:44:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C3B83C920D;
	Fri, 30 Jul 2010 12:44:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=ZqKALg5Cqkh2RjUNPKcPQ6f0x8k=; b=tAdSjCF1pXAshgc/o4mrKMZ
	AZHMrbT+sU7nc+H71QaKHJ4xwWmfWcJOEHku3DnG8RH/RJ2jl2NP66Mgk1HL9LhI
	dg1Mlij8SmSxULYyTsr5sx1milS+JGAlx7mJxWDnSzNCMyzAP8tBC2RQs2xaDjA+
	bmzVJh2q6D1bINxNghBU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Vse+qAH+mylh8ikkZjlR8Sy1Nnoya4NWTNaig24Jey9J3b5ne
	0ianBLcg7fzO4WRQKpfHiqVg7OSHVrwdBqEJ2yCjCWj5fmPjN247azr8GNEYu6ec
	RSZAqP4vss1RFrb/GBNPI+AzoaedEriPIEuFqivXSEroxloIqz2HXe1VdY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BD60C9207;
	Fri, 30 Jul 2010 12:44:32 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 237E9C91FD; Fri, 30 Jul
 2010 12:44:22 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BA651086-9BF9-11DF-8F6D-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152252>

Thomas Rast <trast@student.ethz.ch> writes:

> ...  I'll also
> follow up with a doc patch for git-rev-parse.  Luckily there are no
> users in git outside of tests and git-sh-setup, so there are no bugs.

Thanks.
