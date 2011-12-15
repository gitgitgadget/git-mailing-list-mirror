From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [msysGit] Windows & executable bit for newly created files
Date: Thu, 15 Dec 2011 12:56:39 -0800
Message-ID: <7vwr9xmu48.fsf@alter.siamese.dyndns.org>
References: <4EEA5387.5020808@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Thu Dec 15 21:56:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbIME-0007Zk-4c
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 21:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759479Ab1LOU4o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Dec 2011 15:56:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45528 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759225Ab1LOU4m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Dec 2011 15:56:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4BE05262;
	Thu, 15 Dec 2011 15:56:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=6vpjTrMcmofo
	7K6ErbHv3CFoBlY=; b=S5929lSDlSjKYq7DCK+hnTMrlE9Fe4kDx84B6Zm4KWlS
	FudnI9T9qWAYWkpEKuSymUtsn0t0dypTJC07rTNg0tRIossUaClwKVLlG/1e0ps8
	UBtjoYi2SszNmHe3F/c06OwCtnu73mzVKsCxKIq4IcJcTwU1kXdUJzX6tGvB71o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cfBISt
	2fYUQUvbtmU/wP5Oh2XnlRE8El476scvBaS9iDRAUlgRQPT2Ae+0rkMXx4r55ZoA
	4o94imNdbPi1xiDe62nWvxUfqbWCJdX9kF9IBTa4xYVelTV/055ou53lsxSzAfOd
	OgC2K+W9x4eNMvFjYwGklH9PLlENPzpXKM2tU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBE6F5260;
	Thu, 15 Dec 2011 15:56:41 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D4CC524E; Thu, 15 Dec 2011
 15:56:40 -0500 (EST)
In-Reply-To: <4EEA5387.5020808@dirk.my1.cc> ("Dirk =?utf-8?Q?S=C3=BCsserot?=
 =?utf-8?Q?t=22's?= message of "Thu, 15 Dec 2011 21:07:35 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 49C228BC-275F-11E1-ACEB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187232>

Dirk S=C3=BCsserott <newsletter@dirk.my1.cc> writes:

> Is there a way to convince git that the new mode is 755 instead of 64=
4,
> even with core.filemode set to false? So that the mode is correct whe=
n I
> checkout the file under Linux later on?

"git update-index --chmod=3D+x"?
