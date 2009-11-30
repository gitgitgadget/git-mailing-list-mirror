From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v3] Give the hunk comment its own color
Date: Mon, 30 Nov 2009 10:26:22 +0100
Message-ID: <fabb9a1e0911300126t48d767b9kbb31e9ac8e4a5d8e@mail.gmail.com>
References: <7v4oogzo74.fsf@alter.siamese.dyndns.org> <1259304918-12600-1-git-send-email-bert.wesarg@googlemail.com> 
	<7vhbsfi4bz.fsf@alter.siamese.dyndns.org> <36ca99e90911280408v186777f1h22254744fb61bf1f@mail.gmail.com> 
	<36ca99e90911292307w769913fdn1f610eeb065b41e@mail.gmail.com> 
	<7v4ooczdoe.fsf@alter.siamese.dyndns.org> <36ca99e90911292341o524840ebo47d79f06b1588d5c@mail.gmail.com> 
	<7vtywcwj1o.fsf@alter.siamese.dyndns.org> <fabb9a1e0911300009j1574c06cy500dde75fc68662f@mail.gmail.com> 
	<7vvdgstmic.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 10:26:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF2Ww-0007AJ-JJ
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 10:26:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621AbZK3J0i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Nov 2009 04:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752903AbZK3J0h
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 04:26:37 -0500
Received: from mail-vw0-f197.google.com ([209.85.212.197]:41191 "EHLO
	mail-vw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753169AbZK3J0h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Nov 2009 04:26:37 -0500
Received: by vws35 with SMTP id 35so1001685vws.4
        for <git@vger.kernel.org>; Mon, 30 Nov 2009 01:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=B3XFIQTa3PeZqp5n+82gLKVyfkhxT1lhUGFVQpPoahc=;
        b=aru8eUKTpu+hqTUAl4QN1gomva/5jhWrnDeR1aGcGraNZciy/Upz4vDVvl66lKq/WX
         6QajpMVc43rQFj2yW/xFkTuzCBAe/hDsZE/V8rdnXsatyl7qAsvpvpyGeLVpub9K+L+5
         SNMxhxoUz1CG21M1VXcSTk/1hTo+4pWgRasM8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=L3U7uzhnQr0D/lcRV89iIos76OjUqVAZihfgQGJlupnifsce4fScvH+kXzeJYgNKj3
         a3daHwhFjHBzpjflGDPWyKTHtqtzuVw2i53Uw88JyZKo0sXM/kcIvqAoMdfLh2O0Z7HC
         zfHyTk0RjBLxrT1+ZzDe8thu0V9c8OJqQQ6kQ=
Received: by 10.220.65.200 with SMTP id k8mr4792087vci.116.1259573202089; Mon, 
	30 Nov 2009 01:26:42 -0800 (PST)
In-Reply-To: <7vvdgstmic.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134087>

Heya,

On Mon, Nov 30, 2009 at 10:00, Junio C Hamano <gitster@pobox.com> wrote=
:
> I maintain a private 'jch' branch that merges everything that has bee=
n
> merged so far to 'next' and the branch always builds on top of 'maste=
r'
> whenever 'pu' is pushed out. =A0The tree object recorded by the tip o=
f 'jch'
> is designed to always match that of 'next'. =A0And 'pu' is built on t=
op of
> 'jch', instead of 'next', these days.

Ah, so _that''s_ how you pull of not rebasing and still maintaining a
clean history in master: keeping a private shadow branch with the
cleaned up history that is tree-identical to the no-rebase next
branch. Interesting.


> The end result is that the commit merged in 'next' is not the tip of
> bw/diff-color-hunk-header anymore, but merging the _current_ tip of t=
hat
> branch together with all the other topics on top of 'master' would pr=
oduce
> the desired result without "oops---that was a stupid typo" fixups.

Thanks for explaining, git really does allow for a lot of interesting
workflows :).

--=20
Cheers,

Sverre Rabbelier
