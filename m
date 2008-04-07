From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Integration branching
Date: Mon, 07 Apr 2008 11:44:30 -0700
Message-ID: <7vd4p1pks1.fsf@gitster.siamese.dyndns.org>
References: <b24851260804070602o11b93923m7ce7d79d5f59547b@mail.gmail.com>
 <7vod8lpnpb.fsf@gitster.siamese.dyndns.org>
 <b24851260804071118h4eaadef8i8313c5a4cb26495d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Kai Hendry" <hendry@aplixcorp.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 20:45:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiwLK-0008Tq-3a
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 20:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbYDGSoh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 14:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751814AbYDGSoh
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 14:44:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40201 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369AbYDGSog (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2008 14:44:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 73DB6DE01;
	Mon,  7 Apr 2008 14:44:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B5158DC1D; Mon,  7 Apr 2008 14:44:32 -0400 (EDT)
In-Reply-To: <b24851260804071118h4eaadef8i8313c5a4cb26495d@mail.gmail.com>
 (Kai Hendry's message of "Mon, 7 Apr 2008 19:18:45 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78986>

"Kai Hendry" <hendry@aplixcorp.com> writes:

> On Mon, Apr 7, 2008 at 6:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>  A set of big questions is how that git.webvm.net/srv/git/webkit-test
>>  repository was prepared, what its history look like and how it relates to
>>  the history your repository has.  I presume that that is different from
>>  the repository you are pushing from (which is "x61:aplix/test/WebKit"
>>  repository), but other than that you did not give any details to guess
>>  further.
>
> webkit-test was just a `git --bare init --shared` and completely empty
> with I tried pushing (publishing) the changes to WebKit trunk.

That explains it without the "theory" in my previous message.  The
destination repository must be populated with full history somehow (and
one way would have been to start it by cloning from the upstream), but if
it was empty that is alright as well, because your push made it
up-to-date.  IOW, there is nothing to worry about and the system is
working as designed.

Further pushes will update it incrementally.
