From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2011, #06; Sun, 30)
Date: Tue, 08 Feb 2011 11:27:15 -0800
Message-ID: <7v4o8eqqcs.fsf@alter.siamese.dyndns.org>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <AANLkTik4jZWLt6T-SwMgK94FJ77ujyUC4-oFD46-eqN=@mail.gmail.com>
 <AANLkTikyHANL3y8VZ3LWu7bXkJwEHiiDLJ5NDZaA7z=b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 08 20:27:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmtDp-0006XE-4r
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 20:27:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755353Ab1BHT12 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Feb 2011 14:27:28 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45919 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923Ab1BHT11 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Feb 2011 14:27:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DBFAA3A25;
	Tue,  8 Feb 2011 14:28:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=NyritE3BrDi1
	L2l89pk3r98m7mc=; b=KzJPvbfpsQaQsE94eLcaf+VYbufWa9/1bgbJURH/Dqy4
	CtBCJ92WN0Z6rCnYz861qD5oBLMo3RR3oWNhhyqt23cqhLW0IKcRKcCkQ37iyBNW
	KqAjTS5S4KlhkJ/ptopxoepDQv8MTTQRBjhIKxkFMFDpPZboXKUgV3Y7hEUxwjw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=D8ddJE
	AJxQtthQV5IY5zVIe4SKll3vltgmcA9puL0d+BFBncO17Zjm60rMhehJDx7TrZ2r
	mZGN+1hdGjTbG6xKBCDcGODpyuPiBZXQaY6wyP4MxzRxvcTB24eLPQyE6uVWWAr5
	AZbxDXb0LJcq8Oy1iGcxDoUCrweV5dhnCUdO0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A6B1C3A1C;
	Tue,  8 Feb 2011 14:28:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 89D293A13; Tue,  8 Feb 2011
 14:28:16 -0500 (EST)
In-Reply-To: <AANLkTikyHANL3y8VZ3LWu7bXkJwEHiiDLJ5NDZaA7z=b@mail.gmail.com>
 (Sverre Rabbelier's message of "Tue\, 8 Feb 2011 18\:48\:24 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9666FAE8-33B9-11E0-8A53-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166366>

Sverre Rabbelier <srabbelier@gmail.com> writes:

>> =C3=86var, you didn't respond to that message. Junio, do I understan=
d
>> correctly that if this problem is addressed the topic is ready to be
>> merged to next?

Necessary? yes. Sufficient? I dunno, but it is a good start, I think.
