From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/16] use a lowercase "usage:" string
Date: Sun, 24 Feb 2013 13:45:26 -0800
Message-ID: <7vobf94c95.fsf@alter.siamese.dyndns.org>
References: <1361667024-49776-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 22:46:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9jOS-0007k3-5j
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 22:46:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755769Ab3BXVp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 16:45:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48746 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751015Ab3BXVp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2013 16:45:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E21DBEF3;
	Sun, 24 Feb 2013 16:45:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jQ3PNk9rjNeaF12NdRarYK/LHqc=; b=T9DL0Y
	Z9XyK/DBIJmZNXu8SPah6M5HeaVPfwg2tXInaevtbpKBCKHEuXZsIY7VAXOzhIsb
	aJcQdnDY4J34I8Z9hCuHKqxXNN7bt7zkJOYx2PMTzj/f4dmAMs3BFjDrdJaTkzQ/
	YO8Y4xHpogSEf2JChNzM8n05aESe12eysSkP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I0QGHom5lW94/In8rhcgiVF756gjhowy
	5CUBIU5+0Cz2uSQiNf+3FQ8NjDZxCF11YmVn9nrPC29Hr/WYx5neddHEj6wXTNtl
	qxywFZaYpzkFc0REhx0AwQy2iyWFgUwxhWReWadiS1cGVN7SK7NqrCyjhfZYmVJ2
	wSgS83+CJe0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61125BEEE;
	Sun, 24 Feb 2013 16:45:28 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D558BBEE5; Sun, 24 Feb 2013
 16:45:27 -0500 (EST)
In-Reply-To: <1361667024-49776-1-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Sat, 23 Feb 2013 16:50:08 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 80CB932E-7ECB-11E2-9653-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217003>

Thanks.

After applying these patches, "git grep '^[^#]*Usage:'" still shows
a handful more hits, such as contrib/examples/git-remote.perl that
are touched by this series.
