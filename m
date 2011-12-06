From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] Add test-scrap-cache-tree
Date: Tue, 06 Dec 2011 14:51:53 -0800
Message-ID: <7vfwgxe2k6.fsf@alter.siamese.dyndns.org>
References: <cover.1323191497.git.trast@student.ethz.ch>
 <534454506f92428863de8fe0638f4129e962a073.1323191497.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Dec 06 23:52:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY3rk-00083R-M0
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 23:52:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243Ab1LFWv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 17:51:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62449 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988Ab1LFWvz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 17:51:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DA01674C;
	Tue,  6 Dec 2011 17:51:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3+fWbuXdD+/65iSURAyS0GPcnKg=; b=rNArun
	iNJjEZwhAnzR/V8Fxw5N6Rjei8YVQqxn46exUgK1Gkcrj+QQxP51wr0No/H7lS1f
	FLs7wnjbvnX/JLyLpXJmWRqrYNMIugq+1B7VGYSSSbJxtC/Rj29kqzMYb2m82aWS
	8YmJU1Z8sT6VNsCeJD8e74WPjyqmDv1kC6bMU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MtOLyCoM3OWe1yHqnkmMm/A8PTugg+ca
	5v8oPr0sIqJ0Y1ookUvEUIZIi2MfX7tzx5aqvpk1ynp0Jshv2t2OWqam3+JGX9aY
	u539xvpXz7KWB8JILrIH3PSCOqQVrmPJzIRz/XFSVsvthwe/zn6wy6C4ljvFStht
	gmK8iMhYVZc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54EA3674B;
	Tue,  6 Dec 2011 17:51:55 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA4376747; Tue,  6 Dec 2011
 17:51:54 -0500 (EST)
In-Reply-To: <534454506f92428863de8fe0638f4129e962a073.1323191497.git.trast@student.ethz.ch> (Thomas Rast's message of "Tue, 6 Dec 2011 18:43:35 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E5026530-205C-11E1-9553-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186401>

Thomas Rast <trast@student.ethz.ch> writes:

> A simple utility that invalidates all existing cache-tree data.  We
> need this for tests.  (We don't need a tool to rebuild the cache-tree
> data; git read-tree HEAD works for that.)

"git read-tree -m HEAD HEAD" would work for that, I suspect ;-)

But that can be improved later, so it is very sensible to add a test tool
like this.
