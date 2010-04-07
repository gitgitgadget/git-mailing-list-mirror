From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9] Documentation/remote-helpers: Add invocation section
Date: Wed, 07 Apr 2010 08:05:40 -0700
Message-ID: <7vsk77e20r.fsf@alter.siamese.dyndns.org>
References: <g2vf3271551004062257ycbda64d3z3d3004d802a03fc3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 17:06:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzWq8-0001iR-EY
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 17:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932722Ab0DGPGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 11:06:05 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58909 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932659Ab0DGPGD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 11:06:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CCB0A81A7;
	Wed,  7 Apr 2010 11:06:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Fw3oS0woT5X9oea/hjEa4cMWbUg=; b=sp4l0wiokl2GijbKIKw8Jc8
	kn5dPlcsfj66Q9o61prL7yNqhdt2jisytX4SQUefXixzFPTB6jKNrX3UpUlEaN79
	N8rFnJQ7jNkJjQDHO2Ms25ADkzYZvsTmKhfE4R3ss+oGfzhfqBWC3ih7r9aED/HG
	G7T/c2ABrfASgjm2WbrU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=HFkRMNS2n9pD/FZi7h5v6djtMsq69wkUUjf+x3SglsLm9JLZ/
	IZRNqe3pge/3rIEXqY/N/6LuTmxHE5dRr7r/sGh5o2wYfJpIX8P9oz/2CE+OA3dD
	pxDkuce3L/bhQ+q66U+GH7CPxspplIQPnAR/FRC/7FhGuQZxJkHLsTJgMY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 73E0DA819F;
	Wed,  7 Apr 2010 11:05:51 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 47C19A8191; Wed,  7 Apr
 2010 11:05:42 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0E552188-4257-11DF-8221-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144233>

You keep sending a broken patch.  I've queued v7 and replaced with v8 and
both times I had to fix them in my editor.

I'm not replacing v8 with this tonight, as my pre-push test cycles are
already running (finished in one vm and continuing in another).  Please
check what I queued and make sure your future patches applies on top of
what I have.

Thanks.
