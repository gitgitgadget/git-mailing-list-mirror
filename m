From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH] Teach git-describe --long to output always the long format
Date: Tue, 26 Feb 2008 10:41:31 +0100
Message-ID: <8aa486160802260141i62c33f02kcc641936ac9116e5@mail.gmail.com>
References: <1203864412-27977-1-git-send-email-sbejar@gmail.com>
	 <20080225023634.GK8410@spearce.org>
	 <7vwsotpwbr.fsf@gitster.siamese.dyndns.org>
	 <8aa486160802250034ncdf20b6s13856ca8612bc2ea@mail.gmail.com>
	 <7vbq65ju0y.fsf@gitster.siamese.dyndns.org>
	 <8aa486160802250105p4f98cb6eu1d6ac4fa700f11fe@mail.gmail.com>
	 <7vwsoshk3s.fsf@gitster.siamese.dyndns.org>
	 <8aa486160802251251u74a19b93l77ca3930d2387cb8@mail.gmail.com>
	 <7vy7986pnc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 10:42:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTwKB-0000a9-LU
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 10:42:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716AbYBZJlg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Feb 2008 04:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752134AbYBZJlg
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 04:41:36 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:6188 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbYBZJle convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Feb 2008 04:41:34 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1181283ugc.16
        for <git@vger.kernel.org>; Tue, 26 Feb 2008 01:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Y2AlZVvmv8Aqv57hIvCtnLpq69pvpK02HtfwUPRl340=;
        b=PAoHikV0Z8P866gLFjhYYR8e8cmFko2jKTdi2e3SmpqI+jOO3ZPi/RblDVOC+0vDkc1AvUzurfA/WK/p+Zo9rZvxljkFXNKUgOV8tWZ7FEinOzsvbp2RWoJWS0QJVCDsVs++H1jm2w4aRMg7/4drk3OUXUwGFOmKzt5f2uTLjGw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ydv4n/HJah8UqoleljUZ/h8RhqyO4dnhmNIafvI9GqbpxvXZUOHuH3fnnhkvUb5JCd3xkOkj4JX9GbKF+sjblzBbKB/t1LsDPHpBQJFp81P/aLkVzBlFxB+LyCv45Qbkr68nSShOqWf/paaJExzJ3QfZQ44Xl+LrEIh1ZwesoZ0=
Received: by 10.151.7.4 with SMTP id k4mr1549975ybi.154.1204018891798;
        Tue, 26 Feb 2008 01:41:31 -0800 (PST)
Received: by 10.150.205.9 with HTTP; Tue, 26 Feb 2008 01:41:31 -0800 (PST)
In-Reply-To: <7vy7986pnc.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75118>

On Tue, Feb 26, 2008 at 10:19 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> "Santi B=E9jar" <sbejar@gmail.com> writes:
>
>  So I have quite a big problem with your commit log message, even
>  though I am starting to like what it does.  Perhaps this would be mo=
re
>  to the point.
>
>     git-describe: --long shows the object name even for a tagged comm=
it
>
>     This is useful when you want to see parts of the commit object na=
me
>     in "describe" output, even when the commit in question happens to=
 be
>     a tagged version.  Instead of just emitting the tag name, it will
>     describe such a commit as v1.2-0-deadbeef (0th commit since tag v=
1.2
>     that points at object deadbeef....).
>

I think it's find, and to the point. Thanks.

>  By the way, I do not think "long" is what it does.  It does not even
>  show the full object name unless you tell it to with another option
>  (i.e. --abbrev).  The flag tells the command to use the normal outpu=
t
>  format that is used to describe most other commits (untagged ones),
>  and signal the "taggedness" with the count part being "-0-".
>
>  Perhaps --nonexact-format, or even --redundant-output?
>
>  Hmmmmm...  "--always-count", as it is about always using the counted
>  format (which is the "normal" output format)?

I call it --long for longformat, maybe --longformat, --always-long,
--always-normal.

>
>  I know, I am bad at naming, so I'll park the commit in 'pu',
>  with option name kept as "--long" as in your patch.

Me too.

Santi
