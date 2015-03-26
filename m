From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] gitweb: make category headings into links when they are directories
Date: Thu, 26 Mar 2015 12:49:10 -0700
Message-ID: <xmqqwq23y1xl.fsf@gitster.dls.corp.google.com>
References: <5e56772f50d3d1498361d8831c4f2fba38d197b4.1426779553.git.dot@dotat.at>
	<alpine.LSU.2.00.1503191540020.23307@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Tony Finch <dot@dotat.at>
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 20:49:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbDmQ-0001eZ-1F
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 20:49:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675AbbCZTtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 15:49:20 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58674 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752540AbbCZTtR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 15:49:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 876EE4295F;
	Thu, 26 Mar 2015 15:49:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GSPh3hLpKYCJygfjOLEqtzdc1LA=; b=rI09J7
	vfLHRZKcuTyHGqQtDYLG8rXYi26z1MtwF746pKwgWAS35kYB99qviU2l/ns9z2ST
	e38DDlisxnW9iQN9Y9DBJdYALHqyrpKFxKzQAA67SXoLVl26pqYHuRsMjWMdcnjZ
	lAYIy15oA/TSH8q9OTKk52GwyKWsDULKWyFt4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ahsmuclK3qpKh3nD1hNQT5NQYNbWrNPC
	45iNSWSb2vgnAAYxuIqw4yuJx0khuevLhxkQMcTGerMIPCPd9Z7ge+llGJHBLFi6
	BQ2gjmsEJ3DH50LTLHOIxLZaYO0Yd+OXYTvfS/fJ8KxILBa3977TG3KR+yIdtnha
	DZ6gSKSKAIQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7FCB74295E;
	Thu, 26 Mar 2015 15:49:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CD6C54295D;
	Thu, 26 Mar 2015 15:49:11 -0400 (EDT)
In-Reply-To: <alpine.LSU.2.00.1503191540020.23307@hermes-1.csi.cam.ac.uk>
	(Tony Finch's message of "Thu, 19 Mar 2015 15:40:19 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2CB4A5D2-D3F1-11E4-8B21-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266342>

Any comments from those who use or have their own code in Gitweb on
this topic?

* tf/gitweb-project-listing (2015-03-19) 5 commits
 - gitweb: make category headings into links when they are directories
 - gitweb: optionally set project category from its pathname
 - gitweb: add a link under the search box to clear a project filter
 - gitweb: if the PATH_INFO is incomplete, use it as a project_filter
 - gitweb: fix typo in man page

 Update gitweb to make it more pleasant to deal with a hierarchical
 forest of repositories.
