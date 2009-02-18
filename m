From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is there a way to exclude user-specified files or directories
 from  participating in merges?
Date: Wed, 18 Feb 2009 11:02:30 -0800
Message-ID: <7v3aeby3eh.fsf@gitster.siamese.dyndns.org>
References: <e38bce640902171649g765275a4n4e86d1d4f4aaf394@mail.gmail.com>
 <7v1vtw367w.fsf@gitster.siamese.dyndns.org>
 <slrngpo3hp.boq.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 20:04:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZriI-0000gU-IA
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 20:04:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301AbZBRTCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 14:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753221AbZBRTCg
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 14:02:36 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57304 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753175AbZBRTCf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 14:02:35 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2FE1B2B686;
	Wed, 18 Feb 2009 14:02:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 797F12B683; Wed,
 18 Feb 2009 14:02:32 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B3D046AA-FDEE-11DD-8C9C-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110566>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> Let me explain where I'm coming from: this is very often needed when you
> maintain customer specific branches, and the workflows in both your
> posts in this thread so far are too complex for, err, me <sheepish grin>
> :-)
>
> Would it not be easier to do something like this?  (I suck at 2-d
> drawing, even line... but this should still be understandable)

What you drew is a detailed discussion on a technique to use to group
together common part and customer specific part, and I think it is Ok to
do whatever you feel comfortable with.  It is essentially the same as my
"in real life, 'git diff >P.diff' is not how I would do this" example,
just going into more detail on what you would do to sift 'common only' vs
'specific to work branch' apart, and I think what you are doing is sane.

But if you wrote it as a draft of a document to explain how-to to new
people, I think you need to clarify a few things.

It is unclear in your description how the "common" branch progressed in
the whole process, and how the resulting history looks.  I can guess that
you meant commits marked with alphabet letters are of common kind and
numbers are of work kind, but you do not want to force readers to guess.

It also is not quite clear that you are using a temporary branch in
addition to common and work, and where in your sequence you are doing "git
checkout" to switch branches.
