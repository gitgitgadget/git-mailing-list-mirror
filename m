From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why doesn't git commit -a track new files
Date: Fri, 25 Feb 2011 09:00:25 -0800
Message-ID: <7v8vx4camu.fsf@alter.siamese.dyndns.org>
References: <20110224112246.3f811ac2@glyph>
 <7v7hcp2vi6.fsf@alter.siamese.dyndns.org> <20110224194514.2ca47772@glyph>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marco <netuse@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 18:00:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pt11z-00080N-1V
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 18:00:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486Ab1BYRAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 12:00:34 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47172 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755767Ab1BYRAd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Feb 2011 12:00:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 49804379C;
	Fri, 25 Feb 2011 12:01:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/kQef/nfQ4WWoU7mOTSxwqBdwao=; b=sPRy8J
	cu7vcUvqtLV0p7SSWppedd9c7O5WzPigS8wBIcBeym5RMroBThLEwjT41PKcg5bU
	BnWuid/E2iWjATxk82tw0esH/fKNrHJ4xT3/qghL/Pzwp9T7uij19kmJ4Cv6ku/X
	UE7Jd8Kzueyoi29ydRgh+Nog2bXYBOOy0N7v0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AqhwbAnCN8nCkEIQ5xB1dJhsaTbEgyrR
	90sQPn7/Dla1v5gtQ36v2LC+DOCohJc6pFgGm/2ALtFZiazoJRhagaRecy8bs4qP
	QixVgHSqENYWbraHi3WuK4Y4mNt7Vo6Tk2YtbKFHyRk6V0VK5AYsuv0wSxOu5dth
	bdCqjXcrHG0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 24A7C379B;
	Fri, 25 Feb 2011 12:01:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3FBAE3798; Fri, 25 Feb 2011
 12:01:40 -0500 (EST)
In-Reply-To: <20110224194514.2ca47772@glyph> (Marco's message of "Thu\, 24
 Feb 2011 19\:45\:14 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EC48DD7E-4100-11E0-9975-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167914>

Marco <netuse@lavabit.com> writes:

> To sum this up: -A would be a nice-to-have feature but it's not necessary to
> implement since we have add -A. But if I'm willing to implement it myself I'm
> free to do that.

"It's not necessary to implement since we have add -A" is not what I said.
"I've shown the way long time ago, but that hasn't happened yet" was.

Luckily, it seems that it is changing now ;-).
