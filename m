X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: Collection of stgit issues and wishes
Date: Wed, 13 Dec 2006 08:22:00 +0100
Message-ID: <87y7pc2rc7.fsf@morpheus.local>
References: <20061208221744.GA3288@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0612120143j7d0c1026rab046c8f44ec43ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 13 Dec 2006 10:11:32 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 4423 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 05:11:23 EST
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 19
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: vtab.com
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:io3YQTW1p4/FfqySX6jaDekZ0Jo=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34198>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuR5D-0002ij-2q for gcvg-git@gmane.org; Wed, 13 Dec
 2006 11:11:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964832AbWLMKLY convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006 05:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932641AbWLMKLY
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 05:11:24 -0500
Received: from main.gmane.org ([80.91.229.2]:37216 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932639AbWLMKLX
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006 05:11:23 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GuPvh-0001h7-Pj for git@vger.kernel.org; Wed, 13 Dec 2006 09:57:33 +0100
Received: from vtab.com ([62.20.90.195]) by main.gmane.org with esmtp (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 13 Dec 2006
 09:57:33 +0100
Received: from davidk by vtab.com with local (Gmexim 0.1 (Debian)) id
 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 13 Dec 2006 09:57:33 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

"Catalin Marinas" <catalin.marinas@gmail.com> writes:

> On 08/12/06, Yann Dirson <ydirson@altern.org> wrote:
>> - shortcuts (st -> status, etc.), possibly making use of the git ali=
as
>> system ?
>
> Did this last night as it was pretty easy and without the GIT alias
> system (which I am not familiar with). The idea is that if it cannot
> find an exact match, it tries to look for all the commands starting
> with the passed argument. If more than one command is found, it
> reports an "ambiguous command".

That approach can cause problems later on.  If "stgit st" is currently
a unique prefix of "stgit status", people might use it in scripts.
Then, one day, you add the "stgit store" command, or whatever, and
their scripts start breaking for no good reason.

--=20
David K=C3=A5gedal
