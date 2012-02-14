From: Junio C Hamano <gitster@pobox.com>
Subject: diff --stat
Date: Mon, 13 Feb 2012 16:11:46 -0800
Message-ID: <7v4nuub7el.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 01:12:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx5zz-0004rG-H9
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 01:11:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758580Ab2BNALu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 19:11:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42838 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756127Ab2BNALs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 19:11:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71A1E62FD;
	Mon, 13 Feb 2012 19:11:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=D
	cVNIAI6ZA/dE2VPfSZtjaAddlo=; b=lNW37UCNCtUKQIB6obWPtkGzPJiCfNxoE
	+HyDAlVMVQg1mB8S38K3lPgvVcD69Ba5oKS/8snFj0WXvgFn99SycgUEmmAHeU6Y
	yMjmiKkDxOwGLhrCXZHzTiya9wftZcgFm6MiGeHAO4trgtrHWxqlWullBiFu6OU1
	5kB8kip3Xc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Jbb
	9kUebj9QrPHVUXeRkX0HXgn5yar6h8coj8GYQ3rJpEi+ymF8bMAcl6e/MHN2qbfl
	tT+6fk3If5b/+dSIJTynw5sk99SOOAFFPxc2m/hU7931aPq25hhqOnQxUbCLtljS
	iSb3KyLoFwQhBxp8yimVL9bCTKpoABkd+/l7Steg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6888A62FC;
	Mon, 13 Feb 2012 19:11:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D8AA162FB; Mon, 13 Feb 2012
 19:11:47 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7C5BD3B6-56A0-11E1-98D7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190692>

Hrm, what is wrong with this picture?

$ git -c diff.color.old=red show --format='%s' --stat
Merge branch 'jk/diff-highlight' into pu

 contrib/diff-highlight/README         |  109 ++++++++++++++++++++++++++++++--
 contrib/diff-highlight/diff-highlight |  109 ++++++++++++++++++++++++---------
 2 files changed, 181 insertions(+), 37 deletions(-)

They both have 109 lines changed but the end of the graph lines do not
coincide...
