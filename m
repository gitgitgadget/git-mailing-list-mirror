From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 1/5] patch-id: make it stable against hunk reordering
Date: Tue, 29 Apr 2014 14:45:18 -0700
Message-ID: <xmqqr44fizdd.fsf@gitster.dls.corp.google.com>
References: <1398622524-26207-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com, jrnieder@gmail.com,
	peff@peff.net
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 23:45:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfFqA-00086l-3Y
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 23:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933009AbaD2VpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 17:45:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34024 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932885AbaD2VpW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 17:45:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B28E07FF00;
	Tue, 29 Apr 2014 17:45:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G4GR+ZDwjUP6mt7ZKTpf3JlSpL8=; b=AL8jaC
	osNEfnmrq8YWBzBPzW04hFG58MfbiULQ/HTY61TBW4ZJ4e37TiQFtcJMKRvAwzrX
	s/cFTH+QK+ZG9IxYLdzotPOUtBZ3P+kP2Wy/6xgA5ANRHk/zhXCtN69yfdJxpxd+
	+A6R9OKpBRel5GErp7ixi8Bf78aQ0xhf4IOZw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xOyjDVXEgAY4wGGedJM4QIRReF9bOtgX
	7hYTKlQmSx6tYjHeGEzf0V67GI/evWn96FoRwU8Iz/qOmr49qr2hxNn7nKdsNErI
	F10i4e0sJ6Xq4G6u1XUfYK5wi5gQqJFb2GQuEP9nJpbM+VvBNqNlz5ITB0rjUqQe
	//ZMzzLzyss=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9951F7FEFF;
	Tue, 29 Apr 2014 17:45:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B1A167FEFD;
	Tue, 29 Apr 2014 17:45:19 -0400 (EDT)
In-Reply-To: <1398622524-26207-1-git-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Sun, 27 Apr 2014 21:15:44 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8F2AB4A4-CFE7-11E3-98FF-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247613>

Thanks.

I'll revert the merge of the previous round to 'next' and then queue
this series instead.
