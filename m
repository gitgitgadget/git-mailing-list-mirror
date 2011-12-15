From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add '-P' as a synonym for '--no-pager' in the git
 command
Date: Thu, 15 Dec 2011 13:41:37 -0800
Message-ID: <7vhb11ms1a.fsf@alter.siamese.dyndns.org>
References: <1323982541-18995-1-git-send-email-jratt0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joe Ratterman <jratt0@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 15 22:41:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbJ3g-0006yX-83
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 22:41:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759505Ab1LOVlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 16:41:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42087 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754146Ab1LOVlj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 16:41:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F79B65B7;
	Thu, 15 Dec 2011 16:41:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WSQDtw2uOynzl0/eca1lUK++OsU=; b=yXtgGp
	LUUu5uginXULwcRt4/saKva4HSXCl1mo2Urowtt17b/PFtPDRn8g2NVJZ/6mWzKT
	IbK8wsMVbnQPLfOEtaTi8giMHZKkRbDBQAg5BuPlBHYyVcuwI6zcY6F7r7Cj4Y1x
	bJcVTT/qUZOIWNN2xy+v/EH4yjRB4ZXwyecOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BvSXNAXVgf1Xg+o/6lPUcCL20Cpkit8q
	OmKELtHwAdjRL95gX6H12NvkcmDQ2Pc/2gI6d2APW8zhZq84iZL+LKRGW3u8kf/M
	N5p4XTTHD14MYq7pVf9KlL9E5rZ1Gm1w8pVS4HM9pXr3h6MrWPKKjZRiDK+hC0Lw
	K5gIEzlErck=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3609265B6;
	Thu, 15 Dec 2011 16:41:39 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9E1E765B4; Thu, 15 Dec 2011
 16:41:38 -0500 (EST)
In-Reply-To: <1323982541-18995-1-git-send-email-jratt0@gmail.com> (Joe
 Ratterman's message of "Thu, 15 Dec 2011 14:55:41 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 91A60008-2765-11E1-977D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187241>

Sorry, but why was I listed on the To: line?

I do not recall there was a list concensus that this is a must-have or
even good-to-have, and I am not personally interested in this. I hesitate
to accept a patch that lets a feature without clear advantage squat on a
short-and-sweet single-letter option, generally speaking.
