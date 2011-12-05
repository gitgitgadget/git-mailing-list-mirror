From: Junio C Hamano <gitster@pobox.com>
Subject: Roadmap for 1.7.9
Date: Mon, 05 Dec 2011 12:07:57 -0800
Message-ID: <7vd3c2lr36.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 05 21:08:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXepd-0005DM-B7
	for gcvg-git-2@lo.gmane.org; Mon, 05 Dec 2011 21:08:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756158Ab1LEUIB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Dec 2011 15:08:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39476 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756163Ab1LEUIA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2011 15:08:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C20535208;
	Mon,  5 Dec 2011 15:07:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=i
	6Le6Ldy1OZ5kuOhokj18hFIths=; b=v6RUbviQigddmVoHAoxEx9xebAiYkO5KT
	lVKayuhPDIYW2DOh8mL5X3EHq4NkK6KNgVwAMW9JCAC99JCREISM5AdgjdF3Yz/1
	WKyx+xe4h4U64zZp6Nor3bwl7SYCOFbV9ReeMI+gd5bDEYwBs1RLs6MqAnQxLUhh
	JmIxIUN5bY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=ZOo
	e702ZCuKbhYM7tAB322TA6zqrxPqa7zrz6D9O5RUHuBSiYqj0uMa9aCSRLZoHD+D
	qskWSmgz5CMGL0WdyIPvqPifM1uUnQev4tagYXT/nTcIokX+omvsEOT6k9ozCW7I
	y2tMO04MoGEfQupnjdCZ9PsQZb9mifb5n+LkmXn8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B94825207;
	Mon,  5 Dec 2011 15:07:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4AB675206; Mon,  5 Dec 2011
 15:07:59 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D4211E36-1F7C-11E1-B1E0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186288>

I do not do roadmaps, so the title of this message is not quite correct,
but I think I should post my current thinking on what have been cooking so
far that deserve to be polished further to be in the next release.

I've been aiming for a release cycle that lasts for 8 to 10 weeks, and the
last 2 or 3 weeks of a cycle is meant for release candidate testing that
we fix only regressions, which means we need to see how much we can do
within 5 to 8 weeks. The current cycle is expected to end at the end of
January next month [*1*].

I am not so worried about small and obvious fixes and enhancements, and
changes in the periphery areas. They can and will be merged as they come
and cook long enough in 'next' without issues reported by their users. I
expect what have been cooking in 'next' during the feature-freeze before
the 1.7.8 release, other than the ones listed below, to be more or less
ready already and they should be in 'master' shortly.

Now, here are the biggies that we would want to try to have in reasonable
shape before the next release. The list may be a bit too ambitious, given
that this cycle overlaps with end-of-this-year/beginning-of-new-year
holiday season in various cultures.

 * Credentials and keychain (Peff)
 * Pulling signed tag (me, Linus)
 * Update "request-pull" script with information that matters (me)
 * Revisiting threading of grep (Rene, Thomas Rast)
 * Optimization of reading hierarchical refspace lazily (Michael Haggerty)

I expect the following will not make much progress without further
discussion:

 * Signed commit (me)
 * Ignored vs Precious (Nguyen Thai Ngoc Duy)
 * Sequencer (Ram, Jonathan Nieder)

I think the following are too big to be ready by the end of this cycle
(polishing could and will continue as time permits).

 * Large-files
  - bulk check-in (me)
  - "Chunked" encoding of large files (me)


[Reference]

*1* https://www.google.com/calendar/embed?src=jfgbl2mrlipp4pb6ieih0qr3so%40group.calendar.google.com&ctz=America/Los_Angeles
