From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] git-submodule: Extract absolute_url & move absolute
 url logic to module_clone
Date: Tue, 22 Apr 2008 00:57:27 -0700
Message-ID: <7v3ape2ufs.fsf@gitster.siamese.dyndns.org>
References: <1208355577-8734-1-git-send-email-pkufranky@gmail.com>
 <1208355577-8734-2-git-send-email-pkufranky@gmail.com>
 <1208355577-8734-3-git-send-email-pkufranky@gmail.com>
 <7v3ape5sip.fsf@gitster.siamese.dyndns.org>
 <46dff0320804212350t647492b2o649ddc40cfe43d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 09:59:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoDP2-0000On-GK
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 09:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759702AbYDVH5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 03:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759651AbYDVH5o
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 03:57:44 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53996 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759566AbYDVH5n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 03:57:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DE8CE2122;
	Tue, 22 Apr 2008 03:57:41 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 2BFEE2121; Tue, 22 Apr 2008 03:57:37 -0400 (EDT)
In-Reply-To: <46dff0320804212350t647492b2o649ddc40cfe43d6@mail.gmail.com>
 (Ping Yin's message of "Tue, 22 Apr 2008 14:50:22 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80078>

"Ping Yin" <pkufranky@gmail.com> writes:

> I just want to unify the behaviour of handling relative url.
>
> 'git submodule add'  treats './foo' and 'foo' as different urls. The
> 1st one is relative to remote.origin.url, while the 2nd one is
> relative the current directory. I think this kind of behaviour is
> better for submodules, so i unify the handling of relative urls as
> this.
>
> With this kind of behaviour, i can set 'submodule.foo.url=./foo' in
> .gitmodules or $GIT_DIR/config. And when remote.origin.url changes, i
> have not to change submodule.foo.url if the super project and
> submodule foo are always located on the same central host.

Please have that kind of justification in the proposed commit log message.
When these changes are made into history, people cannot ask you questions
like I did and expect the history to produce such answer on demand ;-)
