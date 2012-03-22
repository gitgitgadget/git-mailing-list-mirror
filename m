From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Isolate If-Modified-Since handling in gitweb
Date: Thu, 22 Mar 2012 10:00:00 -0700
Message-ID: <7vy5qsy3jj.fsf@alter.siamese.dyndns.org>
References: <7v62dy4zhf.fsf@alter.siamese.dyndns.org>
 <m3sjh2ay6j.fsf@localhost.localdomain>
 <7v1uol3m5m.fsf@alter.siamese.dyndns.org>
 <201203221346.35295.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@drexel.edu>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 18:00:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAlN2-0005cZ-PW
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 18:00:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031034Ab2CVRAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 13:00:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51793 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031031Ab2CVRAF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 13:00:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6408B659D;
	Thu, 22 Mar 2012 13:00:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tsfleosX7EIIgex2CB+oh1QG9rU=; b=w5cE6D
	vtVklLbhx0qFsng8qxzceDgs3r+iIjIDDJ5+1a7elz1WhfhSaVNdbePaH/uVMiPR
	mVSwm3d1flMmA9sRiR5bgLoB5OYyFkor+G/hh2fBArhaWtvwadFfem1YwFrwtCUv
	C6YA7BoZpAs8Q3VaCM4OI0LEjywICP+N3itq4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MubgtZmOuhQYZM+Cj7bQ4QRfroPKYRdV
	SFLe0nm6KcPqSNu6R8R5of3nF8OHwhmYaNOgxan/MZ8o0Th9fXfOV8SSdlyZgBIz
	VYzkjNWopC5OpoSTCjwRVXJehjW1AX+ww0aCZQY5orY7XiPs+4+NluLlkBKiXCat
	5ccDtaDGxcc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56321659C;
	Thu, 22 Mar 2012 13:00:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E2C216598; Thu, 22 Mar 2012
 13:00:01 -0400 (EDT)
In-Reply-To: <201203221346.35295.jnareb@gmail.com> (Jakub Narebski's message
 of "Thu, 22 Mar 2012 13:46:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 76E6ED72-7440-11E1-8BA3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193667>

Jakub Narebski <jnareb@gmail.com> writes:

> tl;dr.  Two commits.

OK, thanks.
