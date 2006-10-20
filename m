From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 14:01:33 +0200
Message-ID: <200610201401.33676.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <200610201157.22348.jnareb@gmail.com> <a7e835d40610200345o2ad83bb7k6dfc29867498971c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Aaron Bentley" <aaron.bentley@utoronto.ca>,
	"Andreas Ericsson" <ae@op5.se>,
	"Linus Torvalds" <torvalds@osdl.org>,
	"Carl Worth" <cworth@cworth.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 14:01:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gat4C-0000sl-VE
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 14:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946390AbWJTMBd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 08:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946400AbWJTMBd
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 08:01:33 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:53029 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1946390AbWJTMBc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 08:01:32 -0400
Received: by ug-out-1314.google.com with SMTP id o38so723340ugd
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 05:01:31 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WyNF1vuyotmXotn9gJfp491ppuhwLtFHqt6N5il/A8GwZgAYcN0CjWiCThIwnEC+u7kHKLgV2gHu90oWJE7VIwZMvYp88OJAzGSjoI7OdZEzohdDf8ph6d4LOFIH3YXsi3L1ehbOM0ZBKPFRiKz/ttMiJvw1mqW5NgwE6Yeqaio=
Received: by 10.66.242.20 with SMTP id p20mr1706507ugh;
        Fri, 20 Oct 2006 05:01:30 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id u1sm3755179uge.2006.10.20.05.01.29;
        Fri, 20 Oct 2006 05:01:30 -0700 (PDT)
To: "James Henstridge" <james@jamesh.id.au>
User-Agent: KMail/1.9.3
In-Reply-To: <a7e835d40610200345o2ad83bb7k6dfc29867498971c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29454>

James Henstridge wrote:
> On 20/10/06, Jakub Narebski <jnareb@gmail.com> wrote:
> > > What's nice is being able see the revno 753 and knowing that "diff -r
> > > 752..753" will show the changes it introduced. Checking the revo on a
> > > branch mirror and knowing how out-of-date it is.
> >
> > Huh? If you want what changes have been introduced by commit
> > c3424aebbf722c1f204931bf1c843e8a103ee143, you just do
> >
> > # git diff c3424aebbf722c1f204931bf1c843e8a103ee143
> >
> > (or better "git show" instead of "git diff" or "git diff-tree").
> > If you give only one commit (only one revision) git automatically
> > gives diff to its parent(s).
> 
> If a revision has multiple parents, what does it diff against in this
> case?  Do you get one diff against each parent revision?

If revision has multiple parents (is merge commit), git-diff
(which is used by git-show) does not show differences (unless you
give two revisions in git-diff case).

You can either use '-m' option to show differences from all its
parents, or '-c'/'--cc' to show combined diff ('--cc' shows more
compact diff).
-- 
Jakub Narebski
Poland
