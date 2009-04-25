From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 2/2] diff: color statistics (stat, shortstat, numstat)
Date: Sat, 25 Apr 2009 13:09:39 +0200
Message-ID: <200904251309.39816.markus.heidelberg@web.de>
References: <200904222313.50081.markus.heidelberg@web.de> <1240610808-7285-2-git-send-email-markus.heidelberg@web.de> <7vbpqlac6n.fsf@gitster.siamese.dyndns.org>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 13:14:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxfoR-0001aa-TE
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 13:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161AbZDYLJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2009 07:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752064AbZDYLJm
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 07:09:42 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:48388 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562AbZDYLJl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2009 07:09:41 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 971C1FDB079D;
	Sat, 25 Apr 2009 13:09:40 +0200 (CEST)
Received: from [89.59.73.176] (helo=.)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LxflM-0000TW-00; Sat, 25 Apr 2009 13:09:40 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <7vbpqlac6n.fsf@gitster.siamese.dyndns.org>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19RBzbqrG1QqM1q4nmTwUQPkrFQz1b9ouFsZ4cC
	9Jmy4TKg8hgtKa24gLXy58DObWu2mv1uybYIBx681HQx/9x6Pz
	h+dEZJn1o4N0Z0Z/Bssg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117546>

Junio C Hamano, 25.04.2009:
> Markus Heidelberg <markus.heidelberg@web.de> writes:
> 
> > stat/shortstat:
> > Color added and removed lines and the corresponding signs ('+' and '-')
> > in the summary.
> >
> > numstat:
> > Color added and removed lines per file.
> 
> I find this extremely unreadable.

I know one can overdo it with colors, but I don't think it's the case
for the stat/shortstat summary line here. Of course this is very
subjective and if the consensus is not to have colors there, then it's OK.

> Also numstat being for porcelain use, I
> do not see the point.

It gives you an information that --stat doesn't give you: the exact
count of added and removed lines per file. Also for long path names you
don't have to bother with --stat=x,y

Having said this, I have to admit that I didn't use it myself up to now.

> I think [1/2] that removes the (plain)coloring of the stat summary text is
> Ok.

Do you mean the whole patch 1/2 is OK or only the summary part and the
filenames should stay with plain coloring? I think the former.

> The code is painting the stat summary in the same color as the
> filenames in the stat graph, and the default "plain" color happens to be
> "do not color--just use the terminal default", so it probably does not
> have any practical difference.

Eh, yes, for people setting color.diff.plain
