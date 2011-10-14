From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] http-auth-early
Date: Fri, 14 Oct 2011 11:59:04 -0700
Message-ID: <7vk487z9fr.fsf@alter.siamese.dyndns.org>
References: <4E9692BF.8040705@drmicha.warpmail.net>
 <cover.1318577792.git.git@drmicha.warpmail.net>
 <20111014131932.GE7808@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 20:59:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REmyP-0005Kb-5p
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 20:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754190Ab1JNS7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 14:59:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54431 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753242Ab1JNS7H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 14:59:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EFEA59F2;
	Fri, 14 Oct 2011 14:59:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZXrlIwFZmhkBooSB7OlZatxI+W4=; b=j7RlN7
	dDNmN2/Rqeu0UWjAgY7iz/dn6hbFcuHV7Jdb8R5N/TADOSdTTVOoYax2/A30aZgr
	ZGK9g6tMrXCU26HAfVeiEtvOE/bLlCzGhH4r4SmpN8Z0v9ibLtCjSzd3jOa4EQjH
	jY5bt+JJek2s+Psmtk28PHlkKcXS6tz+HJZZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hRn7KqSJ9IDsiMOl1p5QDK1f/B0+w3BZ
	kVZ7qosgaT2s+/Xe4zXyeAexo0arfnHGGb7t+Phmthg5XgF0v1pMVTJRbp6cbHHS
	eydzfoXqUy+V6FlyOpQxAH3YVRGlU8ePj30Kvbdu69Js12tlVMAnvT5LRQN4qCIH
	MwBZ1zJBZDY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36AB759F1;
	Fri, 14 Oct 2011 14:59:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C0E759EE; Fri, 14 Oct 2011
 14:59:05 -0400 (EDT)
In-Reply-To: <20111014131932.GE7808@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 14 Oct 2011 09:19:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 96B68572-F696-11E0-A159-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183595>

Jeff King <peff@peff.net> writes:

> Your changes all look right. The naming of git_getpass_one in the
> cherry-picked commit is a little odd without the rest of the series as
> context. I would maybe have called it "git_getpass_with_description" or
> something.

Thanks both; will queue with that updated function name.
