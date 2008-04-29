From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-help: Try to find html pages without the git- prefix
Date: Mon, 28 Apr 2008 21:45:55 -0700
Message-ID: <7vy76x8e0s.fsf@gitster.siamese.dyndns.org>
References: <1209377611-90005-1-git-send-email-pdebie@ai.rug.nl>
 <200804290513.40948.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 06:47:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqhk7-0000JN-8Y
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 06:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512AbYD2EqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 00:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753463AbYD2EqO
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 00:46:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34802 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313AbYD2EqN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 00:46:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 60BCA24DB;
	Tue, 29 Apr 2008 00:46:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B770124DA; Tue, 29 Apr 2008 00:46:02 -0400 (EDT)
In-Reply-To: <200804290513.40948.chriscool@tuxfamily.org> (Christian Couder's
 message of "Tue, 29 Apr 2008 05:13:40 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80644>

Christian Couder <chriscool@tuxfamily.org> writes:

> We already have the following files following that scheme:
>
> gitk.txt
> gitattributes.txt
> gitignore.txt
> gitcli.txt
> gitmodules.txt
> git.txt
>
> And for example the following commands are already working:
>
> $ git help -w gitmodules
> $ git help -m gitmodules
> $ man gitmodules

That is not surprise as gitattributes(5), gitignore(5) and gitmodules(5)
work by design.  They are valid manual pages in section 5 (file formats).

I am not sure about hooks let alone gitcli --- they are not something you
would traditionally place in section 5.

It would be nice if "git help <any path you see in Documentation/>" worked
as expected, although I personally tend to go to the *.txt files ;-)
