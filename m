From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: Re: git log for only certain branches
Date: Tue, 08 Apr 2014 19:18:05 +0200
Message-ID: <87bnwb4u5u.fsf@steelpick.2x.cz>
References: <CAHd499BSgxZ8EC1qKYRsF0hac6rQAegw9qTOoDjaiuh_UUVEng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 08 19:18:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXZf8-0001jY-Ke
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 19:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756164AbaDHRSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 13:18:13 -0400
Received: from max.feld.cvut.cz ([147.32.192.36]:47737 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754579AbaDHRSM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2014 13:18:12 -0400
Received: from localhost (unknown [192.168.200.7])
	by max.feld.cvut.cz (Postfix) with ESMTP id 3E9DC3CFED9;
	Tue,  8 Apr 2014 19:18:11 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.7]) (amavisd-new, port 10044)
	with ESMTP id ZptmjBYo0SHa; Tue,  8 Apr 2014 19:18:06 +0200 (CEST)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id 007363CFED1;
	Tue,  8 Apr 2014 19:18:05 +0200 (CEST)
Received: from wsh by steelpick.2x.cz with local (Exim 4.82)
	(envelope-from <sojkam1@fel.cvut.cz>)
	id 1WXZev-000633-Nr; Tue, 08 Apr 2014 19:18:05 +0200
In-Reply-To: <CAHd499BSgxZ8EC1qKYRsF0hac6rQAegw9qTOoDjaiuh_UUVEng@mail.gmail.com>
User-Agent: Notmuch/0.17 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245935>

On Tue, Apr 08 2014, Robert Dailey wrote:
> I have more details about my inquiry on StackOverflow:
> http://stackoverflow.com/questions/22823768/view-git-log-with-merges-for-only-certain-branches
>
> Basically I'd like to know if it is possible to show the graph for
> ONLY branches that I list. The key here is that the graph should also
> show relationships between only those branches that I list. In other
> words, any ancestors that I do not explicitly specify should not be
> rendered in the graph.

What about using ^<branch> notation to exclude certain branches? See for
example SPECIFYING RANGES in git-rev-parse(1).

-Michal
