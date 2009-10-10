From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] imap-send: remove useless uid code
Date: Fri, 09 Oct 2009 17:57:12 -0700
Message-ID: <7v63aof4lz.fsf@alter.siamese.dyndns.org>
References: <1255100682-13952-1-git-send-email-kusmabite@gmail.com>
 <fabb9a1e0910090821n67c86d0kb4eef1b9ff4bdff1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@googlemail.com>, git@vger.kernel.org,
	gitster@pobox.com, Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 10 03:02:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwQLe-0005GI-6y
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 03:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934736AbZJJA6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 20:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934734AbZJJA6I
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 20:58:08 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37888 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934731AbZJJA6H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 20:58:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E0FE752C1C;
	Fri,  9 Oct 2009 20:57:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=tvTP3Vun/7nF/oTdAHWnX8XPTCU=; b=wVz3F9IIUDWbrsW1xe7PQ5+
	DQDadtE/yQOzY8cqHSDB0bb8wEE3n8iyRdujQ7r0iWXcRGnvkpuZbubCKvdunK7z
	lLJha2qHhLw1TI1B608/QE6HvUdLpmGQc5mnIer++XDOkKAbeBH0nWhpxp49Ry7M
	dNQFyvUVp/7XaKi0bQ9M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=bZaQPySG4HoNyxcuWpI13WCu6+nfSisjsIcyFLX+EIbYRzEap
	sviyZz90Z1/JjOafu1Ytp3LyZvOr9zDv6EoflcttVqoM2JS5p8hwsrmrpqr51Wpe
	bmtA1Pd6QAKDukqXeDVbUY20OIZotGCF8JTAiU15NW710a90yYwdtr1mCk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C84152C18;
	Fri,  9 Oct 2009 20:57:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A329F52C11; Fri,  9 Oct
 2009 20:57:13 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DD2AF404-B537-11DE-A972-E80E3AD9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129861>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Please include a cover letter for series as long as these (anything
> larger than 4 should have a cover letter IMHO). Doing so makes it
> easier for those that follow the series to see what changed (assuming
> you write down what changed in the cover letter). Also, it makes it
> easier for those that were not following the series to drop in at the
> current version (assuming you provide a short summary of what the
> series is about in the cover letter)..

Thanks.
