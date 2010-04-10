From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Clarification for the command "git checkout <branch>"
Date: Sat, 10 Apr 2010 15:31:38 -0700
Message-ID: <7vhbnjuegl.fsf@alter.siamese.dyndns.org>
References: <4B67227A.7030908@web.de> <4B898F97.90706@web.de>
 <7vr5o6s5xf.fsf@alter.siamese.dyndns.org> <4B8B9BF1.10408@web.de>
 <4b8bf32f.0706c00a.26cb.691d@mx.google.com> <4BA104C7.5020207@web.de>
 <32541b131003170944w7a0215frcace205f32d313bf@mail.gmail.com>
 <7vaau6q18q.fsf@alter.siamese.dyndns.org> <4BA1FC39.10300@web.de>
 <32541b131003180936x746dad06k386788d3cb6fcdeb@mail.gmail.com>
 <b4087cc51003181019r4408953bxcd5049c9521b8173@mail.gmail.com>
 <4BA3329E.6050304@web.de> <4BB21F6D.7070804@web.de>
 <7vd3ylv4oq.fsf@alter.siamese.dyndns.org> <4BC07D81.6040402@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Witten <mfwitten@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Sun Apr 11 00:31:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0jDW-0004Ld-61
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 00:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309Ab0DJWbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 18:31:49 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42583 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752203Ab0DJWbt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 18:31:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A9D87A96DF;
	Sat, 10 Apr 2010 18:31:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=pLX8zS6NNZZ4xLnJOrLzUwW3Qfk=; b=XPg+50tCqhzi562D9v7JA2J
	FhZL1OyRXHLof1pgJxHL+m589SNJ1v2XGm4KePua0qFXZYYA3RO5RXBwMfaecb4p
	rJh3ORGqWOx6nQ3SlP5ITJ0vaZt2eg31ycYlXFRsr7lxaMX/BHieoutSIxHsjWVC
	yejK2RI3jo9+SQHGEjos=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=LuP/C0mNbDKBOBOQWL+VwK+VEHQGg11C2NOvvi6PH5GLxPD8v
	er84SsLAn0Apdviuek5ruQv8otieRzq9kfIUz1ECdQzDXLwfxKfkWEFdqDRs9xn2
	U+XxsG7ubOrUu7xwgZ6UJpbNgFs4sz3Bxascbzb8wOb/CHVc3jHsC8MAOc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 68A97A96DD;
	Sat, 10 Apr 2010 18:31:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 98931A96D5; Sat, 10 Apr
 2010 18:31:39 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D792AF0C-44F0-11DF-BB0E-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144605>

Markus Elfring <Markus.Elfring@web.de> writes:

>> Something like this?
>
> Which update will be published for the manual?

Neither one without any clear support by reviews on the list.  You asked

    Markus Elfring <Markus.Elfring@web.de> writes:

    >> I find that the discussion is not finished yet. It was not achieved a common
    >> conclusion and consensus on all mentioned details so far.
    >
    > Can we achieve progress for an update of the manual?

and the patch was only to illustrate what _you_ could do to help the
topic.

IOW, the message you are responding to is a "Yes you could help it by
doing something like this and asking for comments" in response to "Can we
achieve progress?"
