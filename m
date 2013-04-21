From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/1] git-multimail: a replacement for post-receive-email
Date: Sun, 21 Apr 2013 11:44:46 -0700
Message-ID: <7vhaizu3j5.fsf@alter.siamese.dyndns.org>
References: <1366541380-10786-1-git-send-email-mhagger@alum.mit.edu>
	<20130421105612.GA28959@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Chris Hiestand <chrishiestand@gmail.com>,
	Marc Branchaud <mbranchaud@xiplink.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michiel Holtkamp <git@elfstone.nl>,
	Stefan =?utf-8?Q?N=C3=A4we?= <stefan.naewe@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 20:44:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTzFu-0001uN-VK
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 20:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754018Ab3DUSov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 14:44:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60512 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753943Ab3DUSou (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 14:44:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E462C16CD5;
	Sun, 21 Apr 2013 18:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BDb9F7OslWsGcMIns5BEOit8b3o=; b=e/Rra5
	tJ3E/LkQl3XQSMUaSbhHQJ5TN4O9BtQqisaIRyS61RC8lFR18hJFdaXRxRxHl7p0
	Olq8j/mBU778rit2SiD4QQcWFp2w85vTFwRZYGb92PqO14uU1Z8OF8j/3Cd2FZXM
	mZhxmqhWLI3xJbE/rVfC/HbgfrDylSM//itRo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mNJ2XHr+qy+Bau+0hbCDXtoNfytCiuUW
	9wJidJX7VvBxdJrFgOur+hsER2/zRJjMMsHnjiIuWKf5sh26d/xq48RK1Myzls/0
	Xiq8f2X1AH/VZRkxrM7DuQTZLnzgJWiqJzqRUg8GyQHc6/Jwlrfz0JoUvjyBgvXW
	IQgvlbx9O1E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D662716CD4;
	Sun, 21 Apr 2013 18:44:48 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4532916CD2;
	Sun, 21 Apr 2013 18:44:48 +0000 (UTC)
In-Reply-To: <20130421105612.GA28959@elie.Belkin> (Jonathan Nieder's message
	of "Sun, 21 Apr 2013 03:56:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8B1479AE-AAB3-11E2-9F8F-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221962>

Jonathan Nieder <jrnieder@gmail.com> writes:

> My personal preference is that patches come on the git list, are
> reviewed here, and then go to your fork of the Git project that Junio
> can periodically pull from at your request (like git-svn).  But of
> course this is up to you, too.

And also me ;-)

Yes, I very much prefer the way how git-svn is managed.
