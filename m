From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Adding Beyond Compare as a merge tool, was: Re: What's cooking
 in git.git (Feb 2011, #05; Wed, 23)
Date: Sat, 26 Feb 2011 02:33:16 -0800
Message-ID: <7voc5z6q6r.fsf@alter.siamese.dyndns.org>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org>
 <4D68D4FA.7090500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: judge.packham@gmail.com, git@vger.kernel.org, charles@hashpling.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 26 11:33:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtHSv-0000dt-Gz
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 11:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786Ab1BZKd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Feb 2011 05:33:29 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48836 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730Ab1BZKd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Feb 2011 05:33:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6E9082C63;
	Sat, 26 Feb 2011 05:34:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HQi3qQCdJjn5gzhay4YxdUMhBk8=; b=vheb/H
	7aoWinohEwtxv8vchTMark4NmeK5JTOo/uWsHXXz+o6MiiTE8D2ySHX08g8C3zYO
	cnY/QRugElyb9Q2QiN2DOTx3X7nAtT5ErPAsZgurCrZK9ygulU0QREtf/zkxj+ph
	jytL1//6DrdqN3i+zbOZHo8UD9phldYjWuf9g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ej/FkVdUqyvSFuY/EIGP701Q/0w2SaT8
	EkvWbTAuTW05mHuPhAG0HV7A7iLsO9oGc9JZl/+0FNabwUAigGUUUEZQsce/1HEn
	rrU7214qG6D3cDLckVS9ShehjfWOL5BGtX+8YM6hOWzbhBuYyqplxybzYSErxPs+
	Py8POu/4N6A=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2DCEC2C62;
	Sat, 26 Feb 2011 05:34:40 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E107A2C61; Sat, 26 Feb 2011
 05:34:34 -0500 (EST)
In-Reply-To: <4D68D4FA.7090500@gmail.com> (Sebastian Schuberth's message of
 "Sat\, 26 Feb 2011 11\:24\:58 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 04230580-4194-11E0-854E-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167972>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> For your convenience, I've rebased onto the current master and
> attached the patch files.

Could we be even more greedy (and lazy) and ask you to send them as a
three-patch series, one-patch-per-message and plain-text, as well, so that
these can be discussed on-list just like any other patches?
