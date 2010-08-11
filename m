From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/lib-git-svn.sh: use $PERL_PATH for perl, not perl from
 $PATH
Date: Wed, 11 Aug 2010 11:32:02 -0700
Message-ID: <7vzkwtxaot.fsf@alter.siamese.dyndns.org>
References: <1281442465-27750-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>,
	"Philippe Bruhat \(BooK\)" <book@cpan.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 20:32:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjG6H-0001vp-68
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 20:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755292Ab0HKScR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 14:32:17 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46980 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755226Ab0HKScO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 14:32:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E596CC3CE;
	Wed, 11 Aug 2010 14:32:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Pvng3AlDYU5K3SKIwVM64U8fpl0=; b=DTQYOMG21C81vTmvrbVbAK1
	suVWIahoblyWLiwQOdG3Du8JgRCvU9wPLwaCvs5TVkYByVkBxxBbo9zJ0K8eg1Dy
	VTFXIcW8QFxnkCfoxQmM1voZKeqNtp+lbh+iTGyHAUmWdjsPlYD3obhr3cC45zte
	pOtLRkN61E8nfSkA+K7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=kQGrJOdA1sPLaMbJdCOheHrfN3p79zSfCaDtZKh5N1W2+y3AR
	BSse0NcENVdv1bMXrEimgaHgYsN72NUJOO5CeUcS5aFNx6LQbKWmDgeJszRwUbNm
	aTtb8Mi/xVCYYvhZwQWJA7TdYVS4k1XcNbUxmlzDvy/k1W3JL7Xzm4kgbs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F595CC3C9;
	Wed, 11 Aug 2010 14:32:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 387BBCC3C6; Wed, 11 Aug
 2010 14:32:04 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C031F9DA-A576-11DF-A337-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153274>

Thanks.  Other test scripts (and the insn in t/README) refer to PERL_PATH
already and t/test-lib.sh includes build options for its definition, so
this should be complete.


 
