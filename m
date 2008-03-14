From: Junio C Hamano <gitster@pobox.com>
Subject: Re: builtin-status submodule summary
Date: Fri, 14 Mar 2008 09:39:03 -0700
Message-ID: <7vprtxp8ew.fsf@gitster.siamese.dyndns.org>
References: <1205416085-23431-1-git-send-email-pkufranky@gmail.com>
 <46dff0320803140730jeef5808r7da67a103ce7b171@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 17:39:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaCwi-0006R0-Th
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 17:39:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754957AbYCNQjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 12:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754844AbYCNQjO
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 12:39:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63476 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754729AbYCNQjK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 12:39:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BF23C2178;
	Fri, 14 Mar 2008 12:39:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E09F72176; Fri, 14 Mar 2008 12:39:05 -0400 (EDT)
In-Reply-To: <46dff0320803140730jeef5808r7da67a103ce7b171@mail.gmail.com>
 (Ping Yin's message of "Fri, 14 Mar 2008 22:30:51 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77254>

"Ping Yin" <pkufranky@gmail.com> writes:

> So i think this series should go along with the submodule summary series.

Perhaps eventually, but definitely not this round, I am afraid.

The usefulness of the output in the current implementation of the
"summary" itself is not even proven at this point.  Nobody other than you
has jumped up-and-down and said "submodule summary is great and should be
in status, I did not know what I was missing!" yet.

I hope we verified the code well enough to make sure that people who use
"git submodule" command but do not type "git submodule summary" would not
get hurt by the addition.  For a new feature, that is more important than
how well the new feature works and how useful the new feature is.  And by
shipping a release with it will give it a wider exposure and hopefully a
chance for it to mature to get more useful.  The series just got into a
"harmless to others and is releasable" shape.

Recall how many rounds "submodule summary" took to get into that state,
and how much time and effort were spent on it.  Use it as a yardstick to
guesstimate how much further effort and time will be needed to get the
changes to git-status into a reasonable shape.

It may happen eventually, but not before 1.5.5.
