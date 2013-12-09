From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 1/6] transport-helper: mismerge fix
Date: Mon, 09 Dec 2013 13:04:34 -0800
Message-ID: <xmqqzjo9wxb1.fsf@gitster.dls.corp.google.com>
References: <1386450492-22348-1-git-send-email-felipe.contreras@gmail.com>
	<1386450492-22348-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Richard Hansen <rhansen@bbn.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 09 22:04:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq80Q-0005vF-6H
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 22:04:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761520Ab3LIVEi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 16:04:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50377 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756037Ab3LIVEh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 16:04:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 026745939C;
	Mon,  9 Dec 2013 16:04:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N6Tfrelx97L/4ItOWuOBxBkO+x0=; b=vO4Iea
	YARN+W7L1Pyz61kcFPCJs2c+SCVX3r0W/u4nQ9fRhFY0+Q+yFNtVz3MfK2CLDthA
	n5o5bNdI5923ttsXGoC4rRzurw2X0c9xKkZAm/Omqs/W0GOl66koCl9pVme8wzOS
	GDj/y6xAzY9EWijGFfkuOfvFRs/y3GrKDYBvk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AKB9nawqUjEDkDIgTUSVDL7hJ31aN2+x
	wQP5coeZQNAt9r1benSqr2tw9+as53+JkgxdtZn7GTbCy/sZoMkQ31tB3OxHH8VA
	FHXPEI+zVu8tY3V9pT44tOOm/pdGZSv9pJO0jd18Lnk1Wn5Ir2e+teMTee9kXHlx
	JRgk9rL1MS4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D1DF85939B;
	Mon,  9 Dec 2013 16:04:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 10DD15939A;
	Mon,  9 Dec 2013 16:04:35 -0500 (EST)
In-Reply-To: <1386450492-22348-2-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Sat, 7 Dec 2013 15:08:07 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 825FC1A6-6115-11E3-B414-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239100>

Will re-queue these 6 for now.  Thanks.
