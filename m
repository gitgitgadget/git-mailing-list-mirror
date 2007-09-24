From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Supplant the "while case ... break ;; esac" idiom
Date: Mon, 24 Sep 2007 15:58:47 +0200
Message-ID: <86k5qgtbag.fsf@lola.quinscape.zz>
References: <853ax5mb1j.fsf@lola.goethe.zz> <85myvdktb3.fsf@lola.goethe.zz> <20070924060521.GB10975@glandium.org> <85k5qgk295.fsf@lola.goethe.zz> <ee77f5c20709232330n7b47d9e9v38677678dbf197da@mail.gmail.com> <86ejgowl5g.fsf@lola.quinscape.zz> <20070924080134.GA9112@artemis.corp> <20070924080436.GB9112@artemis.corp> <Pine.LNX.4.64.0709241128460.28395@racer.site> <87ps08s3zt.fsf@catnip.gol.com> <20070924113556.GI8111@void.codelabs.ru> <87k5qgrxcu.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 24 16:09:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZocU-00054J-QO
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 16:09:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbXIXOI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 10:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbXIXOI7
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 10:08:59 -0400
Received: from main.gmane.org ([80.91.229.2]:37463 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751308AbXIXOI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 10:08:58 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IZoWQ-00015h-30
	for git@vger.kernel.org; Mon, 24 Sep 2007 14:02:50 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 24 Sep 2007 14:02:50 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 24 Sep 2007 14:02:50 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:KKkxA8qylRRTXcrqAgMiV7gmVCY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59052>

Miles Bader <miles@gnu.org> writes:

> Eygene Ryabinkin <rea-git@codelabs.ru> writes:
>>> The comment "... holds only for a shell where [ is a builtin" doesn't
>>> make any sense to me
>>
>> The 'while case ...' construct does not invoke any external commands.
>> The 'while test ...' too, but only when 'test' is builtin.  When
>> 'test' is the external binary you get one additional fork/exec per
>> each cycle.
>
> In practice that's not an issue though -- every reasonable shell has
> test as a builtin these days, so the "works when test is not a builtin"
> criteria is really important only for robustness.

Since the external test is pretty standardized, "works when test is
one of various builtins" is actually more important for robustness...

-- 
David Kastrup
