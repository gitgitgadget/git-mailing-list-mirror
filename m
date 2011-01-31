From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] merge: default to @{upstream}
Date: Mon, 31 Jan 2011 10:55:49 +0900
Message-ID: <87hbcp25wa.fsf@catnip.gol.com>
References: <1296231457-18780-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 31 03:04:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pjj8L-0005vg-NA
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 03:04:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552Ab1AaCEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Jan 2011 21:04:39 -0500
Received: from smtp12.dentaku.gol.com ([203.216.5.74]:48971 "EHLO
	smtp12.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752400Ab1AaCEi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jan 2011 21:04:38 -0500
X-Greylist: delayed 521 seconds by postgrey-1.27 at vger.kernel.org; Sun, 30 Jan 2011 21:04:38 EST
Received: from 218.33.195.219.eo.eaccess.ne.jp ([218.33.195.219] helo=catnip.gol.com)
	by smtp12.dentaku.gol.com with esmtpa (Dentaku)
	(envelope-from <miles@gnu.org>)
	id 1Pjizf-000088-AM; Mon, 31 Jan 2011 10:55:51 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 069A4DF93; Mon, 31 Jan 2011 10:55:50 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <1296231457-18780-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Fri, 28 Jan 2011 18:17:37 +0200")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165715>

Felipe Contreras <felipe.contreras@gmail.com> writes:
> So 'git merge' is 'git merge @{upstream}' instead of 'git merge -h';
> it's better to do something useful.

I totally agree -- this would be a good change[*] -- but this suggestion
has been made before, and always gets shot down for vaguely silly
reasons...

I often do "git fetch; <see what changed upstream>; git pull".  I think
this is probably not a rare pattern, when one is working with other
people via a shared upstream.

The git-pull is obviously slightly risky because another change could
have happened after the fetch, but I use that instead of "git-merge"
because git-pull's defaults make it very convenient ... and _usually_
there's no issue...  If git-merge had proper defaults (as you suggest),
it would be exactly as convenient as git-pull (and _less_ dangerous), so
I'd use that instead.

[and, no, saying "you can add an alias!" is not a reasonable answer --
git should be convenient by default!]

-Miles

-- 
Hers, pron. His.
