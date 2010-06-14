From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/6] Add library for string-specific memory pool
Date: Mon, 14 Jun 2010 15:49:27 +0200
Message-ID: <AANLkTimFRpckXjvzaefyOdokf-1f7YkrNAQ8dVr3jQgj@mail.gmail.com>
References: <1276175389-6185-1-git-send-email-artagnon@gmail.com> 
	<1276175389-6185-4-git-send-email-artagnon@gmail.com> <7vk4q5ictl.fsf@alter.siamese.dyndns.org> 
	<AANLkTilr9Qa9RJ3TIaCTgGwgp75TDBZbqRENC41xRFlq@mail.gmail.com> 
	<7v631lbutb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 14 15:49:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOA30-0008HL-Nl
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 15:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109Ab0FNNtt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jun 2010 09:49:49 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53122 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813Ab0FNNts convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jun 2010 09:49:48 -0400
Received: by gye5 with SMTP id 5so2379246gye.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 06:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=AaCVhlbM3Novv0288D6olHpphso18DbF+AVEHT8HuSk=;
        b=EEWtcPmxX5JXzmU6ZxZHD1joa+2BQsf1SquZlacSb6F6cDSelXY9Zqoes1R48PBLnd
         TsEuHN3RPv+ONr276hkP11qTLS1nU3MOEnjgqGKLAUguV9BPoF7qwmQqUqNYEcnT95+e
         2Rt7MK6VuRC2YWlJxqY7zWe2wy8XfCLdeplKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ok0/CAvdqp0zuS7UoxoIevai8hvePnnpGSBYCBFY1fzMiaQsGHHTHAPSaPGs4B5a1C
         sYGE0vd87xFH246x/Tj8K9SF0msmUFgUIFyls623dDks6S/KkgqN3oOvK9ObvRe+EkYr
         iRDLIhsvm9ZUjpZYbox5Rc8MtXYplAcjeyUbs=
Received: by 10.229.193.16 with SMTP id ds16mr2353544qcb.148.1276523387355; 
	Mon, 14 Jun 2010 06:49:47 -0700 (PDT)
Received: by 10.229.182.85 with HTTP; Mon, 14 Jun 2010 06:49:27 -0700 (PDT)
In-Reply-To: <7v631lbutb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149093>

Hi Junio,

Junio C Hamano wrote:
> The problem with Emacs diff mode I already know about. =C2=A0It gets =
confused
> by the "-- SP LF" line at the end of the format-patch output when it
> recounts diff.

I see. I'll probably prepare a patch then.

> Note that there isn't that much difference between being in 'pu' and =
being
> in the mailing list archive. =C2=A0Depending on how further discussio=
ns go, the
> series can be replaced with an improvement or even can be dropped as =
a
> whole.

It's an indicator of progress, if not anything else. The project is
already pretty mature imho- after squashing in a few bugfixes, it
should be ready for `next`.

-- Ram
