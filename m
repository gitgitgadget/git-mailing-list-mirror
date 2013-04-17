From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Wed, 17 Apr 2013 16:56:30 -0700
Message-ID: <7vsj2od841.fsf@alter.siamese.dyndns.org>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
	<CAMP44s2_wiNr4RaBOEnKnZzT4CF0qKK+bp+Lyi=Nfx3Q9ggqOQ@mail.gmail.com>
	<7vip3npet0.fsf@alter.siamese.dyndns.org>
	<CAMP44s3NE3yrQoa1nZXAgy3KFXGF56Ki8icJ2z2TDigzax0nWg@mail.gmail.com>
	<8761zm4wzg.fsf@linux-k42r.v.cablecom.net>
	<CAMP44s0a2VsPBMd9Vrrhwdw=SPp2HrvDdXZ9Dmzhr9A6T+Sz7w@mail.gmail.com>
	<CABURp0qGYG4T+t36=Us328YdLzy9KjBOWot2gSOk=FgCRUCLnQ@mail.gmail.com>
	<CAMP44s3pZt3QVjS7GbXqjMS4ti3p=Vs2DmFXQjsMM3rs9qURmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <phil.hord@gmail.com>, Thomas Rast <trast@inf.ethz.ch>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 01:56:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UScDT-0002oC-DG
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 01:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753668Ab3DQX4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 19:56:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63871 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751585Ab3DQX4e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 19:56:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 236021716A;
	Wed, 17 Apr 2013 23:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ylgSs871aliYNEeaOPBCbbbDlwI=; b=FJNrtE
	J2CKWt8/XW/gTD9srmcslliE8AgLwsiFiLNLsSyIjngxa3k/gnXQUqUt0PEHusmL
	2Xl2C26CA4sRQ3ZGFE3Xvt1CoBh74WZaynBHr3sRre0Bvf0SseUCy94jbgoHV1WY
	jhqzPROxRF6whY6z2IuOCGuNqDhj5Nhp/NJ5s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oHudHqyRfyUqOEbi+DTUWBJyTFVf1W/Z
	AztIqUBGdZzADxn1VdvkfJRTdtANN3Yy7W65JSvw5ClJTI1nLlpdbbO6Y70BG5yt
	nhItynY4uMb9snWvYZrHDaYIL7kzATtOpfHjOo2leY1nhBKyEIEZ07dDGgAFJdaH
	o6GQ0vIHZFA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 179A617168;
	Wed, 17 Apr 2013 23:56:33 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6284C17166;
	Wed, 17 Apr 2013 23:56:32 +0000 (UTC)
In-Reply-To: <CAMP44s3pZt3QVjS7GbXqjMS4ti3p=Vs2DmFXQjsMM3rs9qURmw@mail.gmail.com>
	(Felipe Contreras's message of "Wed, 17 Apr 2013 13:50:50 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6DE7283C-A7BA-11E2-87FD-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221586>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> And how do you know this will be part of the 1%? You don't. How many
> times have you tracked regressions in transport helper's import/export
> functionality? How many times in remote-hg? How many times has
> *anybody* done so?

The last point makes it all the more important to have a good
history [*1*]. An area that no developer rarely touches with a little
user base can stay dormant for a long time, and when people do need
to hunt for an ancient bug or to enhance the existing feature to
support a new use case without breaking the old use case, the
original author may not be around, lost interest, or no longer uses
his own creation.

The code left behind tells us what the author thought was the best
way to solve his problem, but it does not clearly define what the
problem he tried to solve was, within what constraint he had to find
a solution for it, and why he thought that the solution was the best
(or sometimes "only") one.  Log and in-code comments are to explain
such things that are beyond how the code works and what it does.


[Footnote]

*1* In this message, I am not judging if the depth of your writing
    for the particular change is deep enough. It depends on how well
    the reader knows the area, and there is no single right answer
    to that question.
    
    Incidentally that is why we tend to err on the more descriptive
    side. The next person your commit will help may not know the
    area as well as you do and has to figure things out on his
    own. You are helping him by being descriptive.
