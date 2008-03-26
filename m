From: Junio C Hamano <gitster@pobox.com>
Subject: Re: slurping in guilt, was Re: [ANNOUNCE] Stacked GIT 0.14.2
Date: Wed, 26 Mar 2008 14:24:22 -0700
Message-ID: <7v1w5xch6h.fsf@gitster.siamese.dyndns.org>
References: <b0943d9e0803241259s5280cdc1o255a4412b3fa7bfc@mail.gmail.com>
 <alpine.LNX.1.10.0803242113070.9368@fbirervta.pbzchgretzou.qr>
 <47E81037.5030808@keyaccess.nl> <7vlk47ua3v.fsf@gitster.siamese.dyndns.org>
 <20080324235534.GE32221@josefsipek.net>
 <alpine.LSU.1.00.0803251048320.10660@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Sipek <jsipek@fsl.cs.sunysb.edu>, git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 26 22:26:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jed82-0002e6-BK
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 22:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759481AbYCZVYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 17:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762679AbYCZVYd
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 17:24:33 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65356 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762667AbYCZVYa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 17:24:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B37A51A3C;
	Wed, 26 Mar 2008 17:24:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C3E751A3B; Wed, 26 Mar 2008 17:24:25 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78314>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> [cutting down the Cc: list to the most-likely-interested parties]
>
> On Mon, 24 Mar 2008, Josef Sipek wrote:
>
>> On Mon, Mar 24, 2008 at 01:43:00PM -0700, Junio C Hamano wrote:
>>
>> > Not my mumbling, but I am quite open to slurp in guilt as a 
>> > subdirectory in git.git at some point in the future just like we 
>> > bundle git-gui and gitk if asked by the maintainer.
>>
>> That'd be great!  Is there anything special you want me to do?  Well, I 
>> want to finish up a merge I've been working on first.
>
> Would it not be more appropriate to slurp it in as a subproject?  But then 
> the same grace period as for git-gui and gitk would apply, since we still 
> expect some users not to have a submodule capable git...

All true.  On the other hand we could start with a subtree merge and later
switch.

In any case, the answer to Josef's question is to make sure I won't hear
objections on the list that say "No, the stuff is still too premature to
live in git.git itself and needs this and that fixups to be usable for the
general public." ;-) IOW, keep up the good work.  Gathering a bit more
followers, preferably outside this mailing list (such as wine, x.org
and/or the kernel community), would not hurt.
