From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Considering teaching plumbing to users harmful
Date: Thu, 17 Jul 2008 12:10:00 -0700
Message-ID: <7vmykgfhtj.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
 <7vmykhpn6z.fsf@gitster.siamese.dyndns.org>
 <20080717155538.GE11759@fieldses.org>
 <alpine.DEB.1.00.0807171915420.8986@racer>
 <7vtzeofjpi.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807171940160.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 17 21:11:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJYse-00009p-Qy
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 21:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757604AbYGQTKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 15:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755050AbYGQTKI
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 15:10:08 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:32901 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757718AbYGQTKH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 15:10:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DC4032A74A;
	Thu, 17 Jul 2008 15:10:05 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 34F7E2A743; Thu, 17 Jul 2008 15:10:02 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807171940160.8986@racer> (Johannes
 Schindelin's message of "Thu, 17 Jul 2008 19:43:51 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F73B1ABA-5433-11DD-B9C1-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88904>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 17 Jul 2008, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> >> Is there a way to commit the contents of a tarball without using 
>> >> plumbing?  I occasionally want to track an upstream that I know only 
>> >> as a series of tarballs, so I do something like:
>> >> 
>> >> 	cd repo/
>> >> 	git checkout upstream
>> >> 	rm -rf *
>> >> 	tar -xzvf ../new-version.tar.gz
>> >
>> > How about "git add -u" and "git add ."?
>> 
>> It would work only if new version never removes files.
>
> You made me doubt for a second there.  But "git add -u" updates the index 
> when a tracked files was deleted.  So after "rm -rf *", "git add -u" would 
> empty the index.

I thought everybody would react to my message like so after sending it ;-)
What I failed to say was that the main uneasiness about the above command
sequence Bruce or anybody would have felt would be that "rm -fr *" step,
which in itself look scary and does not remove .frotz that came from older
version.
