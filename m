From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: StGit: kha/safe and kha/experimental updated
Date: Tue, 25 Mar 2008 10:52:43 +0000
Message-ID: <b0943d9e0803250352g2c6d441cke3bcff5d9c0ee769@mail.gmail.com>
References: <20080319012804.GA28781@diana.vm.bytemark.co.uk>
	 <20080319013832.GB28781@diana.vm.bytemark.co.uk>
	 <b0943d9e0803200825y18971975qd79bf51157a97684@mail.gmail.com>
	 <20080324182647.GD23337@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Alex Chiang" <achiang@hp.com>,
	"Angus Salkeld" <ahsalkeld@gmail.com>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 11:53:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je6mT-0003qW-Sl
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 11:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233AbYCYKwp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2008 06:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753247AbYCYKwp
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 06:52:45 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:31225 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083AbYCYKwo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Mar 2008 06:52:44 -0400
Received: by wr-out-0506.google.com with SMTP id c48so2203618wra.1
        for <git@vger.kernel.org>; Tue, 25 Mar 2008 03:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=E2+X5Nq1LA9xekVPd4yjzxrBDfpa593GI37UyIR7PKM=;
        b=fYh2DZpevlNmnQAkKeNkAZxHGd0MN2NwS5N0/IHKReN6rGA2+9MUYGEjMchk+s5aB3y5kINUBv8B4KTW9rIXZxwr74B+zjEOdKKjMTrTDwKZmP3ktALJ3uAVwLpYT1nDInbQ9gC8x0dBViEmFiC59wgeF8rqNtC8As22IQzRXas=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ViWUX7/GjJc4CoZ1FeuPCS7dvzcQxU81ybjpiiIQZVoAAMOoW1MzXXHY+WZsHY/ApQiEK/IscoWY7EO2m10HKJmx1plWHeZwp1LpNhXLlieYCbAFJMuAvV9D+262RuS5370TyCHseWsg1mFEMt6t0nhC+ei8SlL11/O4EW2pOc0=
Received: by 10.141.29.21 with SMTP id g21mr3121375rvj.225.1206442363379;
        Tue, 25 Mar 2008 03:52:43 -0700 (PDT)
Received: by 10.141.175.11 with HTTP; Tue, 25 Mar 2008 03:52:43 -0700 (PDT)
In-Reply-To: <20080324182647.GD23337@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78177>

On 24/03/2008, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2008-03-20 15:25:04 +0000, Catalin Marinas wrote:
>
>  > We can even add aliases for 'undo' and 'redo'.
>
>
> It's not entirely clear (to me at least) exactly what undo and redo
>  should do. Something like this maybe:
>
>   undo: If the log begins with k "undo" entries (k >=3D 0), reset to
>         log~(2k+1).
>
>   redo: Find the most recent "undo" entry that hasn't been cancelled
>         out by a "redo". If this is the most recent log entry (except
>         the cancelled-out ones), reset to it; otherwise, complain tha=
t
>         the last command was not an undo or redo.
>
>  I _think_ this does what one naively expects undo and redo to do.

Yes, something like this. Anyway, this can be explained in the help
without adding separate commands (at least for now).

--=20
Catalin
