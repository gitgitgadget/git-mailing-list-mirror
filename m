From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] git-shortlog: respect i18n.logOutputEncoding config
 setting
Date: Sun, 22 Mar 2009 12:26:58 -0700
Message-ID: <7v7i2h5pfh.fsf@gitster.siamese.dyndns.org>
References: <1235092358-6895-1-git-send-email-vmiklos@frugalware.org>
 <20090322113438.GK27459@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Mar 22 20:29:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlTLp-00012W-KL
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 20:28:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756056AbZCVT1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 15:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756013AbZCVT1M
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 15:27:12 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41303 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756034AbZCVT1L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 15:27:11 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C881D82BA;
	Sun, 22 Mar 2009 15:27:07 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3FAA182B9; Sun,
 22 Mar 2009 15:27:05 -0400 (EDT)
In-Reply-To: <20090322113438.GK27459@genesis.frugalware.org> (Miklos Vajna's
 message of "Sun, 22 Mar 2009 12:34:38 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6ECA0F04-1717-11DE-8D3C-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114167>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Fri, Feb 20, 2009 at 02:12:38AM +0100, Miklos Vajna <vmiklos@frugalware.org> wrote:
>> As git-shortlog can be used as a filter as well, we do not really have
>> the encoding info to do a reencode_string(), but in case
>> i18n.logOutputEncoding is set, we can try to convert to the given value
>> from utf-8.

It is unclear what you want to say in these for lines.  Do you mean "when
used to generate logs by itself this patch improves the behaviour by
making the output consistent with what "git log" does, but it does the
same mangling when used as a filter without knowing the log encoding and
potentially screw people over who have been depending on it not to convert
the encoding"?  Or something else?
