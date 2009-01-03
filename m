From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: "git reset --hard" == "git checkout HEAD" == "git reset --hard
 HEAD" ???
Date: Sat, 3 Jan 2009 06:02:21 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngltvrd.63u.sitaramc@sitaramc.homelinux.net>
References: <20090102195724.GA23119@seberino.org>
 <7v4p0hcp3w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 03 07:04:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIzcK-0005t8-C6
	for gcvg-git-2@gmane.org; Sat, 03 Jan 2009 07:04:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbZACGCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2009 01:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbZACGCi
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jan 2009 01:02:38 -0500
Received: from main.gmane.org ([80.91.229.2]:52050 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750767AbZACGCi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2009 01:02:38 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LIzai-0006NM-Kj
	for git@vger.kernel.org; Sat, 03 Jan 2009 06:02:32 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 Jan 2009 06:02:32 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 Jan 2009 06:02:32 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104454>

On 2009-01-02, Junio C Hamano <gitster@pobox.com> wrote:
> chris@seberino.org writes:
>
>> Does "git reset --hard" == "git checkout HEAD" == "git reset --hard HEAD" ???
>
> No, but "reset --hard" without a commit-ish defaults to HEAD so the first
> one and the last one are equivalent.
>
>> It seems we have 2 ways to blow away work we haven't
>> checked in yet then right?
>
> Wrong.

Strictly as asked, yes, but what if he adds a "-f" to the
middle command, making it "git checkout -f HEAD"?  Wouldn't
that be the same as the others then?

I always thought they were eqvt...
