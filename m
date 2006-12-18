X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-1.5 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RCVD_NUMERIC_HELO,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Jerome Lovy <t2a2e9z8ncbs9qg@brefemail.com>
Subject: Re: [RFC] A unique way to express "all" (vs "add vs "update") ?
Date: Mon, 18 Dec 2006 15:04:06 +0100
Message-ID: <45869FD6.3030104@brefemail.com>
References: <elu1cn$k3$1@sea.gmane.org> <87mz5o4v2v.wl%cworth@cworth.org>
Reply-To: t2a2e9z8ncbs9qg@brefemail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 18 Dec 2006 23:35:07 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 31
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 212.11.48.246
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <87mz5o4v2v.wl%cworth@cworth.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34764>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwJ50-0002LV-S9 for gcvg-git@gmane.org; Mon, 18 Dec
 2006 15:02:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754035AbWLROCq convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006 09:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754034AbWLROCq
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 09:02:46 -0500
Received: from main.gmane.org ([80.91.229.2]:54910 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1754035AbWLROCp
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006 09:02:45 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GwJ4Y-0002Fz-9r for git@vger.kernel.org; Mon, 18 Dec 2006 15:02:30 +0100
Received: from 212.11.48.246 ([212.11.48.246]) by main.gmane.org with esmtp
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 18
 Dec 2006 15:02:30 +0100
Received: from t2a2e9z8ncbs9qg by 212.11.48.246 with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 18 Dec 2006
 15:02:30 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Carl Worth wrote:
> On Fri, 15 Dec 2006 12:38:51 +0100, Jerome Lovy wrote:
>> While I am very happy with the refactorings undertaken with regard t=
o
>> "git add/git commit" (both for UI and documentation), I am still a
>> little confused by the different ways I seem to find to express the =
idea
>> "I want to add (sort of) all file contents".
>=20
> I agree that there have been huge improvements---particularly in
> documentation. So thanks to everybody!
>=20
> Here's a simpler idea that might add the unification you're looking
> for. How about a new option:
>=20
> 	git add -a|--all
>=20
> This would allow "git commit -a|--all" to be understood as a simple
> helper for:
>=20
> 	git add -a|--all
> 	git commit
>=20
> That kind of unification seems like it could be helpful while learnin=
g
> things.
Exactly. I like it.

Now, it underlines the fact that this "--all" should IMHO rather be
called "--all-known" or the like - both for "add" and "commit" - but al=
l
the same, I would be very happy with a more complete "git add" followin=
g
your proposed unification.

J=E9r=F4me
