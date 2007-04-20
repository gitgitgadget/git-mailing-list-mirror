From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-add -u: match the index with working tree.
Date: Fri, 20 Apr 2007 04:16:08 -0700
Message-ID: <7virbrz47b.fsf@assigned-by-dhcp.cox.net>
References: <11770585393395-git-send-email-junkio@cox.net>
	<20070420104930.GB13560@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Apr 20 13:16:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Her66-0003Db-0x
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 13:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754449AbXDTLQL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 20 Apr 2007 07:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754467AbXDTLQL
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 07:16:11 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:42168 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754449AbXDTLQK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Apr 2007 07:16:10 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070420111611.DMMM1218.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Fri, 20 Apr 2007 07:16:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id pPG91W00D1kojtg0000000; Fri, 20 Apr 2007 07:16:09 -0400
In-Reply-To: <20070420104930.GB13560@diana.vm.bytemark.co.uk> (Karl
	=?utf-8?Q?Hasselstr=C3=B6m's?= message of "Fri, 20 Apr 2007 12:49:30
 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45087>

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

Haven't I explain that elsewhere already?
