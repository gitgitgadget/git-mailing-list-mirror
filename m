From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] add: warn when -u or -A is used without filepattern
Date: Mon, 28 Jan 2013 10:31:30 -0800
Message-ID: <7vzjztw459.fsf@alter.siamese.dyndns.org>
References: <vpqobg966cv.fsf@grenoble-inp.fr>
 <1359364593-10933-1-git-send-email-Matthieu.Moy@imag.fr>
 <51067353.2090006@drmicha.warpmail.net>
 <7v4ni1xjuc.fsf@alter.siamese.dyndns.org> <vpq8v7dw4f5.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jan 28 19:31:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TztUp-0003FF-0z
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 19:31:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079Ab3A1Sbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 13:31:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35454 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750938Ab3A1Sbc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 13:31:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2051AC9CA;
	Mon, 28 Jan 2013 13:31:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kke7R61QSQ496RrZA3fb+u7JcX8=; b=I0NQVD
	LHzMIVaj/xY9LkcGZRC8jBBn9Aq6cNdaF9HMcMDFdmCqXQm5yIJHZnimXJmnuz0Y
	0hVTTym5nRNFq/57r7xwnoMWuTRtK/33wubrtY0yiG5eWOLiBDkfq/RL7nowLdM7
	Zrv1C0rKa8abVNa0VzCcj7GWonZxFBEMX4ec0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eOMQziQG0h5Dh+1cJ0JM2aL5SPypDelX
	xLqlfy1rOTU2+eGUt1rsLoCNI0adjEbmggbxD66PhC97Ey6zOTsIokqUvEDlv2TW
	zy1YlG95Yq5uibcyquLcblY9e0IGbDjKOyHW9dMVs/yag2NvVizzNNbQpvWdadK+
	J3LqDdg1L4U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1427DC9C9;
	Mon, 28 Jan 2013 13:31:32 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 93D7FC9C6; Mon, 28 Jan 2013
 13:31:31 -0500 (EST)
In-Reply-To: <vpq8v7dw4f5.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Mon, 28 Jan 2013 19:25:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EFE79A2C-6978-11E2-A2B2-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214850>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I think "add -u && commit" vs "commit -a" you brought up is a good
>> thing to mention, so let's do this.
>
> I'm OK with your proposal. Let me know if you want me to resend.

Thanks for a quick response.  As you may have guessed, I am sending
these after running "commit --amend", so ...

>>     The inconsistency of 'git add -u' and 'git add -A' are particularly
>
> Nitpick: this should be "inconsistencies" (or "is particularly").

... it is much easier for me to fix these locally instead of getting
a reroll.

Will amend with s/are particularly/is particularly/; thanks.
