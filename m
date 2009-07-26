From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git svn: the branch command no longer needs the full
 path
Date: Sun, 26 Jul 2009 01:13:29 -0700
Message-ID: <7v3a8jsvyu.fsf@alter.siamese.dyndns.org>
References: <7vd47r298e.fsf@alter.siamese.dyndns.org>
 <20090724093847.GA20338@dcvr.yhbt.net>
 <7vk51ykm42.fsf@alter.siamese.dyndns.org>
 <20090725103821.GA13534@dcvr.yhbt.net> <20090725111044.GA7969@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Robert Allan Zeh <robert.a.zeh@gmail.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Jul 26 10:13:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUyre-0001Nh-VA
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 10:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbZGZINm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 04:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbZGZINm
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 04:13:42 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44465 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbZGZINl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2009 04:13:41 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1B9DA14F69;
	Sun, 26 Jul 2009 04:13:40 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7789A14F68; Sun,
 26 Jul 2009 04:13:32 -0400 (EDT)
In-Reply-To: <20090725111044.GA7969@dcvr.yhbt.net> (Eric Wong's message of
 "Sat\, 25 Jul 2009 04\:10\:44 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 39F74294-79BC-11DE-B84B-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124107>

Eric Wong <normalperson@yhbt.net> writes:

>   # I thought I had pushed this out earlier:
>   Robert Allan Zeh (1):
>         git svn: add gc command

Note that with this commit, the test fails needlessly if Compress::Zlib is
not found, even though otherwise "svn gc" succeeds (for some definition of
"success")..
