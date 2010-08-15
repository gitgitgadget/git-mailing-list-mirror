From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] reset: Better warning message on git reset --mixed <paths>
Date: Sun, 15 Aug 2010 11:43:59 +0900
Message-ID: <87tymwzjbk.fsf@catnip.gol.com>
References: <1281814499-11797-1-git-send-email-avarab@gmail.com>
	<20100814210505.GA2372@burratino>
	<7vvd7chcj4.fsf@alter.siamese.dyndns.org>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
	<avarab@gmail.com>, git@vger.kernel.org,
	Ralf Ebert <info@ralfebert.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 15 04:53:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkTLS-0001aF-0S
	for gcvg-git-2@lo.gmane.org; Sun, 15 Aug 2010 04:53:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757913Ab0HOCxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Aug 2010 22:53:04 -0400
Received: from smtp12.dentaku.gol.com ([203.216.5.74]:36520 "EHLO
	smtp12.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757864Ab0HOCxD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Aug 2010 22:53:03 -0400
X-Greylist: delayed 530 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Aug 2010 22:53:03 EDT
Received: from 218.231.154.125.eo.eaccess.ne.jp ([218.231.154.125] helo=catnip.gol.com)
	by smtp12.dentaku.gol.com with esmtpa (Dentaku)
	id 1OkTCa-0007jf-VJ; Sun, 15 Aug 2010 11:44:01 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 0678FDF93; Sun, 15 Aug 2010 11:44:00 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <7vvd7chcj4.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 14 Aug 2010 18:47:59 -0700")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153593>

Junio C Hamano <gitster@pobox.com> writes:
>>  warning: --mixed with paths is deprecated; use 'git reset -- <paths>' instead
>
> That sounds helpful.
>
> We've been saying this form is deprecated since 1.5.4; a better
> alternative may be to make this into an error in the next release,
> though.

On a similar note, how about a more helpful error message for
"git reset --hard PATH"?  It took me _ages_ to figure out that I
needed to do "git checkout PATH" to get that effect...

e.g.:

   $ git reset --hard load-lua.cc
   fatal: --hard cannot be used with paths; use "git checkout -- <paths> instead"

-Miles

-- 
Brain, n. An apparatus with which we think we think.
