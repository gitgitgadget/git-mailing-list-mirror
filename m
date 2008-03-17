From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] tig-0.10
Date: Mon, 17 Mar 2008 03:49:55 -0700
Message-ID: <7vlk4hbp64.fsf@gitster.siamese.dyndns.org>
References: <20080317020304.GA19249@diku.dk>
 <7vr6e9bvuu.fsf@gitster.siamese.dyndns.org> <20080317102318.GA6830@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Mon Mar 17 11:50:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbCvY-0005OP-Ul
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 11:50:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428AbYCQKuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 06:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752461AbYCQKuH
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 06:50:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54082 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114AbYCQKuG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 06:50:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9D4B82A06;
	Mon, 17 Mar 2008 06:50:04 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id A504F271D; Mon, 17 Mar 2008 06:49:58 -0400 (EDT)
In-Reply-To: <20080317102318.GA6830@diku.dk> (Jonas Fonseca's message of
 "Mon, 17 Mar 2008 11:23:18 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77425>

Jonas Fonseca <fonseca@diku.dk> writes:

> Junio C Hamano <gitster@pobox.com> wrote Mon, Mar 17, 2008:
>> Jonas Fonseca <fonseca@diku.dk> writes:
>> 
>> > ... Building the documentation
>> > (sadly?) now depends on DocBook XSL 1.72 to reduce the number of
>> > accumulated AsciiDoc and XSL hacks.
>> 
>> Well, I've been a quiet but big fan of tig for quite some time, but to me,
>> requiring autoreconf is a much larger regression than DocBook dependency.
>
> I am not sure I understand. As far as I know, tig does not require
> autoreconf unless you have cloned the repository and want to bootstrap
> the configure script.

Yeah, but that was exactly what your announcement suggested to.  Show
Tarball and Gitfeed alternatives to a git person, who already has a clone
of the project, and guess which one he would go ;-).

Also INSTALL file begins with:

Installation instructions
-------------------------

Download a tarball from http://jonas.nitro.dk/tig/releases[] or clone the tig
repository http://jonas.nitro.dk/tig/tig.git[]. Documentation files are
available either in the tarballs or in the above repository in the branch named
'release'.

To install tig simply run:

        $ autoreconf
        $ ./configure
        $ make install

By the way, it would be nice if someday I can get tig work with CJK.
Perhaps I need to tweak something in ncurses?
