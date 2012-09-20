From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv8] clone --single: limit the fetch refspec to fetched
 branch
Date: Thu, 20 Sep 2012 14:17:03 -0700
Message-ID: <7v8vc49yy8.fsf@alter.siamese.dyndns.org>
References: <7vzk4legrz.fsf@alter.siamese.dyndns.org>
 <1348164248-18756-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 23:17:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEo7Z-0001p4-CS
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 23:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755376Ab2ITVRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 17:17:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40010 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753700Ab2ITVRG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 17:17:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA0C886F6;
	Thu, 20 Sep 2012 17:17:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=ydPNBH
	ZH13wi+OOnArINGJRILAuofuj7pnDy5qF3sUofTs1+rfVsUx5kbAM1cFVbgNsKDg
	3pyucq4FAK2xZIi4AAEOEt0pkCFH8nHIHMPiZT+NB2U4ef9q56R85IqpIdvOjTZg
	kOzsKCyFSYtuL1l1sKpNb/UJTiT3I9GeOuZwM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QfIEt5/kO/Rgf4NcHekL/RfFvFQLMixd
	RaeC0VYuRWWRYeJoR5BkDv7ROOHY/5ZvWcoNR/zhRh8YqCeDHIZAh9EKblb7UC89
	0ZhpLZeZCVxuzAdQW1Iy80RHP9RYdfKkqriAI9Z7z+RqYMtgYSr9Phphrf9oMpTG
	6exAe0wHGj0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D743186F5;
	Thu, 20 Sep 2012 17:17:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F54886F3; Thu, 20 Sep 2012
 17:17:05 -0400 (EDT)
In-Reply-To: <1348164248-18756-1-git-send-email-ralf.thielow@gmail.com> (Ralf
 Thielow's message of "Thu, 20 Sep 2012 20:04:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 872451FE-0368-11E2-90EB-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206094>

Thanks.
