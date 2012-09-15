From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2012, #05; Fri, 14)
Date: Sat, 15 Sep 2012 10:01:25 -0700
Message-ID: <7v4nmz1aqi.fsf@alter.siamese.dyndns.org>
References: <7vboh82t7p.fsf@alter.siamese.dyndns.org>
 <k31k35$pc$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Sat Sep 15 19:01:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCvkS-00027P-NC
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 19:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841Ab2IORBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2012 13:01:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55673 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754709Ab2IORB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2012 13:01:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23FED8A26;
	Sat, 15 Sep 2012 13:01:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aYGLWRTmtM/SGmc/PpoGwbvSzVc=; b=S+juBM
	lUnSOYll6ANDnWKmKh7AUGjLbnTsywbFunzE7HUull7Z+cNz69RXJaKBHDyQpazE
	G9egEocmb1t53fZYst64btw2JaD953hjnB3S6fSzmaYzgf37/5xlOuFqbUtEWcmF
	fIkEJVUM7r+5eBdvlKOA+uEUN+BrmPa2fGygU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oIGaBglffwDAx58UNTmoAcJihvZxL05g
	u7Pj+jBdVVUDNf2y8sNzbyFEQeQ30e7E7DhSkVIxy0zMv1Bki7Lbq23iEnL7sNcb
	8/k4NHbEXd8IJjdugg9BQQKOIgIvb3YxftKqO2voDqlbDq+8ongg87DbJ6t+I8W4
	1WsznrtCu50=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 126B18A25;
	Sat, 15 Sep 2012 13:01:27 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 843D58A24; Sat, 15 Sep 2012
 13:01:26 -0400 (EDT)
In-Reply-To: <k31k35$pc$1@ger.gmane.org> (Joachim Schmitz's message of "Sat,
 15 Sep 2012 12:08:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FC72F566-FF56-11E1-833D-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205562>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

> Junio C Hamano wrote:
>> I think we can start thinking about feature freeze once the topics
>> in 'next' that are scheduled to graduate to 'master' already are
>> fully cooked.  For any late-coming topic, there always is the next
>> cycle ;-)
>
> I've not hear anything about my poll patches and I'd really like them
> to into 1.8.x.

I've seen some patches on "poll" posted, were discussed and had
threads titled "Re: [PATCH] ...".  But I didn't see a rerolled
"[PATCH v2 n/m] ..." series that states that it is a rerolled
"hopefully final version" that addresses all the points that were
brought up during the discussion that need to be addressed.

I do not necessarily follow all the minute details of all discussion
threads.  For this particular series, I not know which ones of your
"poll patches" turned out to be unneeded, which ones turned out to
be fine as posted originally and which ones needed updating.
