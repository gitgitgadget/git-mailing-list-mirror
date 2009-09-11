From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/4] reset: use "unpack_trees()" directly instead of "git read-tree"
Date: Fri, 11 Sep 2009 07:34:13 +0200
Message-ID: <200909110734.13903.chriscool@tuxfamily.org>
References: <20090910200334.3722.20140.chriscool@tuxfamily.org> <20090910202333.3722.58409.chriscool@tuxfamily.org> <7v1vme2h2f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 07:33:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mlykp-0008Tw-Ak
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 07:33:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760AbZIKFcx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 01:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752353AbZIKFcx
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 01:32:53 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:34264 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752197AbZIKFcx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 01:32:53 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 9065D8180CE;
	Fri, 11 Sep 2009 07:32:47 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id AA5B38180FE;
	Fri, 11 Sep 2009 07:32:45 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7v1vme2h2f.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128174>

On Friday 11 September 2009, Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> > From: Stephan Beyer <s-beyer@gmx.net>
> >
> > This patch makes "reset_index_file()" call "unpack_trees()" directly
> > instead of forking and execing "git read-tree".
>
> And the reason why it is a good idea is...?

...that it should be faster.

Ok, I will add that to the commit message in the next version.

Thanks,
Christian.
