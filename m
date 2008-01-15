From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] hg-to-git: improve popen calls
Date: Tue, 15 Jan 2008 02:17:32 -0800
Message-ID: <7vr6gjfl4z.fsf@gitster.siamese.dyndns.org>
References: <478C0837.7090804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, brian.ewins@gmail.com, stelian@popies.net
To: Mark Drago <markdrago@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 11:18:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEisE-0002eC-W9
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 11:18:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754324AbYAOKRs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 05:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755404AbYAOKRr
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 05:17:47 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55949 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668AbYAOKRr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 05:17:47 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E45285E99;
	Tue, 15 Jan 2008 05:17:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BA7D5E98;
	Tue, 15 Jan 2008 05:17:39 -0500 (EST)
In-Reply-To: <478C0837.7090804@gmail.com> (Mark Drago's message of "Mon, 14
	Jan 2008 20:11:19 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70510>

Mark Drago <markdrago@gmail.com> writes:

> +    log_data = os.popen('hg log -r %d --template "{tags}\n{date|date}\n{author}\n"' % cset).readlines()

I've already seen Stelian's Ack, but just for my sanity, let me
make sure one thing.  The above {date|date} is correct, not a
typo?
