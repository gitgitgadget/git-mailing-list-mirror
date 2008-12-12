From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Nov 2008, #06; Wed, 26)
Date: Thu, 11 Dec 2008 19:12:53 -0800
Message-ID: <7vmyf29jd6.fsf@gitster.siamese.dyndns.org>
References: <7v7i6qc8r0.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0811290502j5db4056fo9b125aaa8b564314@mail.gmail.com>
 <fcaeb9bf0811300229v4e7bfbb7g9a0ac72dcddb4326@mail.gmail.com>
 <alpine.LNX.1.00.0811301509070.19665@iabervon.org>
 <fcaeb9bf0812060926r2ee443bfl3adb3f2d1129e5b8@mail.gmail.com>
 <alpine.LNX.1.00.0812061238260.19665@iabervon.org>
 <fcaeb9bf0812070427s64438216s41bf1294aa6398a3@mail.gmail.com>
 <alpine.LNX.1.00.0812071455020.19665@iabervon.org>
 <fcaeb9bf0812080451k6e213d0fo8d1da9bbac872649@mail.gmail.com>
 <alpine.LNX.1.00.0812081223140.19665@iabervon.org>
 <fcaeb9bf0812110504u1acfb612he3edae1df3774045@mail.gmail.com>
 <alpine.LNX.1.00.0812111520490.19665@iabervon.org>
 <7vy6ym9nm8.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0812112045120.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Dec 12 04:14:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAyU2-0002YV-P1
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 04:14:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757553AbYLLDNG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 22:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757521AbYLLDNF
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 22:13:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34747 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757007AbYLLDNE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 22:13:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0E2F91A1C3;
	Thu, 11 Dec 2008 22:13:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E94171A1C7; Thu,
 11 Dec 2008 22:12:54 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0812112045120.19665@iabervon.org> (Daniel
 Barkalow's message of "Thu, 11 Dec 2008 21:40:47 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C916F48E-C7FA-11DD-8B67-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102884>

Daniel Barkalow <barkalow@iabervon.org> writes:

> "git diff" is an ambiguous model for "git grep". It equally describes 
> the behavior of "git diff" to say that it treats files outside the 
> checkout area as matching the index or to say that it never lists files 
> outside the checkout area. On the other hand, there is the question of 
> whether "git diff branch1 branch2" shows differences that are outside the 
> checkout area, and whether "git log" shows commits that only change things 
> outside the checkout area, and "git grep" should match the behavior of 
> these.

Sure, but as "sparse" does not (again, "it should not, at least to me")
change the fact that git is about tracking the history of whole tree, not
just a single file, nor just a subset of files, none of these operations
should be affected about what the checkout area is.
