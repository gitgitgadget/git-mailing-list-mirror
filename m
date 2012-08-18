From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v4 01/16] GSOC remote-svn
Date: Fri, 17 Aug 2012 21:16:59 -0700
Message-ID: <7v4no0u950.fsf@alter.siamese.dyndns.org>
References: <1345235157-702-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 18 06:17:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2aTv-0003za-U2
	for gcvg-git-2@plane.gmane.org; Sat, 18 Aug 2012 06:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342Ab2HRERF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Aug 2012 00:17:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38991 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751207Ab2HRERD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2012 00:17:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB2CF9735;
	Sat, 18 Aug 2012 00:17:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=lnoNP5n5u9vI3sZbhTM1D4RCn9k=; b=i3kjpPWNXFwDAFjRQ4pj
	3nCANOUpWOHmgXjdG4Y4j6DnQGTKP+UFWwen1piI4VgoxPy784izmN7LTghCKDsC
	HMbS+NqBYW4wfjcgMGBqPp7QeQ0daLyv1LhOL6i5BDLnY1jgrPfJrLRQ1xUSYNXM
	oJlCh5qrHWOasJM82gXs4Vw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=XzNMLi7jpBeuQcSNHdEVSVDzbpbPkqiAGpX2OFkyHa+zZD
	QhIsL1LTJIng5yylvb/Mads0lXofO9r6W60KBTWmgRbq+sz5t4T+Toie7GoLflL8
	aw1ZeZtFvHvUzqKPQhVDiWekh3ecYm5Q4JBg2ZbXtDz6zgcmI/mSq0iP6rCh4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7B2C9734;
	Sat, 18 Aug 2012 00:17:01 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D94F99733; Sat, 18 Aug 2012
 00:17:00 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8ED32700-E8EB-11E1-80CE-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203669>

Comments from mentors and people interested in remote helpers?

I did minimum line wrapping, typofix and small compilation fixes
and queued these on 'pu'; I think I saw one commit whose message
I didn't quite get what it was trying to say, and another that was
missing S-o-b (I left them untouched).

The result merged to 'pu' seems to fail 9020, by the way.

Thanks.
