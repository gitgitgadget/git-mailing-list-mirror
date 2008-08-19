From: Mark Struberg <struberg@yahoo.de>
Subject: Re: Call Me Gitless
Date: Tue, 19 Aug 2008 11:31:35 +0000 (GMT)
Message-ID: <660749.49882.qm@web27803.mail.ukl.yahoo.com>
References: <ee521d6f0808190157s6a676a75t2ba3ef095f608431@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?Peter_Valdemar_M=F8rch_=28Lists=29?= 
	<4ux6as402@sneakemail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Alexander E Genaud <alex@genaud.net>
X-From: git-owner@vger.kernel.org Tue Aug 19 13:32:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVPS5-0000bq-7G
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 13:32:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688AbYHSLbi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Aug 2008 07:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752654AbYHSLbh
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 07:31:37 -0400
Received: from web27803.mail.ukl.yahoo.com ([217.146.182.8]:46771 "HELO
	web27803.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752468AbYHSLbh convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 07:31:37 -0400
Received: (qmail 49925 invoked by uid 60001); 19 Aug 2008 11:31:35 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:X-Mailer:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=5g70s1qxnl+bNLZ2bWK7TLzbBjrZ5mc2SvSu2hgo4/wyjlhndBaPjHH5LiVUtcVT91mZ1Jrajt49xarlA8N9HNzUKxVrW43oKhs8v1kIHAu9ihoDUbgSCJoasGC1AsdjgN+5NviakekLrHRE/Y0Ru+cngV0Tad+KDfyXk2Pft9w=;
Received: from [81.19.198.7] by web27803.mail.ukl.yahoo.com via HTTP; Tue, 19 Aug 2008 11:31:35 GMT
X-Mailer: YahooMailWebService/0.7.218
In-Reply-To: <ee521d6f0808190157s6a676a75t2ba3ef095f608431@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92848>

Hi Alex!

--- Alexander E Genaud <alex@genaud.net> schrieb am Di, 19.8.2008:

> Von: Alexander E Genaud <alex@genaud.net>
> Betreff: Re: Call Me Gitless
> An: "Junio C Hamano" <gitster@pobox.com>
> CC: "Peter Valdemar M=F8rch (Lists)" <4ux6as402@sneakemail.com>, git@=
vger.kernel.org
> Datum: Dienstag, 19. August 2008, 10:57
> ...
> Remote never seems to do what I expect, so I manually edit
> the .git/refs!!=20
> Nor is git-reset what I expect and use git
> checkout (which
> does make sense only after a few backup trials). Git-add
> adds to the
> index but does not create, however git-rm removes from the
> index and
> does delete (an --index-only or --keep flag might be nice).

This is explicitely stated in the git-rm manpages: --cached:  Use this =
option to unstage and remove paths only from the index. Working tree fi=
les, whether modified or not, will be left alone.


> A single term for cache and index should be decided upon.
> git diff --cached is not intuitive when 'index' is used
> throughout the documentation.=20

The changes are "cached" in the "Index". But I wouldn't name the "Index=
" really a "Cache" because it is a lot more. All comments for --cached =
in the manpages mention the Index mechanism.=20
Additionally there is a more detailed introduction to the Index in sect=
ion 7 (Git concepts) of the Git User's Manual=20

LieGrue,
strub

__________________________________________________
Do You Yahoo!?
Sie sind Spam leid? Yahoo! Mail verf=FCgt =FCber einen herausragenden S=
chutz gegen Massenmails.=20
http://mail.yahoo.com=20
