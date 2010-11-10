From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git describe weird behaviour
Date: Wed, 10 Nov 2010 11:38:58 -0800
Message-ID: <7vaalhhstp.fsf@alter.siamese.dyndns.org>
References: <20101110010016.GC22105@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Nov 10 20:39:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGGVm-0001it-1J
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 20:39:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756622Ab0KJTjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 14:39:07 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50582 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753608Ab0KJTjG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 14:39:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 52EFA34C5;
	Wed, 10 Nov 2010 14:39:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fzXeejvOZsugVbzCqWEuvbRfkkg=; b=nwffer
	dM2vR/oheZgfCBi5atJiRAUXvwMf/G1x/KJzDF+DOQiNDKfCmA0dAXEs5H36wDq7
	jeXx8RErhMbZ1ng53E5ECLvUXD4z4feUtoAaIGNdGzUHNWSUQIEatxTnO349kIMp
	DVwLtm3UeHvr+na23ErL6mbj6IBPkicbm+mqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l69jBul5i/qi59xbiKO3uj5/1kUcqQAK
	J8jTYR2B5u74SA5iICHjujdoN0fAO6lCAKqmDvmULaYr8Co6zpnymqkGl+9WQkWk
	wSjfp3BthmIsmm1xCMpWC3E+b2aQc46ZodErtZ2V9gRivLgTHCYzY+s/T0d1Fpdq
	MV+Q1eUhoVM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2E45334C4;
	Wed, 10 Nov 2010 14:39:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4E58C34C3; Wed, 10 Nov 2010
 14:39:04 -0500 (EST)
In-Reply-To: <20101110010016.GC22105@genesis.frugalware.org> (Miklos Vajna's
 message of "Wed\, 10 Nov 2010 02\:00\:16 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2E93019E-ED02-11DF-851F-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161174>

Just a guess.  Does this have to do with 80dbae0 (Chose better tag names
in git-describe after merges., 2007-01-10)?
