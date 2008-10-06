From: "Robin Burchell" <w00t@inspircd.org>
Subject: Re: [msysGit] [FYI][PATCH] Customizing the WinGit installer
Date: Mon, 6 Oct 2008 18:54:54 +0100
Message-ID: <b19eae4e0810061054l737960bes289af8adc9edc561@mail.gmail.com>
References: <20081003122727.GE10360@machine.or.cz>
	 <alpine.DEB.1.00.0810061621110.22125@pacific.mpi-cbg.de.mpi-cbg.de>
	 <20081006141840.GO10360@machine.or.cz>
	 <alpine.DEB.1.00.0810061718240.22125@pacific.mpi-cbg.de.mpi-cbg.de>
	 <m3zllhpvby.fsf@localhost.localdomain>
	 <alpine.DEB.1.00.0810061810360.22125@pacific.mpi-cbg.de.mpi-cbg.de>
	 <alpine.LFD.2.00.0810061031380.3208@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jakub Narebski" <jnareb@gmail.com>, "Petr Baudis" <pasky@suse.cz>,
	msysgit@googlegroups.com, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Oct 06 19:56:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmuJp-0001qv-K1
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 19:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755266AbYJFRy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 13:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755275AbYJFRy5
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 13:54:57 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:57541 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755262AbYJFRy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 13:54:56 -0400
Received: by yx-out-2324.google.com with SMTP id 8so445862yxm.1
        for <git@vger.kernel.org>; Mon, 06 Oct 2008 10:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=RYFPFhY/JH+I5CAAe49P5JL6y+Fnj66dvJdpopaFOCM=;
        b=ZQJcZ2s0d4dYPxjV3h/g6QHXGrVu8uuK/Dj5ZMTqdYjxka/yIlTkk851xREykJEdf3
         WvZXhkLxaRUZ6bD8h167qlSXJZD9LALTIfDDdXkonINyT3WKS3pdMmi+HWi5Tm3VdrQo
         0AKgHevHTqDzK+w0Dk0j8BBsBLp9Q6Lh+w2us=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=E7dbkvPmVVmlXIIilCPeC08983QukFHya+E0yUCdKy/L0Oy/3MkKJlD+LMnFX/EQz6
         GkBsBRzdC1Ny3quK0+/jCJV5NaJaEBhQDoCmO5dq2WZGf8jvhHYYcts4jLpI13Pu40RK
         4fB9kCy5fUHLDoTmhh5YI/NvIpVXKXpKkqfy0=
Received: by 10.143.5.21 with SMTP id h21mr2128291wfi.175.1223315694211;
        Mon, 06 Oct 2008 10:54:54 -0700 (PDT)
Received: by 10.142.237.16 with HTTP; Mon, 6 Oct 2008 10:54:54 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0810061031380.3208@nehalem.linux-foundation.org>
Content-Disposition: inline
X-Google-Sender-Auth: cc119a8183195fa3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97614>

On Mon, Oct 6, 2008 at 6:34 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I absolutely detest clicking through EULA's or other self-serving crap. I
> hate software that bothers me with their license details. Nobody reads
> those things anyway, and an extra click or an extra window I didn't ask
> for - _especially_ in open source software - is just a bug.
>

I'll just jump in and add my (admittedly inexperienced) $0.02 -
namely, my confusion as to why the GPL would be displayed in place of
a EULA when ...it's not a EULA. It is not about how the software may
be used at all:

  Activities other than copying, distribution and modification are not
  covered by this License; they are outside its scope.  The act of running
  the Program is not restricted, and the output from the Program is
  covered only if its contents constitute a work based on the Program
  (independent of having been made by running the Program).  Whether that
  is true depends on what the Program does.
