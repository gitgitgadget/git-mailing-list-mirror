From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document git-svn's first-parent rule
Date: Mon, 16 Nov 2009 22:25:20 -0800
Message-ID: <7vd43his6n.fsf@alter.siamese.dyndns.org>
References: <ea845c8757a629d692bb6cd3827887f0e811c044.1258366486.git.trast@student.ethz.ch> <20091116231455.GA13460@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Nov 17 07:25:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAHVQ-0006VU-22
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 07:25:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753464AbZKQGZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 01:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752901AbZKQGZY
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 01:25:24 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61546 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697AbZKQGZX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 01:25:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C56209F445;
	Tue, 17 Nov 2009 01:25:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5q8EgiLn8/vSywYI8330hKBwg6g=; b=V5EW00
	bW0jToOvYLs8oO4gZlQq5EDvJtEQ3jcX0pArRpqL3mhVh9ROC6LskC2OCou5Q7T5
	2246H/ShZimGZx5zf6N52SmcrO2HBg/ODCEF6EIGrZa1Te687wmPQD49fPhTOwCU
	jfp9yCv9OL/WZ0BGvXcitk+dVUC5GE4e7n6FM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nJDFIkaG01Wndf5YI/N1aJVQMvhfmtU3
	Kkd1AmSzq2isDNwlrYwPCsXWzLIOsEKMyA9mYawRLEDd2D98zkF0R512AJ5DboTF
	izgKlwF0qHuxXOo+dRAMYpW0215yqSMkWC71KvtiLRngNzefkJdEZnz8AZM5jm0u
	aMN0grlUvX8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 94D569F444;
	Tue, 17 Nov 2009 01:25:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 55ED79F441; Tue, 17 Nov 2009
 01:25:22 -0500 (EST)
In-Reply-To: <20091116231455.GA13460@dcvr.yhbt.net> (Eric Wong's message of
 "Mon\, 16 Nov 2009 15\:14\:55 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FE9C179E-D341-11DE-B745-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133063>

Eric Wong <normalperson@yhbt.net> writes:

> Thomas Rast <trast@student.ethz.ch> wrote:
>> git-svn has the following rule to detect the SVN base for its
>> operations: find the first git-svn-id line reachable through
>> first-parent ancestry.  IOW,
>> 
>>   git log --grep=^git-svn-id: --first-parent -1
>> 
>> Document this, as it is very important when using merges with git-svn.
>> 
>> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
>
> Thanks Thomas,
>
> Acked-by: Eric Wong <normalperson@yhbt.net>

Thanks; is it a good time to pull from your bogomips repository to get
accumulated changes?
