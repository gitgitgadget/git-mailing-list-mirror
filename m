From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add bare repository indicator for __git_ps1
Date: Tue, 24 Feb 2009 09:01:56 -0800
Message-ID: <7vljrvixa3.fsf@gitster.siamese.dyndns.org>
References: <1235227723-11471-1-git-send-email-git@storm-olsen.com>
 <7v8wnzr3k9.fsf@gitster.siamese.dyndns.org> <49A05958.7050703@trolltech.com>
 <20090223154237.GH22848@spearce.org> <49A2C8D1.3080104@trolltech.com>
 <20090223161657.GL22848@spearce.org>
 <7vab8cpqgl.fsf@gitster.siamese.dyndns.org> <49A40372.2060600@tedpavlic.com>
 <49A40858.6010108@trolltech.com> <49A414B8.8010906@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Marius Storm-Olsen <git@storm-olsen.com>,
	git <git@vger.kernel.org>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 18:03:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc0h4-0007lm-Hm
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 18:03:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756781AbZBXRCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 12:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756685AbZBXRCP
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 12:02:15 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39193 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756196AbZBXRCO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 12:02:14 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A5A689C190;
	Tue, 24 Feb 2009 12:02:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E0A039C189; Tue,
 24 Feb 2009 12:02:04 -0500 (EST)
In-Reply-To: <49A414B8.8010906@tedpavlic.com> (Ted Pavlic's message of "Tue,
 24 Feb 2009 10:39:36 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E0BC4E8E-0294-11DE-8949-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111315>

Ted Pavlic <ted@tedpavlic.com> writes:

>>> Keep in mind that "BARE:master" doesn't make much sense. If you're
>>
>> It reflects what HEAD points to in the bare repository.
>
> Obviously, but that seems disingenuous when you're inside the git
> dir. "HEAD" is supposed to reflect the name of the currently
> checked-out branch, and so it is tied to a working directory. I'm not
> sure why it's useful to show $GIT_DIR/HEAD in PS1 while inside .git as
> it invites operations that probably should not be done while within
> the bare repo.

It still indicates the branch in interest.  That's the one you get a
checkout for when you clone from the repository.
