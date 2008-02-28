From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff --name-status does not always list changed files
Date: Thu, 28 Feb 2008 13:42:21 -0800
Message-ID: <7vejawhi6a.fsf@gitster.siamese.dyndns.org>
References: <fq6hhi$cub$1@ger.gmane.org>
 <7vablkkhac.fsf@gitster.siamese.dyndns.org>
 <bdca99240802281323x1ec904ddq914ac2c484e7c468@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Sebastian Schuberth" <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 22:43:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUqX1-0007EL-TF
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 22:43:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757241AbYB1Vmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 16:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754323AbYB1Vmf
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 16:42:35 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64157 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488AbYB1Vme (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 16:42:34 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CCF3B110A;
	Thu, 28 Feb 2008 16:42:31 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 45E6C1109; Thu, 28 Feb 2008 16:42:29 -0500 (EST)
In-Reply-To: <bdca99240802281323x1ec904ddq914ac2c484e7c468@mail.gmail.com>
 (Sebastian Schuberth's message of "Thu, 28 Feb 2008 22:23:43 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75462>

"Sebastian Schuberth" <sschuberth@gmail.com> writes:

> Junio C Hamano wrote:
>
>> Doesn't reproduce for me.
>>
>>         $ rm -fr /var/tmp/j && mkdir -p /var/tmp/j && cd /var/tmp/j
>>         $ git init
>>         Initialized empty Git repository in .git/
>
> Can you reproduce it if you do
>
> $ git config core.pager "less -F"
>
> after "git init"? The "-F" seems to be important, but I'm not sure why
> using this switch causes no files to be displayed in this case.

Then isn't it what you are asking "less" to do?

Try "less -FX".  FYI, by default, we use "LESS=FRSX" exported
unless the user knows better than us and uses something of his
own.
