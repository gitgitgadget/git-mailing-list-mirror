From: Junio C Hamano <gitster@pobox.com>
Subject: Some stats for 1.6.6
Date: Thu, 24 Dec 2009 10:01:24 -0800
Message-ID: <7v637wjlor.fsf@alter.siamese.dyndns.org>
References: <7vpr65kwnt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 24 19:04:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNs2r-000571-Tz
	for gcvg-git-2@lo.gmane.org; Thu, 24 Dec 2009 19:04:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753738AbZLXSBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Dec 2009 13:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753121AbZLXSBe
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Dec 2009 13:01:34 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43408 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071AbZLXSBd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Dec 2009 13:01:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C266BA9B9F;
	Thu, 24 Dec 2009 13:01:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=e3uK+sEzy+QT+0Ht+OhtEc5MpX0=; b=O+KKSpUrHimAK44NPlI4o8w
	En3t+byWtu0zLwnvwFtrjsYm48+lwxQ//XECL+PToW13r7VC9RivxhRVfD2QRySC
	K4l0MhPq8JOicdBwAcle5/Wrq89Sv1ZuacLZSd6pQi4zz5Uz2sAO8i0uVObXYhNn
	/J+xwUMlt4jWyI4hYKTM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=aVdQvNCitcrOo48cai2umDd5qsLGO1v19PNvvFJg+f87g7FVy
	gxku8Yloz8A1rBHmU+jSkzrF82ekMVN8za8tL3N64IUWtuH2u2Ho2cPX9Ymi96HF
	/qXHxnVwyg2pAlyhNGC3UGtIhsc7IsSpxFVukN8XQznsEKbTYcn7OTZJ3w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AC89EA9B9E;
	Thu, 24 Dec 2009 13:01:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CF27BA9B9D; Thu, 24 Dec 2009
 13:01:26 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5C0B92A6-F0B6-11DE-80D2-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135659>

Now 1.6.6 is out, the next one will be 1.7.0 that hopefully will happen
sometime late in February 2010.  I wish people happy holidays, and expect
them to slow down (I would ;-) for the remainder of the year.

Here are a few sets of numbers to help relax your mind away from hacking.

The very initial release of "git" consisted of 11 files, 1244 lines in
total, all written by Linus.  Here is the result of a "reverse-blame" that
counts how much of that original version still can be found in the latest
version:

   surviving     original path (survival%)
          16           40 Makefile (40.00%)
          16          168 README (9.52%)
          54           93 cache.h (58.06%)
           4           23 cat-file.c (17.39%)
           6          172 commit-tree.c (3.48%)
           4           51 init-db.c (7.84%)
          99          259 read-cache.c (38.22%)
           0           43 read-tree.c (0.00%)
           7           81 show-diff.c (8.64%)
          39          248 update-cache.c (15.72%)
           0           66 write-tree.c (0.00%)
         245         1244 Total (19.69%)

As can be seen in "cache.h", the very basic data structures and accessor
methods haven't changed much.  v0.99, which was the last version Linus
tagged before handing the development over to me, still retained 46% of
the original.

Here is a contributor statistics.

      release new     this    total   date
      v0.99   47      47      47      2005-07-10
      v1.0.0  68      89      115     2005-12-21
      v1.1.0  4       19      119     2006-01-08
      v1.2.0  8       32      127     2006-02-12
      v1.3.0  22      56      149     2006-04-18
      v1.4.0  18      57      167     2006-06-10
      v1.4.1  3       30      170     2006-07-01
      v1.4.2  13      47      183     2006-08-12
      v1.4.3  9       43      192     2006-10-18
      v1.4.4  8       42      200     2006-11-14
      v1.5.0  25      72      225     2007-02-14
      v1.5.1  14      59      239     2007-04-03
      v1.5.2  19      70      258     2007-05-20
      v1.5.3  53      126     311     2007-09-02
      v1.5.4  82      163     393     2008-02-01
      v1.5.5  33      112     426     2008-04-07
      v1.5.6  46      114     472     2008-06-18
      v1.6.0  40      105     512     2008-08-17
      v1.6.1  49      147     561     2008-12-24
      v1.6.2  34      109     595     2009-03-03
      v1.6.3  45      117     640     2009-05-06
      v1.6.4  26      98      666     2009-07-29
      v1.6.5  27      101     693     2009-10-10
      v1.6.6  17      99      710     2009-12-23

During the entire history leading to 1.6.6, 710 authors contributed code
and documentation.  The changes since 1.6.5 were made by 99 authors, among
which 17 are the new contributors to the project.

Let's thank and welcome them to the community(sorted LC_ALL=C): Andrew
Myrick, Brian Collins, Carlos R. Mafra, Dan Zwell, Erick Mattos, Gisle
Aas, Guillermo S. Romero, Jean Privat, Jimmy Angelakos, Jindrich
Makovicka, Mizar, Nasser Grainawi, Pauli Virtanen, Raman Gupta, Robert
Zeh, Tim Henigan, and Vietor Liu.
