From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] run-command: Error out if interpreter not found
Date: Thu, 26 Jan 2012 11:32:42 -0800
Message-ID: <7vr4ym2rad.fsf@alter.siamese.dyndns.org>
References: <1327444346-6243-1-git-send-email-fransklaver@gmail.com>
 <1327444346-6243-6-git-send-email-fransklaver@gmail.com>
 <20120124232421.GH8222@burratino> <op.v8moybu10aolir@keputer>
 <4F205028.4060606@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frans Klaver <fransklaver@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Junio C. Hamano" <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Jan 26 20:32:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqV3y-0001fl-PU
	for gcvg-git-2@lo.gmane.org; Thu, 26 Jan 2012 20:32:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746Ab2AZTcq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jan 2012 14:32:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44424 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751382Ab2AZTcp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2012 14:32:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBBAC501B;
	Thu, 26 Jan 2012 14:32:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IShniLdyoZwL3Wmp2mL2lkRtVFk=; b=FyP3R/
	/esjFzSbV3z7TLG1AnTDdVOsxPxGIP5cvl4uI/WTvvScL0oil7CpSQC7w/pE74lo
	j+ztwQkGleIWKDZeanE+tBzA0YaWnAV3qwdMBFJW5KXkPWzOj8p5WHfvg22i1yiC
	zVR3ZCsGc35+u4x45iH8+0Hv06SPlcloHn/Ko=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SUjhhqNPTp1QuTUIR7Fsa+f4TzCeKaUf
	E8688GUoTdqbqFnkCiy4EU7dybNlqmC8htIx9xEbYtq3RYYm0ln8EnO8U01F2Wei
	z9JoOMoIOCmylMYshj9A6A0hMTeMbMiLJ51m3kxKjS5s5k3fIbhD9jqPoNPOFFR1
	egrwpjnnhXs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1D39501A;
	Thu, 26 Jan 2012 14:32:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2FFFD5019; Thu, 26 Jan 2012
 14:32:44 -0500 (EST)
In-Reply-To: <4F205028.4060606@kdbg.org> (Johannes Sixt's message of "Wed, 25
 Jan 2012 19:55:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 84E825DE-4854-11E1-8EC3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189162>

Johannes Sixt <j6t@kdbg.org> writes:

> No thanks. IMHO, this is already too much code for too little gain.

Thanks for bringing a bit of sanity. You have already said it "In which
way is git different from other tools that execvp other programs?" earlier
(http://thread.gmane.org/gmane.comp.version-control.git/171755/focus=171848)
