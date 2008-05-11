From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add svn-compatible "blame" output format to git-svn
Date: Sat, 10 May 2008 19:36:35 -0700
Message-ID: <7vabix8t3g.fsf@gitster.siamese.dyndns.org>
References: <20080510212504.GA26701@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Sun May 11 04:37:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jv1RY-0003Cw-RB
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 04:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754148AbYEKCgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 22:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754140AbYEKCgt
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 22:36:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43424 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754129AbYEKCgs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 22:36:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1C7BD1059;
	Sat, 10 May 2008 22:36:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 58D4B1056; Sat, 10 May 2008 22:36:42 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 19506922-1F03-11DD-9DC6-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81727>

Steven Grimm <koreth@midwinter.com> writes:

> git-svn blame produces output in the format of git blame; in environments
> where there are scripts that read the output of svn blame, it's useful
> to be able to use them with the output of git-svn blame.
>
> This also fixes a bug in the initial git-svn blame implementation; it was
> bombing out on uncommitted local changes.
>
> Signed-off-by: Steven Grimm <koreth@midwinter.com>
> ---
>
> 	I'd actually argue that the svn-compatible format should be the
> 	default one, with git-compatible available as an option.

I'd violently agree with it.

List, objections?
