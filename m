From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: The 8th airing of the msysGit herald
Date: Tue, 4 Mar 2008 11:58:22 +1300
Message-ID: <46a038f90803031458t2b404212t10f6e9ae710dc408@mail.gmail.com>
References: <alpine.LSU.1.00.0803022329560.22527@racer.site>
	 <m34pbok54h.fsf@localhost.localdomain>
	 <alpine.LSU.1.00.0803030052450.22527@racer.site>
	 <200803030210.02223.jnareb@gmail.com> <47CBE85B.6060702@imap.cc>
	 <7vablfiv42.fsf@gitster.siamese.dyndns.org> <47CC432B.8060502@imap.cc>
	 <7v1w6rh1ru.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Tilman Schmidt" <tilman@imap.cc>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	msysgit@googlegroups.com, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 23:59:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWJcg-0006dj-Jw
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 23:59:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbYCCW60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 17:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751908AbYCCW60
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 17:58:26 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:39234 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbYCCW6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 17:58:25 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2310718ugc.16
        for <git@vger.kernel.org>; Mon, 03 Mar 2008 14:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=fHkULCmvlP/6D3vHukS+pVwA3uHVCRIsXQG9xhjkwV8=;
        b=A9QPVuCk5osbaYbGGiJRXB7np+vEFilugVPwdiWbSiryc2ne+egNgH1N766WDGTY6RCddQgSeRt/D9Yk9Wm14gXvFXcZFgDdsMlGxTFKxvgFCPqKD4Dw/y+thyCXsHSL8WLgps0pi0HbkVqEuL8GdMSMGQ8e7h7OHCnJzfn/Tw8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AZhL3J+8VVZTck+hegPOwo6TG7Y7rEdGDTgfn1S9qe1Nt5bhWK7y9HY/XJnNUz/q8TPh6Hgvmi+r137bgdp/S3mCT5oLzsx2Tmcz/DXqUmU2zwuuwEbeXYXFbwD4vTtZWZnhLwma6IWK9h1diPy/m/j00+UCXKTqhSeAPWRw+fo=
Received: by 10.67.116.9 with SMTP id t9mr4979177ugm.77.1204585102594;
        Mon, 03 Mar 2008 14:58:22 -0800 (PST)
Received: by 10.66.252.6 with HTTP; Mon, 3 Mar 2008 14:58:22 -0800 (PST)
In-Reply-To: <7v1w6rh1ru.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75994>

On Tue, Mar 4, 2008 at 11:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
>  But if you s/stop/slow down/ what I said, it may start to resemble a more
>  serious question.

Given that git dev has such a frantic pace... would it make sense to
give way to some "version inflation"?

This would give end users a more clear sense of how much things have
changed -- a 1.4.x to 1.5.x doesn't seem like much. But a 1.5 to 2.0
with a "new features summary" will grab a bit of attention, get its
slashdot article, and be a more frank communication of the work that's
happened, and what the user can expect.

In other words, the 'linux versioning' scheme sucks when dealing with
people who aren't sub'd to the mailing list. Yes, from git v0.99 to
today we haven't broken anything too significant, but from an end user
POV, several of the  smaller changes carry enough incompatibility that
v1.4.x and v1.5.x are not actually compatible (all the remote heads
handling changes, for example).

So say rock on, but label the next feature release 2.0 or at least 1.6
and declare it is "mostly compatible, but you'll do well in re-cloning
your projects to keep things simple" -- in practice, I've had to do
that anyway on the 1.3->1.4->1.5 transitions.

cheers,


martin
