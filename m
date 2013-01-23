From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Question re. git remote repository
Date: Wed, 23 Jan 2013 12:24:43 -0800
Message-ID: <7va9rzhcl0.fsf@alter.siamese.dyndns.org>
References: <201301161749.r0GHnGV6007806@smtpb02.one-mail.on.ca>
 <20130116220615.48c159546bccfa5b9cd9028e@domain007.com>
 <20130116182156.GB4426@sigill.intra.peff.net>
 <20130116233744.7d0775eaec98ce154a9de180@domain007.com>
 <0630A778-9AC8-4023-889C-4FC58ABAB683@gmail.com>
 <alpine.DEB.2.02.1301161459060.21503@nftneq.ynat.uz>
 <201301172153.r0HLrU4F019815@smtpb02.one-mail.on.ca>
 <1BBEF94B6B46E54980290D150A6F2EDD46B7AAE2@BN1PRD0612MB635.namprd06.prod.outlook.com> <201301181833.r0IIXNe7021768@smtpb01.one-mail.on.ca> <1BBEF94B6B46E54980290D150A6F2EDD46B7D7D0@BN1PRD0612MB635.namprd06.prod.outlook.com> <201301231941.r0NJf3oa001238@smtpb01.one-mail.on.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "'Matt Seitz'" <mseitz@mhseitz.onmicrosoft.com>,
	David Lang <david@lang.hm>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: "Lang\, David" <David.Lang@uhn.ca>
X-From: git-owner@vger.kernel.org Wed Jan 23 21:25:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty6sd-0004vD-SI
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 21:25:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008Ab3AWUYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 15:24:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45827 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751388Ab3AWUYq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 15:24:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7972FCF20;
	Wed, 23 Jan 2013 15:24:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zWmiX2IUJbFFytGxye0pV8cX0Fo=; b=MuO4kP
	IhHcx9L8k7Z54zfgcZ7MuVT0T2IjUFt02FrUfjBCJXWAfAJT3vHiVpd2Us4p/rIh
	vsEtxmJYa9qzwBGJwFy1+ZayJ6UBaDhOB3ICks5zH+fyEmS35ArtkXVpSJulKQU4
	9SekZfjiIwTC9RBphhOLBR4J/G5REN6ocOrlI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WSLmZ3qIHxsq5KzWGZo1du2bZ4XP3/zy
	ypDVhwwJdpcQ2N5eS+lCqvDJY4jWqobrvYvJtGt+6iV3KcIw/fXcFUiRYBP8Tpxk
	0iPpAiPn9zw3PYIlajVvnSRAnh4RoVSehnAAzyDBe6X325FpC2wCq9nURQcp0dOO
	Svm2T40kdSA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 627D7CF1F;
	Wed, 23 Jan 2013 15:24:45 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7FE7CF1E; Wed, 23 Jan 2013
 15:24:44 -0500 (EST)
In-Reply-To: <201301231941.r0NJf3oa001238@smtpb01.one-mail.on.ca> (David
 Lang's message of "Wed, 23 Jan 2013 19:40:50 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ECDA197C-659A-11E2-9A87-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214358>

"Lang, David" <David.Lang@uhn.ca> writes:

> Thanks Matt and Dave and everyone else for your feedback on this.

[administrivia: please wrap your lines to reasonable length]

> 1. Download and install git for Windows on the 2 networked developer's
> PC's and the 1 networked server.
>
> 2. On the server...
> 	A) Initialize the Visual Studio folder for a particular
> project as a git repository using 'git init'
> 	b) Using the git rep just created (above), create a bare
> repository on the server to act as the remote/master repository using
> git clone --bare'

optionally:

	C) remove the original directory (A)

        D) make a non-bare clone on the server with "git clone", if
    	   you would like to have a single build environment on the
    	   server box.

        E) Use "git pull" from the bare repository you created in
    	   step (2.B) to update the repository you created in step
    	   (2.D) as necessary in order to build the latest in this
    	   repository.

> 3. On each of the PC's...
> 	A) Clone the remote repository from the network server using
> git clone' (this will automatically create 'origin' as a remote source
> on the PC's)

	B) Each developer works in his repository; use either "git
           pull" or "git pull --rebase" to sync up with the tip of
           the master repository as necessary;

	C) When a developer's work reaches a point where it is good
           enough to update the master repository, use "git push" to
           update the bare repository you created on the server in
           step (2.B).  This may need to trigger step (2.E).

> Couple of questions...
> ...
> 4. The original Visual Studio project folder essentially remains
> untouched, correct? The 'git init' and 'git clone' commands just make
> copies and references of whatever data is in the VS project folder,
> right?

These operations make copies and after making copies they do not
ever refer to the original, so you can take a back-up of the
original and remove it (i.e. optional step (c)).
