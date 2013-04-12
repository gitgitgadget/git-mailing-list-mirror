From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: distinguish between ref and offset deltas
 in pack-format
Date: Fri, 12 Apr 2013 09:15:39 -0700
Message-ID: <7v7gk7g1xw.fsf@alter.siamese.dyndns.org>
References: <1365746184-75910-1-git-send-email-ssaasen@atlassian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, s022018@student.dtu.dk
To: Stefan Saasen <ssaasen@atlassian.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 18:15:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQgdf-0007Q6-3j
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 18:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662Ab3DLQPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 12:15:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54352 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751864Ab3DLQPm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 12:15:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F03D13A7E;
	Fri, 12 Apr 2013 16:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=lcOJHN
	I3Wcu6EqQe7sqL524sP3aQfsadZLqJL6kv/sbuS8EvrVYlxjKRw5QvHmq00rh+G8
	rZsXNI9JFuzb8aeUM81lyMQE2y1EFqaf7ucArDpH/nFRFJRjz2n9ZkXwtcGNf2bo
	QU/A+xdwCBUbTB7FrrYKbV8ZXBhBtJ6tBDivM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hSIB+n1KwLn9L8phIe4ZvFIK5WB7RdDp
	FwcYmZN0063uIwX52a2GN+1AXlMYsRCDZ+dSnBsAm9EIs2S2rwKS4LyG+vYoIOUO
	weaoWyzWeSQvgmu4s49Qa1hdCU45soNpuUYhMA/F3j6u1x9wJnMwRvSi/aCnaUhO
	mVeIQiQ3qNo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 834A213A7D;
	Fri, 12 Apr 2013 16:15:41 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 09B6B13A7C; Fri, 12 Apr
 2013 16:15:40 +0000 (UTC)
In-Reply-To: <1365746184-75910-1-git-send-email-ssaasen@atlassian.com>
 (Stefan Saasen's message of "Fri, 12 Apr 2013 15:56:24 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3856EBDA-A38C-11E2-8212-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220995>

Thanks.
