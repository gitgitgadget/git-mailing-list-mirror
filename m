From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Error in compile Git 1.6.0.rc1
Date: Tue, 29 Jul 2008 10:52:57 -0700
Message-ID: <7viquofuh2.fsf@gitster.siamese.dyndns.org>
References: <5c9cd53b0807291050i752f91b9yc1da4afb7096ab61@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "mike zheng" <mail4mz@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 19:54:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNtOf-0005d4-64
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 19:54:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754702AbYG2RxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 13:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754668AbYG2RxE
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 13:53:04 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44999 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754644AbYG2RxD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 13:53:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 60CE641E6C;
	Tue, 29 Jul 2008 13:53:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7E7F741E6B; Tue, 29 Jul 2008 13:52:59 -0400 (EDT)
In-Reply-To: <5c9cd53b0807291050i752f91b9yc1da4afb7096ab61@mail.gmail.com>
 (mike zheng's message of "Tue, 29 Jul 2008 13:50:31 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 30592866-5D97-11DD-8881-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90663>

"mike zheng" <mail4mz@gmail.com> writes:

> Hello,
>
> I download the git-1.6.0.rc.tar.gz from
> http://www.kernel.org/pub/software/scm/git/. When I try to compile it
> on RH linux, I have following errors. Any idea?
>
> Thanks,
>
> Mike
>
> /localdisk/work/git-1.6.0.rc1-> make
> /bin/sh: curl-config: command not found

Sure.  You are missing curl-config.

Look for "Git is reasonably self-sufficient, but" in the INSTALL document
supplied in the tarball.
