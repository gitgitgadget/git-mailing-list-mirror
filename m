From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] test: use test_i18ncmp when checking --stat output
Date: Mon, 12 Mar 2012 23:05:23 -0700
Message-ID: <7vvcm9kpcs.fsf@alter.siamese.dyndns.org>
References: <1328019840-6168-1-git-send-email-pclouds@gmail.com>
 <1328100907-20397-1-git-send-email-pclouds@gmail.com>
 <20120313045100.GA12474@burratino> <20120313045404.GA12550@burratino>
 <7vzkblkpkk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Frederik Schwarzer <schwarzerf@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 07:05:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7KrT-0007MZ-CI
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 07:05:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755642Ab2CMGF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 02:05:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65386 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752411Ab2CMGF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 02:05:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F21730F0;
	Tue, 13 Mar 2012 02:05:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2D6IFJQPpEj60TcLwne9bnrzKr8=; b=W9aYtw
	ThGi2FUjwnE74a33m6f8aFMALy4r6C68jFqlMGOxjoEtg/8bkUbqlJ5GZOyVyBgZ
	bUZMYiYtGffcOu5n4yDRnQ7fwKQIUcODcQjQZ9u2ltFrogR6gWJViS/H68oj54qS
	gxwI0IAzcexC5mteaoaCZk53NatTIn25e+7zI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SQl22FPl9bHIcACTRxjr5mCHba2vEMdp
	QUcUerkz1s6JYA52CyahxaDYqFyxDfwIgxEB6xngFqOoQaQd6hGiUap7c2z7Ah5q
	z+TQUCW8GukOMhEWseKSemYkHmE6wWBeQCc8NRGqV7dYPuNXRk9eYkQXmWvo+SKW
	RXPtboWXg8w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25EDD30EF;
	Tue, 13 Mar 2012 02:05:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7E64030ED; Tue, 13 Mar 2012
 02:05:25 -0400 (EDT)
In-Reply-To: <7vzkblkpkk.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 12 Mar 2012 23:00:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 869E9A32-6CD2-11E1-B5D9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192982>

Junio C Hamano <gitster@pobox.com> writes:

> But I do not think the progress output from range cherry-pick needs
> to be cast in stone even in C locale, hence the comments in the
> first two paragraphs from me.

Ahh, I spoke too early before reading them through.  You do touch
them later in the series.

Sorry for the noise, and thanks.
