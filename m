From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-add -u: match the index with working tree.
Date: Fri, 20 Apr 2007 04:17:51 -0700
Message-ID: <7vejmfz44g.fsf@assigned-by-dhcp.cox.net>
References: <11770585393395-git-send-email-junkio@cox.net>
	<20070420104930.GB13560@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Apr 20 13:18:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Her7k-0003um-Is
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 13:17:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992531AbXDTLRy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 20 Apr 2007 07:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992549AbXDTLRx
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 07:17:53 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:45316 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992531AbXDTLRx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Apr 2007 07:17:53 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070420111754.BIGA1266.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Fri, 20 Apr 2007 07:17:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id pPHs1W00D1kojtg0000000; Fri, 20 Apr 2007 07:17:52 -0400
In-Reply-To: <20070420104930.GB13560@diana.vm.bytemark.co.uk> (Karl
	=?utf-8?Q?Hasselstr=C3=B6m's?= message of "Fri, 20 Apr 2007 12:49:30
 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45088>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> On 2007-04-20 01:42:18 -0700, Junio C Hamano wrote:
>
>> This is a shorthand of what "git commit -a" does in preparation
>> for making a commit,
> [snip]
>> -"git-add [-n] [-v] [-f] [--interactive | -i] [--] <filepattern>..."=
;
>> +"git-add [-n] [-v] [-f] [--interactive | -i] [-u] [--] <filepattern=
>...";
>
> Any particular reason for choosing a different letter than the
> -a/--all that git commit uses?

I picked "-u" instead of "-a" because I wanted to stress that
this is about "updating" (which has connotation that it is
relative to something, and in this case it is relative to the
current "index"), and not about "all", which "-a" would imply.
