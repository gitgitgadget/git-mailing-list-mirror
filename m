From: Junio C Hamano <junkio@pobox.com>
Subject: Re: [ANNOUNCE] GIT 1.5.3
Date: Sun, 02 Sep 2007 17:19:00 -0700
Message-ID: <7vejhgob2j.fsf@gitster.siamese.dyndns.org>
References: <7vodglr32i.fsf@gitster.siamese.dyndns.org>
	<46DA5F33.2020005@zytor.com> <85odgltrtj.fsf@lola.goethe.zz>
	<46DA88EF.7080103@zytor.com>
	<20070902133803.1b46f599.seanlkml@sympatico.ca>
	<7v4picpvgq.fsf@gitster.siamese.dyndns.org>
	<20070902191644.29d46cd2.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>, David Kastrup <dak@gnu.org>,
	git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Mon Sep 03 02:19:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRzem-0002nU-9N
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 02:19:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756194AbXICATE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 20:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750928AbXICATE
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 20:19:04 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:43779 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbXICATC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 20:19:02 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070903001900.CBUD9971.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sun, 2 Sep 2007 20:19:00 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo01.cox.net with bizsmtp
	id jcK01X00F1gtr5g0000000; Sun, 02 Sep 2007 20:19:00 -0400
In-Reply-To: <20070902191644.29d46cd2.seanlkml@sympatico.ca>
	(seanlkml@sympatico.ca's message of "Sun, 2 Sep 2007 19:16:44 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57412>

Sean <seanlkml@sympatico.ca> writes:

> On Sun, 02 Sep 2007 15:13:09 -0700
> Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> For majority of general public, I thought the spec file _I_
>> ship, along with RPM files _I_ build, are contrib status
>> already.  Don't distro people do their own RPM packages, instead
>> of using what I placed on k.org?
>
> Didn't know you used RPM yourself, so I guess this is just
> a case of something slipping through rather than the spec file
> needing a maintainer.

Well, I do not _use_ it, but the RPM I have on k.org and mention
as part of the announcement are built by me by typing "make
rpm".  What I meant to say was that these RPM files may not be
"official" at all from the point of view of distro users, and I
suspect that distro "package maintainers" for git would not be
doing just a plain vanilla "make rpm" using the spec file that
comes as part of git.git repository.
