From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff -- file1 file2: do not default to --no-index inside
 a git repository
Date: Fri, 23 May 2008 22:17:23 -0700
Message-ID: <7vfxs8p9gc.fsf@gitster.siamese.dyndns.org>
References: <b0943d9e0805230720h61cbabbbw180908e1b28a34cc@mail.gmail.com>
 <alpine.LFD.1.10.0805230906110.3081@woody.linux-foundation.org>
 <alpine.LFD.1.10.0805230942480.3081@woody.linux-foundation.org>
 <7vbq2wsxnk.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0805232309350.30431@racer>
 <7v8wy0r2pa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 24 07:18:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jzm9C-00039p-Vt
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 07:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475AbYEXFRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 01:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752457AbYEXFRg
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 01:17:36 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47048 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442AbYEXFRf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 01:17:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CA4783A06;
	Sat, 24 May 2008 01:17:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 0F4953A03; Sat, 24 May 2008 01:17:26 -0400 (EDT)
In-Reply-To: <7v8wy0r2pa.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 23 May 2008 17:00:17 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B72B146A-2950-11DD-956A-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82796>

Junio C Hamano <gitster@pobox.com> writes:

> I think ripping out --no-index from git-diff-files is probably the first
> step.  "git diff" also needs to fixed as Linus outlined, but that is a
> separate topic.
>
> How about doing something like this as a start?  At least that would get
> well behaved Porcelains like stg unstuck?
> ...

Please do not use this one, not just yet.

The series to fix this unfortunately is turning out to be larger than I
hoped for, but the result is looking very promising ;-).
