From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] i18n: add infrastructure for translating Git with
 gettext
Date: Thu, 17 Nov 2011 15:17:47 -0800
Message-ID: <7v39dmmj8k.fsf@alter.siamese.dyndns.org>
References: <1320970164-31694-1-git-send-email-avarab@gmail.com>
 <1320970164-31694-2-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 18 00:17:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRBDT-0002GG-Fg
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 00:17:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634Ab1KQXRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Nov 2011 18:17:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44922 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752576Ab1KQXRy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 18:17:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2F346DD1;
	Thu, 17 Nov 2011 18:17:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eA+BASrJ29WklBz5TKNqdqhNEhE=; b=hMbU5W
	dPI2sg+1mmINOp7OLkKGCrVceely4I8wbufIQwMas846nq7wO8xF8nnuUrczagT6
	MA1v5D5CLyBG5YdGtwt31pO28R44Hwhz+isr43G7anLyCSlLLQ85wr/YsTUchEBA
	Jzy+nNg6uTYqQlX7V1AJjNcW2jIDJnAbx5QbE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PrhxsjxpakH6pZfXc+ybCNhH3n1r0vzo
	XWYWdqyZBQXtgoA+yKwghwu9YLV4ERmqRkri+ZMIOM6AJ462v0K2vLmgG7B02R1N
	uGyyLEFOEx01nsUUgoYzPRItr9bC3BYKjqCDWM0fVTFK++90H1tJxcJ0MCZ0qmN3
	jbgclduQ2YM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAF866DD0;
	Thu, 17 Nov 2011 18:17:53 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB9006DCB; Thu, 17 Nov 2011
 18:17:49 -0500 (EST)
In-Reply-To: <1320970164-31694-2-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 11 Nov
 2011 01:09:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5E0E14BE-1172-11E1-B3B1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185612>

Just an extremely minor issue, but a few things seem to seep through the
"make V=''" build:

    SUBDIR perl
/usr/bin/perl -pe "s<\Q++LOCALEDIR++\E><.../share/locale>" <Git/I18N.pm >blib/lib/Git/I18N.pm
/usr/bin/perl -pe "s<\Q++LOCALEDIR++\E><.../share/locale>" <Git.pm >blib/lib/Git.pm
Manifying blib/man3/Git::I18N.3pm
Manifying blib/man3/Git.3pm
    SUBDIR git_remote_helpers
