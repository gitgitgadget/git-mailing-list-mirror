From: "James Henstridge" <james@jamesh.id.au>
Subject: Re: VCS comparison table
Date: Mon, 23 Oct 2006 23:01:42 +0800
Message-ID: <a7e835d40610230801m4ac92409gbddcf66dcd1bb429@mail.gmail.com>
References: <45357CC3.4040507@utoronto.ca>
	 <200610222206.13973.jnareb@gmail.com>
	 <1161604564.22276.173.camel@zepto.home.zettazebra.com>
	 <200610231454.06355.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "David Clymer" <david@zettazebra.com>,
	bazaar-ng@lists.canonical.com,
	"Matthew D. Fuller" <fullermd@over-yonder.net>,
	"Linus Torvalds" <torvalds@osdl.org>,
	"Carl Worth" <cworth@cworth.org>, "Andreas Ericsson" <ae@op5.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 17:01:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc1JG-0004UE-4F
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 17:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbWJWPBq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 11:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964911AbWJWPBq
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 11:01:46 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:22387 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964890AbWJWPBp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 11:01:45 -0400
Received: by ug-out-1314.google.com with SMTP id o38so1270612ugd
        for <git@vger.kernel.org>; Mon, 23 Oct 2006 08:01:43 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=BrKsnqshdeqTP9C9sflhUGcjZz/5OWW2vNBOqsEfYmrPdR3TcYbRpcNrfljuzxNj/WK8jaCAEEXCItRCrMkSDSem/CUHB66EjXiA2wNnGY8C2bhyk93tjfwo7mwF6tDRh3Hz4j2z1eAFu7C0wkT0V3RWX3INORQEZKD+/aJOAck=
Received: by 10.82.135.13 with SMTP id i13mr1347141bud;
        Mon, 23 Oct 2006 08:01:43 -0700 (PDT)
Received: by 10.82.108.1 with HTTP; Mon, 23 Oct 2006 08:01:42 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <200610231454.06355.jnareb@gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 77f88de7a1276575
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29834>

On 23/10/06, Jakub Narebski <jnareb@gmail.com> wrote:
> First, bzr is biased towards using revnos: bzr commands uses revnos
> by default to provide revision (you have to use revid: prefix/operator
> to use revision identifiers), bzr commands outputs revids only when
> requested, examples of usage uses revision numbers.

As has been said before, you can set an alias to always show revision
IDs in "bzr log" output.


> In order to use revnos as _global_ identifiers in distributed development,
> you need central "branch", mainline, to provide those revnos. You have
> either to have access to this "revno server" and refer to revisions by
> "revno server" URL and revision number, or designate one branch as holding
> revision numbers ("revno server") and preserve revnos on "revno server"
> by using bzr "merge", while copying revnos when fetching by using bzr "pull"
> for leaf branches. In short: for revnos to be global identifiers you need
> star-topology.

Why do you continue to repeat this argument?  No one is claiming that
a revision number by itself, as Bazaar uses them, is a global
identifier.  In fact, we keep on saying that they only have meaning in
the context of a branch.  If you want to use a revision number as part
of a globally unique identifier, it needs to be in combination with
its branch.


> Even if you use revnos only locally, you need to know which revisions are
> "yours", i.e. beside branch as DAG of history of given revision you need
> "ordered series of revisions" (to quote Bazaar-NG wiki Glossary), or path
> through this diagram from given revision to one of the roots (initial,
> parentless revisions). Because bzr does that by preserving mentioned path
> as first-parent path (treating first parent specially), i.e. storing local
> information in a DAG (which is shared), to preserve revnos you need to
> use "merge" instead of "pull", which means that you get empty-merge in
> clearly fast-forward case. This means "local changes bias", which some
> might take as not being fully distributed.

I won't dispute that Bazaar has features that make it easier to work
with the revisions in the line of development of the branch you're
working on in comparison to the revisions from merges.  But given that
every Bazaar branch has this same bias towards their own main line of
development, how can that affect whether or not it is distributed?

James.
