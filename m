From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] help -i: properly error out if no info viewer can be
 found
Date: Wed, 28 Oct 2009 00:18:05 -0700
Message-ID: <7vskd4t2aa.fsf@alter.siamese.dyndns.org>
References: <20091027133134.28975.qmail@34dfe9cde77152.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Wed Oct 28 08:18:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N32nW-0007um-UC
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 08:18:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbZJ1HSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 03:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757536AbZJ1HSJ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 03:18:09 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47402 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757533AbZJ1HSI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 03:18:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3748069DD0;
	Wed, 28 Oct 2009 03:18:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=Rb+jNI/bIGNHM8gpA6daLKz
	eM1XTuN9GlYwwvSvbQx0SlyX8XTpRdXwdKk0BUoj5yb1FS9gRGxNRdVuFW27Re80
	q5hwmeex9DJokhUufBdA2OkFCH6yzHzEHjdrcVNdJXcDVJATHbAhmxMNb+GB/Atw
	SF+Ooiyh0UUzGyhfi79g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=j5A7D9EvcnHfRtVZXTBwJkKfyxNJ7lAkFVktLgm67qlU3doRF
	TRftexuB34PUyTQXUAWH52g85/laX69U8BaC9qul3ixgYgPQYt7swyfqWLazQYcl
	MIp/yyJOE4fXehC1g5mpuC9IZreSCjgMg4UNQAVukLwj3yqLEqfwj1qWxA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 13C5E69DCE;
	Wed, 28 Oct 2009 03:18:11 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5DDEE69DCC; Wed, 28 Oct
 2009 03:18:07 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0C879046-C392-11DE-9A45-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131417>

Thanks.
