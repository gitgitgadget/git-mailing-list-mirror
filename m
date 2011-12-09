From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] t3040 (subprojects-basic): modernize style
Date: Fri, 09 Dec 2011 10:26:44 -0800
Message-ID: <7vd3bxfvob.fsf@alter.siamese.dyndns.org>
References: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
 <1323349817-15737-3-git-send-email-artagnon@gmail.com>
 <20111208163448.GA2394@elie.hsd1.il.comcast.net>
 <CALkWK0nbp465915ysrBXi46mur1dutBDtPNjwW=RdyPV03crzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 19:26:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ59n-0005RW-Tu
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 19:26:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752434Ab1LIS0r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Dec 2011 13:26:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54295 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751238Ab1LIS0q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Dec 2011 13:26:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D6557770;
	Fri,  9 Dec 2011 13:26:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=91Hp0L54qHup
	8fFaGRViIYbb+yc=; b=FiwPvevi38VMHYLp9IpqIOkjWYUk41Lh/aJLPV+nGtoI
	AULk0xEUoSe4UxB/iMeOdwS5ttuu9Ldi3wxg/1QkTKF6qYfbxwJAidt6uru/kvTV
	4gNW+pig4Smqy+DTVZt6LgjiKJvCjAmtQC9CFX9tHiClbdz7Sk7mRrT4+DBrDyg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=GwG/Oo
	ZcB0PS+By9buA6DG/WW4Kdn55wSwO1H/ppwdgLvLXCVpxDVCV9OQn1i5eWOScZzw
	FeL6fitDHPHyfuQJ8/mqLWYlUNWMXba2IN35XB4JMNl2hgcreiLR9DrutlddQidd
	Us9czfnUwwna2i0/evXpqoNtSXlir0gr4xSgY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02DF5776F;
	Fri,  9 Dec 2011 13:26:46 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 68E55776E; Fri,  9 Dec 2011
 13:26:45 -0500 (EST)
In-Reply-To: <CALkWK0nbp465915ysrBXi46mur1dutBDtPNjwW=RdyPV03crzg@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Fri, 9 Dec 2011 13:26:49 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 597835EC-2293-11E1-8D35-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186658>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>> I suspect the above description, while it does describe your patch,
>> does not describe the _reason_ that the patch exists or that someone
>> would want to apply it. =C2=A0Isn't it something more like:
>> [...]
>
> Right, fixed.

Does the "fixed" mean "I fixed it locally; please expect to see it in t=
he
next re-roll?"

Just a quick question, not asking you to always spell it that way.
