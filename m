X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 03:43:21 +0100
Message-ID: <20061116024321.GP7201@pasky.or.cz>
References: <87hcx1u934.wl%cworth@cworth.org> <20061114194707.GH7201@pasky.or.cz> <87d57pu4qa.wl%cworth@cworth.org> <7v3b8lv9c9.fsf@assigned-by-dhcp.cox.net> <20061115040852.GL7201@pasky.or.cz> <7vd57ps51c.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142342160.2591@xanadu.home> <ejeotu$vrj$3@sea.gmane.org> <8aa486160611150215n64bb01e6o49aeaf243ad8f817@mail.gmail.com> <ejeq20$5hn$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 16 Nov 2006 02:45:29 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <ejeq20$5hn$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31545>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkXDt-0003P4-Ky for gcvg-git@gmane.org; Thu, 16 Nov
 2006 03:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162227AbWKPCnX convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006 21:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162234AbWKPCnX
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 21:43:23 -0500
Received: from w241.dkm.cz ([62.24.88.241]:58281 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1162227AbWKPCnX (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 21:43:23 -0500
Received: (qmail 5503 invoked by uid 2001); 16 Nov 2006 03:43:21 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On Wed, Nov 15, 2006 at 11:28:27AM CET, Jakub Narebski wrote:
> Santi B=E9jar wrote:
>=20
> > On 11/15/06, Jakub Narebski <jnareb@gmail.com> wrote:
>=20
> >> You mean
> >>
> >>       git merge git://repo.com/time_machine.git#branch
> >>
> >> don't you (perhaps with 'master' as default branch)?
> >=20
> > perhaps with remote 'HEAD' as default branch?
>=20
> No! HEAD might change without your notice, and you want to know
> which branch you merge. With remotes the default could be first
> branch in the pull/fetch list, but with bare URL...

No! If HEAD changed without your notice, it means that the remote
repository admin _wants_ you to start fetching another branch now.
Imagine a setup of these branches:

	phooey-1.2	legacy lineage
	phooey-2.0	last stable
	phooey-3.0	current development (no releases yet)
	phooey-4.0	stash for futuristic functionality, heavily
			experimental

In this case, HEAD now points to phooey-3.0 but when it becomes stable,
it would change to phooey-4.0.

The common practice of having 'master' pointing on whatever you
currently have now and and "cutting out" the branches from it at random
times is something heavily influenced by CVS where this is the only san=
e
way of branching (the cutting out even hardcoded in numbering scheme).
In more advanced systems, you may want to be much more flexible wrt. th=
is
(note that I'm not saying you necessarily _should_ be).

--=20
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=3Dunpack('H*',$_);$_=3D`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
