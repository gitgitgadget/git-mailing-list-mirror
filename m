From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/3] Make update refs more atomic
Date: Mon, 14 Apr 2014 13:24:18 -0700
Message-ID: <xmqqeh0zoe19.fsf@gitster.dls.corp.google.com>
References: <1397500163-7617-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 22:24:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZnQY-000559-9B
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 22:24:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbaDNUYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 16:24:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57867 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751519AbaDNUYW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2014 16:24:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BEC877D777;
	Mon, 14 Apr 2014 16:24:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z39PFn5dW5Nhrrj2YjeNAi8IYAE=; b=dvfzg2
	QjzqWXp+Z+eBCB5hIEj3ZOvORN5vsGXKANAhD1qkkc5VFkMHNptdFt7SIPkt5UtA
	AfaNWcuemBPJhKaBjBQWu7xNVU4oe3jBXpwmJoVj9LmzEQlr6gXo31dgxlwz/jrH
	tolJouVgllnZP7W/fumnH2puUn2iKeiTRTcqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MwYW+roRpZdrz0cjAMpHmAyXzelFr/dm
	5vzyx6R5vh2p0SGY1FRkrdrKczmPmY0dQAqe4CvBGQc+DwKpTW2vFQ1AKDXQOvs0
	I9GnsNq7WdgUwkBeYxHKoU6OKiNWZ9ytKUGDPVGYxUkaQgAUgPuIuzonSWy1XT5c
	LYCYwqKRS7A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2BD37D776;
	Mon, 14 Apr 2014 16:24:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 649EC7D774;
	Mon, 14 Apr 2014 16:24:20 -0400 (EDT)
In-Reply-To: <1397500163-7617-1-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Mon, 14 Apr 2014 11:29:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C295C292-C412-11E3-B591-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246262>

Thanks; will queue.
