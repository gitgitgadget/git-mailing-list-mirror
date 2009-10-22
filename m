From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [msysGit] Re: [PATCH v5 0/8] imap-send: Windows support
Date: Thu, 22 Oct 2009 12:20:09 -0700
Message-ID: <7vd44fgrrq.fsf@alter.siamese.dyndns.org>
References: <1256144691-2908-1-git-send-email-kusmabite@gmail.com>
 <alpine.DEB.1.00.0910221942150.1263@felix-maschine>
 <200910222011.02737.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	msysgit@googlegroups.com,
	"Erik Faye-Lund" <kusmabite@googlemail.com>, git@vger.kernel.org,
	"Erik Faye-Lund" <kusmabite@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Oct 22 21:20:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N13DE-000559-45
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 21:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756799AbZJVTUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 15:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756768AbZJVTUX
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 15:20:23 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56964 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756524AbZJVTUW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 15:20:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6AE1D81FE7;
	Thu, 22 Oct 2009 15:20:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2jg/Xu+iOXF/Ac4iApzx/GYAVus=; b=Lwg8GY
	YUPbi5r4S+1g7x8IT7SKHQhibrDbGIzvRe3LvCPY7XpLh3NpDBHoa04ZGYLoKa+M
	/3STNTvBLbzpVDqgSzE9/NbzKk+l05oIJtunFH/UQKcLfCT9Qw/ukgCzIfmFN9m6
	dTFHrmbouFebyKhABgxNG+yq1fDkOelPH1cAI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nbbZLciajzdiPchOlbLRCMKPjaMxIGyl
	ug5crZYSSEzP8MyoxHUIPwxCvz1NhO2uji6f1uFOeBuDMuDqkjj4QajTqH6unEUV
	nHnlprTvRGWgzq/+m4Z76rRS4VugCynjCJXOn67FyuKUSGWWOw7rRopksLFtKYTl
	Ek4mjUjTet0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1538D81FE6;
	Thu, 22 Oct 2009 15:20:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7E64281FE5; Thu, 22 Oct 2009
 15:20:11 -0400 (EDT)
In-Reply-To: <200910222011.02737.j6t@kdbg.org> (Johannes Sixt's message of
 "Thu\, 22 Oct 2009 20\:11\:02 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F022D5CE-BF3F-11DE-9170-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131044>

Johannes Sixt <j6t@kdbg.org> writes:

> On Donnerstag, 22. Oktober 2009, Johannes Schindelin wrote:
>> If there are no objections, I will apply them tomorrow.
>
> The series is already in pu (FYI),...

Please don't mind me; if msysgit people are happy with this series that
affects only msysgit, I would be a lot happier to get a pull request to
merge them with Acks and Sign-offs from you guys directly into 'master',
rather than me shepherding the series from 'pu' down to 'master'.
