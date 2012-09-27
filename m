From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/8] longest_ancestor_length(): explicitly filter list
 before loop
Date: Thu, 27 Sep 2012 15:48:52 -0700
Message-ID: <7vmx0bnktn.fsf@alter.siamese.dyndns.org>
References: <1348688090-13648-1-git-send-email-mhagger@alum.mit.edu>
 <1348688090-13648-5-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Sep 28 00:49:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THMtF-00087O-9Y
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 00:49:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756066Ab2I0Ws4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 18:48:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39574 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755394Ab2I0Wsz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 18:48:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD85A8AF7;
	Thu, 27 Sep 2012 18:48:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HMqMeNZFoA1JyNAPBpVIUvYA5ww=; b=FIb06a
	o5R2VPLqKcazpKXCwnQ9kO4djmY1pcsAEabED/36FRX2aqrl7mH6NJzdlp335aAL
	aCiv9QWMJUqKZ7LU52AlUSjDc7jQ+wwQgv4QnXOTN0k2kLxMNqgE5aJcSX4aaO52
	TcaUIqSZ+0/8JZVg8plzKzuPyIgTsR8gLG/aI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZPf9fAHmWsoXe9t74J0TZeNNMfPA3Ep7
	Ykur/sAaVqtUvjdKJQLEavu1EQR83YbScoVT2v0wMVkS3L0XK754H/LrlkgHQh4Z
	ewnnEE2EZhxc0nR5abI4pCDSQstKsJoaUokGS+Mo5BaeoENZqzTGHkc62RrcOIew
	J4KpBM7SVfY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABDC88AF5;
	Thu, 27 Sep 2012 18:48:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2D8358AF4; Thu, 27 Sep 2012
 18:48:54 -0400 (EDT)
In-Reply-To: <1348688090-13648-5-git-send-email-mhagger@alum.mit.edu>
 (Michael Haggerty's message of "Wed, 26 Sep 2012 21:34:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8392292A-08F5-11E2-87DD-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206527>

Makes sense.
