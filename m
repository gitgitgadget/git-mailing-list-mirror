From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] rebase: command "ref" and options
 --rewrite-{refs,heads,tags}
Date: Mon, 27 Jun 2011 14:23:17 -0700
Message-ID: <7vtybbufy2.fsf@alter.siamese.dyndns.org>
References: <cover.1309133817.git.greg@quora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Greg Price <greg@quora.com>
X-From: git-owner@vger.kernel.org Mon Jun 27 23:26:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbJJq-0002Oj-OZ
	for gcvg-git-2@lo.gmane.org; Mon, 27 Jun 2011 23:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754700Ab1F0VY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jun 2011 17:24:56 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48186 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754729Ab1F0VXT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2011 17:23:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A9E475CC3;
	Mon, 27 Jun 2011 17:25:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JjT0MhVJw6AkYrKl0oQ+Xpr67VY=; b=c+PsAb
	Ql73q8v4vl+PqI7F36gETyW5GkD73UwWV5qSu44o0Ii0QNtFdIkjTbkhVSPz8vBK
	gW/V4/r4tzyDAj6CpMkoqcU036yu99z4T5sUzvjPCYGBH38o9pWVZoX7llbN+2Z8
	XUf/f/oNE7q9+dgLe0jtHRlpBnEWbAANSavDg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uWlNyHJu4DtYsc8lkrKYwUaRVmtN0PQF
	rkJpXf8yYwqGNepCqCaFY5zXu2JqBPt+j3QMVBAk0aubU7BzMXNTquW2Kk5t+Ivi
	3OtajKLKImLHw5k+fetg36lNNIFr21oQT6KjAlVqjoWuh5Pwf+N3WICw5lMXA8jo
	/Hn9Wit3pbo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A31005CC2;
	Mon, 27 Jun 2011 17:25:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 09F775CC1; Mon, 27 Jun 2011
 17:25:31 -0400 (EDT)
In-Reply-To: <cover.1309133817.git.greg@quora.com> (Greg Price's message of
 "Sun, 26 Jun 2011 17:16:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FCDE23E8-A103-11E0-AE7E-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176371>

Have you ran all tests with the changes in this series, especially the
ones in t34xx series?
