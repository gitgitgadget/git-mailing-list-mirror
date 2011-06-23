From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] glossary: clarify description of HEAD
Date: Thu, 23 Jun 2011 10:12:51 -0700
Message-ID: <7vtybg320c.fsf@alter.siamese.dyndns.org>
References: <7vy60s36mm.fsf@alter.siamese.dyndns.org>
 <1308847958-3429-1-git-send-email-gitster@pobox.com>
 <1308847958-3429-6-git-send-email-gitster@pobox.com>
 <20110623170658.GC3142@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <carlos@cmartin.tk>
X-From: git-owner@vger.kernel.org Thu Jun 23 19:12:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZnSd-00042m-8Q
	for gcvg-git-2@lo.gmane.org; Thu, 23 Jun 2011 19:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583Ab1FWRMy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Jun 2011 13:12:54 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59149 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759408Ab1FWRMy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2011 13:12:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 140F45E7E;
	Thu, 23 Jun 2011 13:15:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=PdRf7+lilEsr
	+fkNHcmB3W9YoqA=; b=hsaSE9IGQEb/4iNfNsVbNjMmhNHb5GznXbiJDoxJCH/b
	96hzGpJiC1Tu+nhgl8FYJnfh4d49Q181H78U5ANPEK93Fs3fVOxeXewsudJelEBy
	S7G6C1bUtANIEbilsYdsgTIV2xtwQos7RzM4uZJcILzNyccH5lVeifyRG5AlVE8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=C5g/9+
	4engp+TJElTo53laS5s6iw3s9PzzlrJMj9ZoKLA1AAhECjPxc8AA96hzYFKb9elx
	huUkIwHXDsjO27MCdg1GqaOnf7StT2O1njVfX/b62FYyhrLT3ftoWEWUix08KTjO
	dORqdUs6t/laKWcBRVZb6nLYySwSUxfCVac3Y=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DAB245E7D;
	Thu, 23 Jun 2011 13:15:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3E1E35E7C; Thu, 23 Jun 2011
 13:15:04 -0400 (EDT)
In-Reply-To: <20110623170658.GC3142@centaur.lab.cmartin.tk> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Thu, 23 Jun 2011 19:06:58
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 55F4D472-9DBC-11E0-B16A-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176282>

Carlos Mart=C3=ADn Nieto <carlos@cmartin.tk> writes:

>> -	<<def_detached_HEAD,detached HEAD>>, in which case it may
>> +	<<def_detached_HEAD,detached HEAD>>, in which case it may directly
>
> Why "may"? As I understand it, in detached HEAD, it /does/ point
> directly to a commit

True; I just kept the original without thinking too deeply about it.
