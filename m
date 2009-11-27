From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Nov 2009, #06; Wed, 25)
Date: Fri, 27 Nov 2009 10:29:05 -0800
Message-ID: <7vvdgvn7ny.fsf@alter.siamese.dyndns.org>
References: <7v8wduksgq.fsf@alter.siamese.dyndns.org>
 <20091127065904.GE20844@coredump.intra.peff.net>
 <20091127144553.GA24366@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 27 19:29:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE5ZJ-0006TK-3g
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 19:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856AbZK0S3I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Nov 2009 13:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751971AbZK0S3I
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 13:29:08 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36947 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812AbZK0S3H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Nov 2009 13:29:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 33857A23BC;
	Fri, 27 Nov 2009 13:29:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=BEoeSZrtTFCRPx/mtsuUiEq1E
	zI=; b=LTw5Y0tkuZuvtj70UaPUP9BNzzYPQR6PuoNBaZtZ52D9eEpfno3twS36z
	3vxAKVX25zXzVgGXVUS6xYXzqzbGBEtN4z/zuSAGvxQMpKS9x/UGseNMtKTQoxiT
	O0KD315jAy2VLqK5LFZU/hmMs2DC99xY30L9IUrwo5LUk/Gf3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=Jdti6uDqcCEu9/rQdE6
	E7PhDP5emCEwXCK0TZoEuzGjaUhdWRFJkTw06dYY7FFJu2gGhMNxILUAcewcJBof
	clQ+csZ/CaAV4Whsj+DpQm7KDPaN8ib0Ptr6/jgvdJbEZpbsJwqoehjUgu5xm4kD
	iRgiW+X8HvWXqAboJdoUW9WY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 04ABAA23BA;
	Fri, 27 Nov 2009 13:29:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A91B0A23B9; Fri, 27 Nov 2009
 13:29:06 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C1B3D832-DB82-11DE-B645-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133918>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> I can try to pick this up. But did we reach a decision on having a
>> configuration variable?
>
> I am not sure, but I will say I would prefer not to have one.  Surely
> we can come up with a UI that does not require searching through
> git-config(1) to be made convenient.
>
> Couldn=E2=80=99t we just add the option (with test and documentation)=
 first,
> to get some experience with how we end up using the two forms? =20
>
> If --full-tree does become the default, I think it should be in 1.7.0=
,
> when it is expected for some habits to break (with a configuration
> variable for the transition, I guess).  This might be okay, since
> constructions like 'git grep foo -- "./*.h"' should still work.

The flipping of "grep" default is too late for 1.7.0, as we have only
started discussing it, and I want the release after 1.6.6 to be 1.7.0.

I do not think we want nor need to have other things we have already
prepared and have been advertising for 1.7.0 to wait one more cycle.
