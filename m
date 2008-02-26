From: John Goerzen <jgoerzen@complete.org>
Subject: Re: git-email automatic --to detection?
Date: Tue, 26 Feb 2008 07:59:55 -0600
Message-ID: <slrnfs86qr.prc.jgoerzen@katherina.lan.complete.org>
References: <slrnfs3rv4.aqm.jgoerzen@katherina.lan.complete.org> <20080225183413.GA15131@sigill.intra.peff.net> <vpqoda43lva.fsf@bauges.imag.fr> <20080225205505.GY31441@genesis.frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 26 15:10:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU0W3-0006oW-0l
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 15:10:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756063AbYBZOKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 09:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754743AbYBZOKF
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 09:10:05 -0500
Received: from main.gmane.org ([80.91.229.2]:56057 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755929AbYBZOKE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 09:10:04 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JU0VO-0001Ts-AE
	for git@vger.kernel.org; Tue, 26 Feb 2008 14:10:02 +0000
Received: from 63-245-179-205.kitusa.com ([63.245.179.205])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Feb 2008 14:10:02 +0000
Received: from jgoerzen by 63-245-179-205.kitusa.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Feb 2008 14:10:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 63-245-179-205.kitusa.com
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75139>

On 2008-02-25, Miklos Vajna <vmiklos@frugalware.org> wrote:
>> configured his stuff correctly, it's really "darcs get; ... ; darcs
>> record; darcs send". git-send-email is nice, but harder to use for a
>> first-timer.
>
> that's true, while the practice can be the opposite. darcs forces you to
> have an smtpd on localhost, while git allows you to send the patch from
> your mail client. this _is_ easier for people sometimes. (especially
> these days when everybody blocks dhcp address ranges and an avarage user
> doesn't configure a proxy smtpd on localhost usually i think.)

Actually, both can do both, right?  darcs send -o will write the data
to send out to a file on disk, and git-send-email will transmit the
message.  I don't so much care about the default as making it easy for
people that do have a local sendmail or smtpd or (ugh) MAPI client to
send patches automatically, if I tell them what flags to use.

-- John
