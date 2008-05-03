From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Documentation: convert tutorials to man pages
Date: Sat, 03 May 2008 10:44:57 -0700
Message-ID: <7vfxszuvs6.fsf@gitster.siamese.dyndns.org>
References: <20080502053051.c8066c4e.chriscool@tuxfamily.org>
 <8fe92b430805020255r1a06e169te583c371bde83ade@mail.gmail.com>
 <20080502124900.GA2923@sigill.intra.peff.net>
 <200805030604.32123.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	"J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat May 03 19:46:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsLo7-0004kL-PX
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 19:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755125AbYECRpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 13:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754455AbYECRpM
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 13:45:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53899 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754519AbYECRpK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 13:45:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 92CE71F6A;
	Sat,  3 May 2008 13:45:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D654C1F61; Sat,  3 May 2008 13:45:01 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AB6CFAF8-1938-11DD-A86A-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81104>

Christian Couder <chriscool@tuxfamily.org> writes:

> About man page sections, Perl is consistent because every thing is in 
> section 1.

I do not think it is a good example to follow, though.

> Now for git we already have git commands in section 1 and some 
> other documentation (gitattributes, gitignore, gitmodules) in section 5 
> and "git" in section 7. Do we want to keep "git" alone in section 7 and put 
> tutorials in section 1 ? Or put everything in section 1 ?

My preference is to move git(7) to git(1) because it is describing a
command at the end-user level (distros are much better than us to come up
with a way to deal with conflict resolution between us and the other git),
keep file format description in section 5 (that's where they belong to).
