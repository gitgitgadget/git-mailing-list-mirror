From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git to libgit2 code relicensing
Date: Sat, 15 Nov 2008 05:00:52 -0800
Message-ID: <7vk5b55ekb.fsf@gitster.siamese.dyndns.org>
References: <491DE6CC.6060201@op5.se>
 <alpine.LFD.2.00.0811141512480.3468@nehalem.linux-foundation.org>
 <20081114234658.GA2932@spearce.org>
 <20081115123916.GN24201@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Nov 15 14:02:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1KnV-0003kn-75
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 14:02:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754323AbYKONB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 08:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754547AbYKONB0
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 08:01:26 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47154 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754277AbYKONBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 08:01:25 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CD68F7DF37;
	Sat, 15 Nov 2008 08:01:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B478F7DF30; Sat,
 15 Nov 2008 08:01:00 -0500 (EST)
In-Reply-To: <20081115123916.GN24201@genesis.frugalware.org> (Miklos Vajna's
 message of "Sat, 15 Nov 2008 13:39:16 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 816FD9C4-B315-11DD-BF2F-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101068>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Fri, Nov 14, 2008 at 03:46:58PM -0800, "Shawn O. Pearce" <spearce@spearce.org> wrote:
>>  Note that the only valid version of the GPL as far as this project
>>  is concerned is _this_ particular version of the license (ie v2, not
>>  v2.2 or v3.x or whatever), unless explicitly otherwise stated.
>> 
>>  In addition to the permissions in the GNU General Public License,
>>  the authors give you unlimited permission to link the compiled
>>  version of this file into combinations with other programs,
>>  and to distribute those combinations without any restriction
>>  coming from the use of this file.  (The General Public License
>>  restrictions do apply in other respects; for example, they cover
>>  modification of the file, and distribution when not linked into
>>  a combined executable.)
>
> IANAL - what is the difference between this and the LGPL?

Under LGPL, you must provide linkable object files to your (possibly
closed source) program, so that people who made changes to (or obtained an
updated version of) a LGPL'ed library can re-link your program and use the
updated library.  The above does not ask you to do so.

The way I read LGPL is that "We deeply care about our LGPL library and any
improvements to it.  Although we do not care at all about how your crappy
closed source program is written, we want to make sure that the users can
keep using your program after improvements are made to our library.".  I
do not think it makes a practical difference when your program uses the
LGPL library as a shard library from that point of view.
