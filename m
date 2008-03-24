From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [ANNOUNCE] Stacked GIT 0.14.2
Date: Tue, 25 Mar 2008 00:23:20 +0100
Message-ID: <47E837E8.7000606@keyaccess.nl>
References: <b0943d9e0803241259s5280cdc1o255a4412b3fa7bfc@mail.gmail.com>	 <alpine.LNX.1.10.0803242113070.9368@fbirervta.pbzchgretzou.qr>	 <47E81037.5030808@keyaccess.nl>	 <7vlk47ua3v.fsf@gitster.siamese.dyndns.org>	 <47E82BDD.9060507@keyaccess.nl> <b0943d9e0803241550k3ef0dbe8nae3b00bac34fa20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jan Engelhardt <jengelh@computergmbh.de>,
	git <git@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Josef Sipek <jsipek@fsl.cs.sunysb.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 00:23:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdw0X-0004XJ-NG
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 00:23:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755783AbYCXXWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 19:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756360AbYCXXWI
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 19:22:08 -0400
Received: from smtpq2.groni1.gr.home.nl ([213.51.130.201]:58581 "EHLO
	smtpq2.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756030AbYCXXWH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 19:22:07 -0400
Received: from [213.51.130.190] (port=48710 helo=smtp1.groni1.gr.home.nl)
	by smtpq2.groni1.gr.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>)
	id 1JdvzP-0007KJ-PW; Tue, 25 Mar 2008 00:22:03 +0100
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:50408 helo=[192.168.0.3])
	by smtp1.groni1.gr.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>)
	id 1JdvzO-0002gE-T0; Tue, 25 Mar 2008 00:22:03 +0100
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <b0943d9e0803241550k3ef0dbe8nae3b00bac34fa20@mail.gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78124>

On 24-03-08 23:50, Catalin Marinas wrote:

> On 24/03/2008, Rene Herman <rene.herman@keyaccess.nl> wrote:
>> On 24-03-08 21:43, Junio C Hamano wrote:

>>  >> On 24-03-08 21:15, Jan Engelhardt wrote:

>>  >>> I always wondered what the difference between stgit and guilt is.
>>  >>> Does anyone have a comparison up?
>>  >> And I remember some mumblings about git growing quilt-like
>>  >> functionality itself. Anything on that?
>>  >
>>  > Not my mumbling
>>
>>
>> Believe it was Linus. Seem to remember him saying something about possibly
>> adding a native queues-like interface not too long ago but it's proving
>> impossible to google for.
> 
> It was Linus indeed, on the linux-arch mailing list:
> 
> http://www.mail-archive.com/linux-arch@vger.kernel.org/msg05012.html

Probably read it on linux-kernel but yes, that was the one, thanks much. 
Stored it as an interesting something -- used to use quilt and although I 
didn't much care for its linear nature when managing an entire tree, it 
probably works out well for private topic branches. Not overly sure of added 
practical value over git rebase, but I did like the simple nature of 
shuffling things around by just editing a series file back when I was using 
quilt. Keeps one on top of things, so to speak (<-- amusing play on words).

Moreover not too keen on using many tools do do one thing, so getting this 
inside git itself sounded like a possibly nice notion.

Rene.
