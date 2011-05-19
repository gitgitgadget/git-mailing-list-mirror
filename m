From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] add Android support
Date: Thu, 19 May 2011 07:17:27 -0700
Message-ID: <7vsjsa93m0.fsf@alter.siamese.dyndns.org>
References: <B22B44EF-0AFB-44E3-93E3-61FA730431B9@gieschke.de>
 <7vaaej9pt3.fsf@alter.siamese.dyndns.org>
 <2218C353-80FC-4540-A60E-608385384FB5@gieschke.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rafael Gieschke <rafael@gieschke.de>
X-From: git-owner@vger.kernel.org Thu May 19 16:17:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN42r-0007Pk-0r
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 16:17:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933422Ab1ESORh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 10:17:37 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40445 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933378Ab1ESORf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 10:17:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 36E793A53;
	Thu, 19 May 2011 10:19:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UR9cDVPoCfaZpoY6i76rLV/ejzY=; b=tdSXpw
	vlDUkG+KGsTGcnAGylkYwKhBaQpReAp7Zs5G8Fgr7HLZv3zw3ojrK9xiI9+sijoz
	7hz1PWDSGJ3V9D0t1sI0N8n+mPD7jWPhPFwpd7D8mFCWWRRLpfU8Hf/cVWL8vxP7
	m+wmdu/NJ6b2ueD3xQE9b3PFsLh5nGNEqkl/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YH4CBrIltEXzNIvIh00dEQ04RIHjzikm
	4A3fTvBC6yhT0nuUMg2TgHXy/OjiF1RQ0Ot+YSK8zsJ2Dh1YY3kjYzyJ7OLiyYlu
	0k+P8VFtgpPscXGCqOGV7QFcveI+m1PzDkUJ5YiVh4I0zQunHuGNSaPEXLmB4hkt
	Myo32fD2EwY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1462C3A51;
	Thu, 19 May 2011 10:19:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 37AF33A4D; Thu, 19 May 2011
 10:19:35 -0400 (EDT)
In-Reply-To: <2218C353-80FC-4540-A60E-608385384FB5@gieschke.de> (Rafael
 Gieschke's message of "Thu, 19 May 2011 13:37:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 07F2649C-8223-11E0-8F93-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173958>

Rafael Gieschke <rafael@gieschke.de> writes:

>> (3) Add uname_S = Android (Makefile).
>> 
>> The first two would become much easier to justify if presented that
>> way. At least you won't hear from anybody "we don't want that much code to
>> not to run git on a phone!", as it is not entirely implausible to imagine
>> environments without support for one or both of these two facilities.
>
> So, you would prefer to leave out ANDROID and use something like "ifeq
> ($(uname_S),Android)", so you will have to compile using make
> uname_S=Android? I would be fine with that, too. But I would also be
> fine with having to specify the build options on the command line or
> using a config.mak if you want to keep Android out of the Makefile.

Ignore differences s/Android/ANDROID/; I just typed differently without
even noticing I was doing so (the same for GECOS-PWENT but if you liked my
name better that is fine by me as well). The point is that I didn't mean
to suggest changing names of symbols you used.
