From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GIT_ONE_FILESYSTEM inclusion?
Date: Wed, 24 Mar 2010 09:33:26 -0700
Message-ID: <7vpr2tu1bd.fsf@alter.siamese.dyndns.org>
References: <20100323232055.GV7038@pixar.com>
 <81b0412b1003240229l6f7eaa18l563c3d7ba0cf6cc5@mail.gmail.com>
 <4BA9DCDD.6060109@viscovery.net>
 <81b0412b1003240437n799bac07sb74db749d647817d@mail.gmail.com>
 <20100324134048.GB10190@pixar.com>
 <81b0412b1003240659u4e6de405t7750b66ca9292cdc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Damerow <lars@pixar.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 24 17:33:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuTWb-0008B6-VL
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 17:33:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754168Ab0CXQdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 12:33:39 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65455 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753271Ab0CXQdi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 12:33:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 918EDA428F;
	Wed, 24 Mar 2010 12:33:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cKuJXFraSMEDu/HE6RX3XbpP/aM=; b=TiDY1/
	OF3DynosaRMVnCmjTY4ZKY3Js9cYISYln9uE0q4IL7laCVUHgvEUcFVfZUxCb1Sd
	4CBKmKZKOKNi2vjHSbps5415jR8G9v+YU5XRjpxrUr2JIucoYctKWlU6oDBOPXNH
	3u8BYboEeQZIeug97wJ7zTo0cg+2jK3kXW9P4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rfHzIQNo2EmhfEGadiKuJofzQnvCGrre
	Ssor0GoUyHAsC/jgLPWdE2wuepXeKjoMKYPWDwfR0tqYl7B/mzrtwETRLeo6/cKs
	WdN8AN2T8IWxy7Bp2QWMFXVzupRYkg5e5cwcszzMzwRYMgZtwuClboTG4VGTvYI+
	TSJEFtwGx2I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FCB9A428C;
	Wed, 24 Mar 2010 12:33:33 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7DC40A4281; Wed, 24 Mar
 2010 12:33:28 -0400 (EDT)
In-Reply-To: <81b0412b1003240659u4e6de405t7750b66ca9292cdc@mail.gmail.com>
 (Alex Riesen's message of "Wed\, 24 Mar 2010 14\:59\:00 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FCD81914-3762-11DF-B280-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143092>

Alex Riesen <raa.lkml@gmail.com> writes:

> Oh, I wasn't clear. I didn't mean "instead of". A command-line option
> _in_addition_ to the environment variable. For one-off uses.

I may have been the one who mentioned "-x to git potty" as a possibility,
but I agree with Lars---I think it would be too cumbersome to use in
practice.

When would you invoke this feature as "one-off"?
