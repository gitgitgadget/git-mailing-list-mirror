From: Junio C Hamano <gitster@pobox.com>
Subject: Re: q: faster way to integrate/merge lots of topic branches?
Date: Fri, 25 Jul 2008 01:46:48 -0700
Message-ID: <7vej5iuz9j.fsf@gitster.siamese.dyndns.org>
References: <20080723130518.GA17462@elte.hu> <20080723135621.GJ22606@neumann>
 <20080723140441.GA9537@elte.hu> <7v8wvscqtm.fsf@gitster.siamese.dyndns.org>
 <20080724152742.GA23585@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Fri Jul 25 10:48:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMIxz-0002D5-Vs
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 10:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122AbYGYIq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 04:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752875AbYGYIq7
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 04:46:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52791 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687AbYGYIq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 04:46:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B83F138538;
	Fri, 25 Jul 2008 04:46:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2F6CC38537; Fri, 25 Jul 2008 04:46:53 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3CDE0454-5A26-11DD-BA4C-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90015>

Ingo Molnar <mingo@elte.hu> writes:

> perhaps you need to run tip-create-local-branches.sh to create all the 
> local branches? You can find it in:
>
>   tip/tip .tip/bin/tip-create-local-branches.sh
>
> (does/should the presence of local branches matter?)

My refs/remotes/mingo/ hierarchy has as many branches as you do in your
repository as local branches, and I presume you do not have these tracking
branches as I do because you are the upstream of this repository, so
overall we have about the same number of refs.  In the experiment, I did
"branch -a --no-merged" (notice -a), so I do not think the difference
should have mattered.
