From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-rebase and reflog
Date: Wed, 30 Apr 2008 10:34:40 -0700
Message-ID: <7v7ief1c27.fsf@gitster.siamese.dyndns.org>
References: <46dff0320804300904i3402b5e7wf827f6759bc52901@mail.gmail.com>
 <m3d4o7nvt2.fsf@localhost.localdomain>
 <46dff0320804300956x7e4f34efle39f6cad2e98a2de@mail.gmail.com>
 <4818A6CA.5000409@nrlssc.navy.mil>
 <46dff0320804301013o17da30cg1fd847beca94ff58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Brandon Casey" <casey@nrlssc.navy.mil>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 19:35:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrGDX-0008Cb-Ck
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 19:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762969AbYD3Rew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 13:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762939AbYD3Rev
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 13:34:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48874 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761160AbYD3Reu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 13:34:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 007B8213D;
	Wed, 30 Apr 2008 13:34:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 53BD72137; Wed, 30 Apr 2008 13:34:43 -0400 (EDT)
In-Reply-To: <46dff0320804301013o17da30cg1fd847beca94ff58@mail.gmail.com>
 (Ping Yin's message of "Thu, 1 May 2008 01:13:24 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BAE0488C-16DB-11DD-942D-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80858>

"Ping Yin" <pkufranky@gmail.com> writes:

> However, i still think the intemediate commits of git-rebase needn't
> go into HEAD's reflog because it's totally useless.

Actually I use it from time to time when I need to compare intermediate
steps of _previous_ run of the same rebase while rebasing, if the current
run needs to resolve conflicts (may be the same conflict, may be a
different conflict, depending on what bases are used for the current run
and the previous run).

Please do not break it.
