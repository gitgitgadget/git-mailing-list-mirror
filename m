From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What git config --replace-all ONE_ARG should do?
Date: Wed, 26 Mar 2008 14:24:13 -0700
Message-ID: <7v7ifpch6q.fsf@gitster.siamese.dyndns.org>
References: <1b46aba20803260650o5e425250sb532a3b3197a1ecf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Carlos Rica" <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 22:25:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jed81-0002e6-Mu
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 22:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762657AbYCZVY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 17:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761379AbYCZVY0
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 17:24:26 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65343 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762651AbYCZVYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 17:24:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A444A1A3A;
	Wed, 26 Mar 2008 17:24:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 2226F1A36; Wed, 26 Mar 2008 17:24:16 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78313>

"Carlos Rica" <jasampler@gmail.com> writes:

> The command 'git config --replace-all ONE_ARG' currently
> tries to do the same as the command 'git config NAME VALUE',
> using --replace-all as the NAME and ONE_ARG as VALUE,
> printing "key does not contain a section: --replace-all".

That sounds silly, and I think it is an improvement to error out in such a
case.
