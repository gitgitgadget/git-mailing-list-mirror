From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Shell script cleanups/style changes?
Date: Thu, 02 Aug 2007 14:12:26 -0700
Message-ID: <7v1welvdxh.fsf@assigned-by-dhcp.cox.net>
References: <86bqdqkygp.fsf@lola.quinscape.zz>
	<7vlkctvfk9.fsf@assigned-by-dhcp.cox.net>
	<fcaeb9bf0708021356v57b29a70yb69a2fa000bd5b55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "David Kastrup" <dak@gnu.org>, git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 23:13:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGhzE-0000tT-OK
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 23:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760543AbXHBVMb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 17:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755680AbXHBVMa
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 17:12:30 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:40937 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755487AbXHBVMa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 17:12:30 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070802211228.TMNB1428.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Thu, 2 Aug 2007 17:12:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id X9CS1X00Y1kojtg0000000; Thu, 02 Aug 2007 17:12:27 -0400
In-Reply-To: <fcaeb9bf0708021356v57b29a70yb69a2fa000bd5b55@mail.gmail.com>
	(Nguyen Thai Ngoc Duy's message of "Thu, 2 Aug 2007 16:56:48 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54612>

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

> On 8/2/07, Junio C Hamano <gitster@pobox.com> wrote:
>> Non POSIX substitions such as ${parameter/pattern/string} and
>> ${parameter:offset} are not to be used.  We do not want to
>> depend on bash.
>
> There is in a test (t5300-pack-objects.sh) but I guess the
> restrictions do not apply on tests.

That would have been an earlier mistake.  Keeping tests portable
is important, perhaps it might be of lessor importance but
still.
