From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Possible bug in `remote set-url --add --push`
Date: Mon, 14 Jan 2013 11:09:40 -0800
Message-ID: <7v1udnbmyz.fsf@alter.siamese.dyndns.org>
References: <CAN8TAOsnX1Mr72LPa47KKXDeUZPgSHTJ6u4YpPFPrtsK7VdN+A@mail.gmail.com>
 <7vliby98r7.fsf@alter.siamese.dyndns.org> <4836187.09xoy3kJnj@blacky>
 <CAN8TAOv0Cm8CgiJSweFtRzOqO78OtNKa4G+x7z6M5Bt+odUmiQ@mail.gmail.com>
 <50F40316.7010308@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jardel Weyrich <jweyrich@gmail.com>,
	Sascha Cunz <sascha-ml@babbelbox.org>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jan 14 20:10:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TupQB-0002WE-DV
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 20:10:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758334Ab3ANTJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 14:09:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37812 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758329Ab3ANTJm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 14:09:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E060A367;
	Mon, 14 Jan 2013 14:09:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IHJZRLZqtGrOEAtyL1mIfTW2k8s=; b=kQmZX/
	115SkCe3mc4uA2mRENfW7bO8qDYOEmUto7ynMQp8USAiIl1B2KPL0of4SNs8iO02
	1BbUHez1qlOwuGtW1y6qaLXZ3C2OlrFRyw/UN0fQ70opIdmXIImjYcqXNWulRG11
	nyrNhRJY3CxFnVR1yo46a1wH4OJx9tgtd4o7w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R+z2GP+FRuweoDHBQ1AeDLB5GCRHNwna
	+hkSAO/vyLlyLqJr7MB9njS03emcEzb90siiJ8bFZNy1sKluzKZv0VFccn92AMGZ
	COxcd5137oJarx8HdEQkF4ed56/7IHKU6Yt5nfzG21FAob/YJcfqVuY4HUZK16Q7
	x44RMs6J38c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07EEEA365;
	Mon, 14 Jan 2013 14:09:42 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 78BCAA35F; Mon, 14 Jan 2013
 14:09:41 -0500 (EST)
In-Reply-To: <50F40316.7010308@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Mon, 14 Jan 2013 14:07:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F2FF09B2-5E7D-11E2-AD9A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213517>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> It seems to me that everything works as designed, and that the man page
> talk about "push URLs" can be read in two ways,...

Hmph, but I had an impression that Jardel's original report was that
one of the --add --pushurl was not adding but was replacing.  If
that was a false alarm, everything you said makes sense to me.

Thanks.
