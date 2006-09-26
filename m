From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: tree view: eliminate redundant "blob"
Date: Tue, 26 Sep 2006 13:14:33 -0700 (PDT)
Message-ID: <20060926201433.46979.qmail@web31810.mail.mud.yahoo.com>
References: <efapsl$e65$1@sea.gmane.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Sep 26 22:16:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSJKA-000672-BG
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 22:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWIZUOf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 16:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964778AbWIZUOf
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 16:14:35 -0400
Received: from web31810.mail.mud.yahoo.com ([68.142.207.73]:15285 "HELO
	web31810.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964776AbWIZUOe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 16:14:34 -0400
Received: (qmail 46981 invoked by uid 60001); 26 Sep 2006 20:14:33 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=RBqjy7tY1lT6ifcvKGINNTxwOtJCCI2AjzaZVQlwkmHKVB7/rx9NBmDQLA+GSbXvKLGQbSA27Ccz9VinqZ89WP35u10kri4a7/FnCcvRD8m/qoOPubFrItA+8Kh99C/aoTPj9kFjjMO/5dlxnmv+0SR/EPT6ShBN7pcyzbpn0Lw=  ;
Received: from [64.215.88.90] by web31810.mail.mud.yahoo.com via HTTP; Tue, 26 Sep 2006 13:14:33 PDT
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
In-Reply-To: <efapsl$e65$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27815>

--- Jakub Narebski <jnareb@gmail.com> wrote:
> I'd rather not. The fact that the file name and tree name is link,
> and the fact that commit title and tag title is link is a _convenience_.
> Not always it is visible (without mouseover) that it is link.
> And it is _not_ visible in the case of files!
> 
> And for example for commits and heads there are two possible
> views, commit and commitdiff for commit, shortlog and log for head,
> of which we arbitrary chose one for the subject link. So in that
> case the additional self link is needed. I'd rather have both.
> And for consistency I'd rather always have visible form default
> self link/
> 
> I'd rather have additional link, than cause confusion to the users.
> Perhaps we could separate the self link ("blob" for files, "tree"
> for directories) into separate column?
> 
> Besides, you have to mouse over the name of file, or name of
> directory to see to what view it would lead on.

Jakub,

I understand your argument completely.  Underlining/coloring/etc
entities which are "links" themselves was very cool circa 1993 when
I took an HTML course (NSA Mosaic or rather...), transitioning from
"gopher" to the WWW.

Over the years I've seen a transition where web content is more and
more context sensitive, i.e. everything you can see is in some way
"clickable".  Be it letters, words, sentences, graphical objects of
some sort, etc.  If you could imagine: any web content being a "wiki
on steroids".

Generally, this WEB Development argument goes as follows:
    "There is no reason for anything to not be clickable."

Thus, I like the fact that gitweb is on the forefront of WEB development.
We should keep it like that.

    Luben

> 
> Nak.
> -- 
> Jakub Narebski
> Warsaw, Poland
> ShadeHawk on #git
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
