From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] difftool: only copy back files modified during
 directory diff
Date: Thu, 19 Jul 2012 10:34:09 -0700
Message-ID: <7v394nveni.fsf@alter.siamese.dyndns.org>
References: <CAJDDKr4Q+nQapO0aAQmmpj_guR=_tXwareWsn020BckZR5V+uA@mail.gmail.com>
 <1342686429-87847-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 19:34:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrucI-0000cV-OK
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 19:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566Ab2GSReO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 13:34:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61330 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752436Ab2GSReL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2012 13:34:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3003E7B6A;
	Thu, 19 Jul 2012 13:34:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ef8tdsr/tUkxXbzVt+HLImtNbzk=; b=PX5zE9
	YpNtLZm34Ykt/r5A7jgKYt2KkdMC4AaV+kNkRqA8nI/mRwvNnyQoHBzfZSkNzbgH
	BSNRr/I3s5iBUc0SwWz9uJjrKiXmXu0H8vVGMoZTsmXh+z4cePHxDyuqpYrjl4m6
	5gGiMV0qz9T/7t/LqZOWNVnPY7MTjM9HGsbog=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LXlqop06VzUNQPil5CZBPoEok+sfRk4d
	7B1/bncW2dRSmM6cH30TzawsVWg5rUYWIkO0eygrlstnAiPjZHtNKyU3dm89sQga
	xtob8G3RMaS68BW02qij2IigFyBregc8X6UbVfMZE9UA9XaJHjUj2HtI1mtEbu2f
	Xykad5x4/+Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1ED177B5F;
	Thu, 19 Jul 2012 13:34:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96E397B5E; Thu, 19 Jul 2012
 13:34:10 -0400 (EDT)
In-Reply-To: <1342686429-87847-1-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Thu, 19 Jul 2012 01:27:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F32BD2BE-D1C7-11E1-95FB-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201747>

David Aguilar <davvid@gmail.com> writes:

> Perhaps something like this...

Yeah, like that ;-).
