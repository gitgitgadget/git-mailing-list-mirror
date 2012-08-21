From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fix git-svn for SVN 1.7
Date: Tue, 21 Aug 2012 14:34:24 -0700
Message-ID: <7vk3wsc4kf.fsf@alter.siamese.dyndns.org>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
 <20120802103122.GA24385@dcvr.yhbt.net> <20120802160753.GA17158@copier>
 <7vy5lxce9r.fsf@alter.siamese.dyndns.org>
 <7vehn0gaam.fsf@alter.siamese.dyndns.org>
 <20120821210352.GA13200@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	"Michael G. Schwern" <schwern@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Aug 21 23:34:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3w5p-0004S7-RD
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 23:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758611Ab2HUVe3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 17:34:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41151 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758588Ab2HUVe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 17:34:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDA638707;
	Tue, 21 Aug 2012 17:34:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W0HgqdoCfgaF0+Cp9POVqKSzfFA=; b=OIYF5E
	9+8qNjW0yfhV94hA3UlEJW+H22hL8RDvJ6uJLnN6+dqE03869zKpne5AMCFQEbZc
	ZrnMSVIS9yWp6cpwYKH14Zc/wmWANPX0Ar8+NsitTmbDDKtaV3oJhVkxDNagZ9dV
	G56xBm/Rete9Jd+W9HE3iu25CGcBOh4ZlPvOY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cTeCdWZWx4D2v9swiAyBbA4/VLymanO7
	iABW84kD8cd6LtZU8zGbSZ9j0XpWDPGtggazhI4apN21beHlk3G1pt6kWqNc02T5
	HR+XakuJma0tmv3WJpAIbLVg7itynKvEQD6xvhP+r9RAXCAbOG7uSC8y7pxRHI3S
	wO/Wb2mBfjc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA3158706;
	Tue, 21 Aug 2012 17:34:26 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 02B268705; Tue, 21 Aug 2012
 17:34:25 -0400 (EDT)
In-Reply-To: <20120821210352.GA13200@dcvr.yhbt.net> (Eric Wong's message of
 "Tue, 21 Aug 2012 21:03:52 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FB103914-EBD7-11E1-9099-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203991>

Eric Wong <normalperson@yhbt.net> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> Unless you found a reason not to in the meantime, that is.  Is what
>> I have on 'pu' still good, or do you (Eric and/or Michael) have any
>> updates you'd rather have me pull instead?
>
> No updates, everything is still good.

Thanks.
