From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Tracability in git commits
Date: Fri, 2 May 2008 10:21:41 +1200
Message-ID: <46a038f90805011521s1d7f5d42k2e9186e5fd4c43b3@mail.gmail.com>
References: <1209473739.5642.31.camel@dax.rpnet.com>
	 <m3lk2vodw4.fsf@localhost.localdomain>
	 <1209551520.5010.20.camel@dax.rpnet.com>
	 <46a038f90804301826xaf5d73bl1d29a07bc930a716@mail.gmail.com>
	 <46a038f90805010034y3ffd3eb5hbee7c2200912eef3@mail.gmail.com>
	 <7v63txzw18.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Richard Purdie" <rpurdie@rpsys.net>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 02 00:22:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrhAe-0006ps-B4
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 00:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755002AbYEAWVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 18:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764746AbYEAWVr
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 18:21:47 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:24367 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764715AbYEAWVo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 18:21:44 -0400
Received: by wr-out-0506.google.com with SMTP id c48so834727wra.1
        for <git@vger.kernel.org>; Thu, 01 May 2008 15:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=66/xd5FoSxWTTlGd2ZbYEtqmo+cIDyIpbz7IzVR1I5I=;
        b=sZ29EBB9i3TfgQIxy1Ef8wxdphvgu5ATkMBoUZcuOD5jvsKs8itbNf+0vMO0q30WP02M9iO8Tb31ZWAxvjv2Mwk/0sf2D6JVDq6VBHTsUPlGpIVx8JMME/Nl55Z5uG7wMt1kT5VG4fm/lp2OcxBBRZG+192/K5pClfFXkdD+9F0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bzjNVy37s7+8A3UUdzdvNXyoApA0UKUI9h1klkyFFkbbcSHLx+Vx2LFxte0BgTsOqz80A492ZXXyZroB7qXqEvhtPBPmfnsUzAQ5KI8kyEyW/G0RTxh8wlpMysDNBlNy72nch5PM6bFN4g8ZcAY7+L3vCtaXyYUIsRjLmpPQbC0=
Received: by 10.142.237.20 with SMTP id k20mr981534wfh.228.1209680501840;
        Thu, 01 May 2008 15:21:41 -0700 (PDT)
Received: by 10.142.212.21 with HTTP; Thu, 1 May 2008 15:21:41 -0700 (PDT)
In-Reply-To: <7v63txzw18.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80942>

On Fri, May 2, 2008 at 7:03 AM, Junio C Hamano <gitster@pobox.com> wrote:
>  I suspect that, with the "push to incoming, vet there and move to
>  verified" workflow, you do not need a special GPG-signed list.  You can
>  instead have the pusher sign the tip using the usual signed-tag mechanism,
>  which would sign the whole history leading to it, and have him push that
>  tag to the incoming together with the tip update.  You obviously do not
>  need nor want to move that signed tag to the final area.

Yes. Though it makes a post-facto audit of who-pushed-which-commits
trickier - you'll have to correlate the reflogs in the server with the
signed tags. Having an explicit signature on a list of commits is a
bit more direct, easier to audit... IMHO anyway ;-)

cheers,



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
