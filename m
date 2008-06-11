From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: git bugs
Date: Wed, 11 Jun 2008 14:46:34 +0200
Message-ID: <20080611124634.GA26729@cuci.nl>
References: <832adb090806100141n69c086a2v2f59fe94b2f4ead3@mail.gmail.com> <alpine.LFD.1.10.0806101028040.3101@woody.linux-foundation.org> <832adb090806101145w55729676ya7bcfb41b0413f59@mail.gmail.com> <alpine.LFD.1.10.0806101249580.3101@woody.linux-foundation.org> <832adb090806101609q17a21948nb5814c3b22bd832d@mail.gmail.com> <7v1w34dfn3.fsf@gitster.siamese.dyndns.org> <832adb090806101702l79aba80cvba1eaab029e9ecd5@mail.gmail.com> <7vwskwbz63.fsf@gitster.siamese.dyndns.org> <832adb090806101724k6199694ftbbc6ed151489a6e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Ben Lynn <benlynn@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 14:47:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6Pji-0007yG-Bi
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 14:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbYFKMqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 08:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbYFKMqj
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 08:46:39 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:53413 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbYFKMqj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 08:46:39 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 17299545E; Wed, 11 Jun 2008 14:46:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <832adb090806101724k6199694ftbbc6ed151489a6e3@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84605>

Ben Lynn wrote:
>That is problematic. How do I figure out what the filesystem thinks is
>the current time? I could touch some file and read its mtime, but I
>want a shortcut.

That basically is as short as it gets, except perhaps statting a freshly
modified file (not necessarily by oneself).

>Are there any guarantees of any kind? e.g. is the filesystem current
>time at least never ahead of the system time?

Practically no guarantees, just that it is rather likely for the time at
the fileserver to progress at about the same pace as yours.
-- 
Sincerely,
           Stephen R. van den Berg.

Differentiation is an integral part of calculus.
