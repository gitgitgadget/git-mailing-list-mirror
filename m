From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make git status print a helpful death message if the
 disk is full
Date: Tue, 01 Sep 2009 13:19:57 -0700
Message-ID: <7v3a76fmdu.fsf@alter.siamese.dyndns.org>
References: <4A9D7B54.5020902@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: David Reiss <dreiss@facebook.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 22:20:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiZqM-0005A0-Hk
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 22:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754849AbZIAUUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 16:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752033AbZIAUUD
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 16:20:03 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59499 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753966AbZIAUUC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2009 16:20:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 584B121611;
	Tue,  1 Sep 2009 16:20:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g04qtKn2ITcMOPpKbQ+kTdsOyG0=; b=J5xGL1
	KrYFvI0Hlb4UI/nYY56eEfaSdNZHyeng3J2qyxqYQ7MgXh+UEb39w0MANc/3CDDF
	ZdYh/+jy+YjjPdoTcrXy+oc8SLcCNDMYeBGiFWJuVpczREGOGC421MEs4VEZ4UWt
	GNlIxuNXISWvv/5huNWt//ZB1xe4XmYP3cM2s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EprcVMIWH3ZyLT8s/ELUgyk8lHdCyf85
	olSKudtkedq0zrSTjpLyxmuY+qVJRHqcMb8gRaXReUoxZ2XIA1F2IWOSvN137X5O
	Oa10MBT9P69NJOTNUrwG+lahIW52o8atxL5w7NQk1nposQXsiE9aSuS09waxkO/R
	rWHx07AYdhg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3769B21610;
	Tue,  1 Sep 2009 16:20:01 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9938F2160B; Tue,  1 Sep
 2009 16:19:58 -0400 (EDT)
In-Reply-To: <4A9D7B54.5020902@facebook.com> (David Reiss's message of "Tue\,
 1 Sep 2009 12\:51\:48 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D39B2952-9734-11DE-9A86-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127553>

Don't we have die_errno() or something since at least 1.6.4?
