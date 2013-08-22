From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t3010 broken by 2eac2a4
Date: Thu, 22 Aug 2013 16:12:39 -0700
Message-ID: <xmqqwqndpbfc.fsf@gitster.dls.corp.google.com>
References: <82078845-3AB9-4B36-9130-039CC33C8A7A@gernhardtsoftware.com>
	<xmqqbo4qu3g4.fsf@gitster.dls.corp.google.com>
	<CAPig+cQHTvmTWvGfg1Z3KfBrPD+QbSEbYBYz6XWT3KKu3-+jyQ@mail.gmail.com>
	<xmqqbo4pqvde.fsf@gitster.dls.corp.google.com>
	<CAPig+cQmvRDDc3BHbta_UhCQe9QvbtAm0RJgt6HbtgFAKgo0Vg@mail.gmail.com>
	<xmqq7gfdqumd.fsf@gitster.dls.corp.google.com>
	<CAPig+cSEQLk2M+X5QP7mkm846wqqHRCjPHgO7O3URvNcsYO6+w@mail.gmail.com>
	<xmqq38q1qu3l.fsf@gitster.dls.corp.google.com>
	<CAPig+cSgM-kO0Mk9qbGfLR8DZkYQt60Va4N2wfRBVqmReTPowQ@mail.gmail.com>
	<CAPig+cQ15Qq7pJ0sLmnuQt_EERn9fkzCa-Gr-pb6a_zf1MLcGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	"git\@vger.kernel.org List" <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Aug 23 01:12:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCe3e-0006AL-27
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 01:12:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754543Ab3HVXMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Aug 2013 19:12:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57641 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754085Ab3HVXMp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Aug 2013 19:12:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96AB53B3A2;
	Thu, 22 Aug 2013 23:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O0GF6X/umlrbmbJl4uL1NMGqYWw=; b=spIfss
	lukvIDDEFL6+/CP83/tECQReG0yUqI2W3rOcUu167tIAmEiXgMnwNJovk1frlD1j
	hmJ8AbUWY9OiDvkJIQk8r03laA9YGQEX8YttLPNzZ8pkL8Q0yVbtBw/N1/+M8+oZ
	qAqZ7H3MfX7odEBZXuzytgXFMyivDQBq3ndOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ffcy70dsUiQgyUbS0k7S90smw29Vwq2x
	CjbOplgyZnfFMBWx2uyA4/r9udktF2HPcjgDqtEYTfizEp8op9VsIbpNgjWWC7RE
	kYBRX+UZHN8FmOAk/f6qmf/xl1yGflay0tlc7I3jqthRyQP7WvWqcMqnuLHklR6S
	P5TwmEBg8MQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8533C3B3A0;
	Thu, 22 Aug 2013 23:12:44 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B4A413B39B;
	Thu, 22 Aug 2013 23:12:42 +0000 (UTC)
In-Reply-To: <CAPig+cQ15Qq7pJ0sLmnuQt_EERn9fkzCa-Gr-pb6a_zf1MLcGQ@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 22 Aug 2013 18:53:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 58F62872-0B80-11E3-9047-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232786>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Status update: For the 'pathx' directory created by the t3010 test,
> directory_exists_in_index() returns false on OSX, but true is returned
> on Linux.

Because a regular pathx/ju is in the index at that point, the
correct answer directory_exists_in_index() should give for 'pathx'
is "index_directory", not "index_nonexistent", I think.
