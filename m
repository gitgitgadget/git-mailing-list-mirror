From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] gitk: Provide a default mc function if msgcat is not
 available
Date: Sat, 24 Oct 2009 15:08:53 -0700
Message-ID: <7vws2k4f7u.fsf@alter.siamese.dyndns.org>
References: <1256415640-10328-1-git-send-email-bernt@norang.ca>
 <1256415640-10328-3-git-send-email-bernt@norang.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Bernt Hansen <bernt@norang.ca>
X-From: git-owner@vger.kernel.org Sun Oct 25 00:09:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1onP-0000Eo-Ul
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 00:09:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462AbZJXWI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2009 18:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752026AbZJXWI6
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 18:08:58 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60380 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbZJXWI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2009 18:08:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8AD7984907;
	Sat, 24 Oct 2009 18:09:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hpNyqslXvPeUZY7HEu+2EFS97Hc=; b=dYnhdL
	zCrEXvr0zIQ167+TCYX9qNMrHk26IQO/pk+IC3zbsIlW7HCbbL8inOAjZcrghBa2
	p3xtpBvPY5gQPqL60JUv8LiMfdlQjV8T+Xlusb4au5Ioc0qDYQ2qLSGSGyk3Vya7
	UglVLEgWqlJ7eKxm474nIMTgI8u7HstK4Obq8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nU7mhNOKCbqWUjL/aHhYNsJ96XtL5kDz
	NZJwZOS+WY6PQz8MXfru4SW7M0tBnjxxPcoMUbjHe+B+/zZvz+yMvpW1Me2fAS2k
	frvlpiOcPCOsA6/qvT8MctdjeyI1a2FobkShTLCyrvcBbs87qbkAHdJVJNMjfV6E
	zj0DsiFmqDg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5BB3084906;
	Sat, 24 Oct 2009 18:08:59 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 412C784902; Sat, 24 Oct 2009
 18:08:54 -0400 (EDT)
In-Reply-To: <1256415640-10328-3-git-send-email-bernt@norang.ca> (Bernt
 Hansen's message of "Sat\, 24 Oct 2009 16\:20\:40 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D488E12C-C0E9-11DE-A328-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131181>

Bernt Hansen <bernt@norang.ca> writes:

> Msgcat is available since Tcl 8.1.  For really old versions of Tcl
> provide a default mc that just returns the text untranslated.  This
> allows the Tcl version check to return the error in a window instead
> of making Tcl abort when attempting to load the msgcat package.
>
> Signed-off-by: Bernt Hansen <bernt@norang.ca>
> ---
> I'm not sure if we care about Tcl versions older than 8.1 but this at
> least shows the error in the window with the [OK] button.

Both patches sound very sensible.
