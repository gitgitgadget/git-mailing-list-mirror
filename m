From: Miles Bader <miles@gnu.org>
Subject: Re: way to automatically add untracked files?
Date: Tue, 07 Aug 2007 09:08:35 +0900
Message-ID: <87y7goryt8.fsf@catnip.gol.com>
References: <873ayymzc1.fsf@catnip.gol.com>
	<fc339e4a0708042100jdf0a0f1jd1fddfb5dc1c1052@mail.gmail.com>
	<20070805041320.GH9527@spearce.org>
	<7vwsw9capl.fsf@assigned-by-dhcp.cox.net>
	<85tzrcfrue.fsf@lola.goethe.zz>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Aug 07 02:09:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IICdK-00085V-Qv
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 02:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932666AbXHGAIx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 20:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbXHGAIw
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 20:08:52 -0400
Received: from smtp02.dentaku.gol.com ([203.216.5.72]:35136 "EHLO
	smtp02.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932121AbXHGAIw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 20:08:52 -0400
Received: from 203-216-96-074.dsl.gol.ne.jp ([203.216.96.74] helo=catnip.gol.com)
	by smtp02.dentaku.gol.com with esmtpa (Dentaku)
	id 1IICcm-0001Xz-2t; Tue, 07 Aug 2007 09:08:36 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 977A2300F; Tue,  7 Aug 2007 09:08:35 +0900 (JST)
System-Type: i686-pc-linux-gnu
In-Reply-To: <85tzrcfrue.fsf@lola.goethe.zz> (David Kastrup's message of "Mon\, 06 Aug 2007 20\:19\:53 +0200")
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55191>

David Kastrup <dak@gnu.org> writes:
>> I am not opposed to have "git add -a $paths"
>> which would do something like "git add $paths && git add -u $paths".
>
> I'm all for it.

Me too... :-)

[I think it's good that it be part of the "add" command (instead of a
separate command/alias), because a new user stands a better chance of
finding it in the documentation... when I was trying to figure out how
to do this by myself, I certainly started by reading the man page for
git-add!]

Thanks,

-Miles

-- 
((lambda (x) (list x x)) (lambda (x) (list x x)))
