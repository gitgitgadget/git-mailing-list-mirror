From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-parse --parseopt: add the --sticked-long mode
Date: Fri, 25 Oct 2013 15:55:46 -0700
Message-ID: <xmqqsivphsel.fsf@gitster.dls.corp.google.com>
References: <20131016223306.GN9464@google.com>
	<1382732291-5701-1-git-send-email-boklm@mars-attacks.org>
	<xmqq1u39j9hw.fsf@gitster.dls.corp.google.com>
	<20131025225222.GL4589@mars-attacks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Vigier <boklm@mars-attacks.org>
X-From: git-owner@vger.kernel.org Sat Oct 26 00:55:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZqIL-0005QW-OB
	for gcvg-git-2@plane.gmane.org; Sat, 26 Oct 2013 00:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099Ab3JYWzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 18:55:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56328 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751541Ab3JYWzt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 18:55:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83BF54DDFF;
	Fri, 25 Oct 2013 22:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g9N6wQ+GqFntcvvY1bWEQiWECoA=; b=g3leFQ
	oTySejuV70Bo71T9fUybNDmUAhnlE5B99p9vGNpxjB4j11dDzWCsnZugxetECpGn
	LBSWUwqpytpwxDGseqlRIbgLKO87E/JtzZdnUrOQczmv0rC8mYwfIPwGCRYYR+GN
	wLCUIucXXOH7AkxnZIY8h7OIUKP1m4fB2kJz8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CJqP2IESQClusOHTKiwMlQ+OsOK2GT6U
	LTPDlThhf1B1agHy/EBf2VnYQfzlFcjPrEUND27eIlUCFNe3ym5Z/woZtngw9YIZ
	VNRSFB7h4hfd3bbKucIMoxhMY5AzkcKlHc1iELG8f8TLtpgAjF1kGKtU2swd3Zts
	LNG7Sg1uUlc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77A044DDFE;
	Fri, 25 Oct 2013 22:55:48 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD5F84DDFD;
	Fri, 25 Oct 2013 22:55:47 +0000 (UTC)
In-Reply-To: <20131025225222.GL4589@mars-attacks.org> (Nicolas Vigier's
	message of "Sat, 26 Oct 2013 00:52:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 966EA182-3DC8-11E3-AE15-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236723>

Nicolas Vigier <boklm@mars-attacks.org> writes:

> On Fri, 25 Oct 2013, Junio C Hamano wrote:
>
>> Nicolas Vigier <boklm@mars-attacks.org> writes:
>> 
>> > Add the --sticked-long option to output the options in their long form
>> > if available, and with their arguments sticked.
>> 
>> Hmph, doesn't verb "stick" conjugate to "(present) stick (past) stuck
>> (pp) stuck"?
>
> Ah, yes it seems. I don't know if 'sticked' is also correct or not.
>
> However, 'sticked' is the word that is used in Documentation/gitcli.txt
> and Documentation/technical/api-parse-options.txt.

Yes, I know. That is why I brought it up before we inflict more
damage to us.
