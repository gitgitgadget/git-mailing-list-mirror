From: Junio C Hamano <gitster@pobox.com>
Subject: The tip of 'next' has been rewound.
Date: Mon, 07 Jan 2013 12:04:37 -0800
Message-ID: <7va9skiwtm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 07 21:05:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsIwO-0007U6-C8
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 21:05:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753538Ab3AGUEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 15:04:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37704 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751139Ab3AGUEk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 15:04:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 382CAA491;
	Mon,  7 Jan 2013 15:04:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=J
	MaSMKDOlofFrfVHkhJaYoMpDFg=; b=Fb6+JIJD7oPUTMwj5CfUnkevDNnJQO4Ol
	LBtwhwVpjj/dSU+O1hGJeJ3gdyBrndNhWQysPyzCAijhsVlaHraH6aqj1C65Vgy2
	dzUBOu9TnR49CrvZ8u6kmiQhvmB2u56QIfOA2e4LFq691dFJBbpPcmwkA53hqWB1
	k6PgCgNaLU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=k19
	0tU7Ywjo473aX8vL8XInXpqkICjUaUtNc1NsH2WgIJmbrq/glkjuBuSEDWJaHZD/
	63L+lQ9t9nQ6EVcgfw1HiD00DSzO+39AbVt6Aq6Dsy2wunwzeA1WbOtIde6rOeE7
	p9msxPr8NfHFYPCwou+BNFbDhrg3ANvMjuHxJRSI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B351A490;
	Mon,  7 Jan 2013 15:04:39 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A2381A48F; Mon,  7 Jan 2013
 15:04:38 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 775B44A6-5905-11E2-B1E7-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212916>

Just to let you contributors know, your next "git fetch" will notice
that remotes/origin/next has been rewound.  Two topics have been
kicked back to 'pu', and the branch has been reordered somewhat.

I'll start merging bugfix topics that have graduated to master since
v1.8.1 to maint so that we can have v1.8.1.1 sometime next week.  We
haven't seen any real regression report for v1.8.1 since tagging it,
and it has been a week, so this may be the first 'maint' release
without "brown paper bag regression fix" for quite some time ;-)
