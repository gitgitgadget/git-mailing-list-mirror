From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for
 push.default
Date: Fri, 16 Mar 2012 05:05:52 -0700
Message-ID: <7vy5r0iwdb.fsf@alter.siamese.dyndns.org>
References: <vpqobs65gfc.fsf@bauges.imag.fr>
 <1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
 <20120316085152.GA22273@ecki> <vpq1uosswwz.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Mar 16 13:06:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8Vuy-0001tx-Ga
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 13:06:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965462Ab2CPMF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 08:05:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38857 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965092Ab2CPMFz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 08:05:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D79484F70;
	Fri, 16 Mar 2012 08:05:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YB4OLowhS0NSvlVWz1zo44pnqkY=; b=RJDSie
	eQDcLsowfUyTuQ+Ql903OMapAbyIh7kwcRorOKVoqxxLJXDiClXgVMudupmwWTK4
	AVN8FTqex4DXoVDCKFFQqMWkfrTbpSmy4kCbQVJeDFuk7NbfzkYYoHkCyxKYkQYY
	zCrS54kRZ5HyQLfkObE5/bqMqvSLGIOCRGUTg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JZdj4EMzYxzJ7Eh9yyj2xPkVOGYigTem
	bL0X9IbbQAfHJvMK21xMGFHtzSXvPOxapQk4K/bi93MT3rXXMqaKhfB1VkZJRbfD
	jPXlLqlLCHyFl7ARaiiQeVca/qj/lSTvL1cqJypi5qcMry2ackyzE+DkJ8eVExpR
	C12ViX9y3cY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF86E4F6F;
	Fri, 16 Mar 2012 08:05:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5214F4F6D; Fri, 16 Mar 2012
 08:05:54 -0400 (EDT)
In-Reply-To: <vpq1uosswwz.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Fri, 16 Mar 2012 10:43:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 61A37992-6F60-11E1-A325-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193256>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> I'd count "upstream is not set" as "current and upstream agree on
> 'current'". IOW, use "current", but error out if there's a configured
> upstream that is different.

And if there is no configured upstream, should it error out, or should it
just push the current one to its own name?
