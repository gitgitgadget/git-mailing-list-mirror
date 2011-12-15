From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [msysGit] [PATCH] gitk: fix the display of files when filtered
 by path
Date: Thu, 15 Dec 2011 11:50:53 -0800
Message-ID: <7v1us5obqa.fsf@alter.siamese.dyndns.org>
References: <87hb14wg4l.fsf@fox.patthoyts.tk>
 <CAJDDKr6rVaX_=SZZeEAs950yuNDvi8sOkzrUK7LnCrK6MYfscg@mail.gmail.com>
 <alpine.DEB.1.00.1112151023280.2615@bonsai2>
 <CAOeW2eHD7Xutf+pHDyMOo=uZC9PSFZi+aMq1Rx80iTKPFApr8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Dec 15 20:51:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbHKW-0006IE-Ly
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 20:51:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759380Ab1LOTu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 14:50:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40048 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751910Ab1LOTuz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 14:50:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 539BA6DAB;
	Thu, 15 Dec 2011 14:50:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Rh+Oeqg52wEhAa3+0l72maCEjcM=; b=fKTrdY
	GTHYZTRqH3BWuIdXpcObOS111WMobtOzsH5FnQMCp6QitAD0Fjpivt8tM6EG7UTB
	cx51CT8ER+XES0f+PWUUA0JwpCptiP1a597QcEsY5y3maioGRMDB/q8LOS73ea3O
	myMIhTBmqKSXSwNp3yArtOSHb5Sz1m1ba5WwM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aSh5oXddFhTGf5qqif1SesqSOzJEspJY
	7MlDe+4U6+gwfrQPgfUfFmdVLjl2q9yh0uel+ed3Pc6jOzhC37Xob+UivrdPe1bQ
	3Ewnji463HmwmJQKdDd8zSpxMeSVkYrkItL6opWW22pegSPlFo8YG0Ku5lPdcVX1
	gGloa+oGA9g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 498E36DAA;
	Thu, 15 Dec 2011 14:50:55 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D52686DA8; Thu, 15 Dec 2011
 14:50:54 -0500 (EST)
In-Reply-To: <CAOeW2eHD7Xutf+pHDyMOo=uZC9PSFZi+aMq1Rx80iTKPFApr8A@mail.gmail.com> (Martin
 von Zweigbergk's message of "Thu, 15 Dec 2011 11:42:38 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 19A6916C-2756-11E1-8DDA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187226>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> Paul and Junio, the patches I sent in April are still not in git.git,
> are they? Can we use another repo until the kernel.org one is up? More
> than eight months to get a patch (or eight) merged is way too long,
> IMO.

I tend to agree.

I have this slight suspicion that Paul would appreciate if somebody who
cares about gitk who is capable and willing steps forward and takes over
the maintainership of gitk, as he is busy in his other projects.
