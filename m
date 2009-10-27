From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 2/2] completion: allow use without compiling
Date: Mon, 26 Oct 2009 17:38:10 -0700
Message-ID: <7v4opld631.fsf@alter.siamese.dyndns.org>
References: <1256589116-6998-1-git-send-email-bebarino@gmail.com>
 <1256589116-6998-3-git-send-email-bebarino@gmail.com>
 <7vocntd7vt.fsf@alter.siamese.dyndns.org> <20091027003353.GA29205@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Stephen Boyd <bebarino@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Oct 27 01:38:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2a51-0003n0-EO
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 01:38:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755504AbZJ0AiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 20:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755454AbZJ0AiV
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 20:38:21 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60904 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755416AbZJ0AiU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 20:38:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5657C68C77;
	Mon, 26 Oct 2009 20:38:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wBiH1bNKUmzjlA9vL2w9KAxWmrE=; b=U0tr6V
	xlgHCX0ADVhj34fgUgQV7G1ZKpM5/pWTIuvRw9nTGNNil/hAE8OKpiS48viVpykw
	uAPkpUEjhXLei44RpSFysPXYm9VFnV7CmdrE3Xiy3O0BOrcti7hgrF2aCUkgqaF0
	MaWYA+MSe1Ed+w7kroTYdlT5bOc9xXYl23RPY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yRyj8zONWE3EsN4Dmvh1yfImmtXImL0G
	6f1MKv8pVNMBuD1ctAKOdSx8sAZX+RIy5xxBWw4nNwolm6pfKDwhJcIXTd24S6im
	pZhpzVVDwecyz2MWqBeOSPgieVUa/DReTaVbVI2GEGi7ZlkMiBcB+6ap/tOEaUI9
	v72uGuuaAlk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C03668C73;
	Mon, 26 Oct 2009 20:38:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 18F5568C72; Mon, 26 Oct
 2009 20:38:11 -0400 (EDT)
In-Reply-To: <20091027003353.GA29205@localhost> (Clemens Buchacher's message
 of "Tue\, 27 Oct 2009 01\:33\:53 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 05BF723A-C291-11DE-ABA4-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131295>

Clemens Buchacher <drizzd@aon.at> writes:

> On Mon, Oct 26, 2009 at 04:59:18PM -0700, Junio C Hamano wrote:
>
>> Stephen Boyd <bebarino@gmail.com> writes:
>> 
>> >  This duplicates code, but I don't know of a way to re-use the dynamic
>> >  code without sourcing a bash script and possibly breaking someone's build.
>>
>>  (1) If the script notices that there is a file that contains the command
>>      list, it sources it; otherwise,
>
> Or we substitute the command list in-place, so that we still have the entire
> completion script in one file.

That defeats the whole point of my suggestion, as you would be overwriting
the tracked file.
