From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: How can I force git to recognize a change change in file modes?
Date: Sat, 28 Feb 2009 11:52:44 -0500
Message-ID: <76718490902280852y2f2657ck7459c138205bb874@mail.gmail.com>
References: <e38bce640902271717s46cf47f9i7c6bf5aac0d5f273@mail.gmail.com>
	 <20090228045531.14399ebf@perceptron>
	 <e38bce640902280824x3ae41d95qab1f1a450235e096@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>, git@vger.kernel.org
To: Brent Goodrick <bgoodr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 28 17:54:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdSS6-0000qI-F7
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 17:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbZB1Qwr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Feb 2009 11:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752514AbZB1Qwq
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 11:52:46 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:3351 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511AbZB1Qwq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Feb 2009 11:52:46 -0500
Received: by wa-out-1112.google.com with SMTP id v33so882763wah.21
        for <git@vger.kernel.org>; Sat, 28 Feb 2009 08:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zLs+TsN4DlJf2+EA0x1VV6iSTfq/rJwnHpPlUvsu7R8=;
        b=BMhDwS2NiK7HKZ9shdpAo/GxGrGH9LiwhxG50EiBJtTy7wMWSq99OWey3Sd2Yje3VI
         ELx3A+i4Njtupl6o3Xwd8niIwFeZq+hmsJYD7a19EMgEhg5mgIXnqztsvqH6LZmMaXy7
         f63WVvz/TrBuR0/8MxDffRsiFBwKooDSTpPeE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TlQpW748Ztnu/I+TsVa/tMmXDMb2I1JQP47nWDkdd4JLk7l4aVYWeYF7n5tRDZkPMl
         DO4Jh5qK46s9Nif/V61YqKnyE0ZFH725Sdc8kt7+23fJsbb+VIVwSfajwybIqf+Y1Sxa
         rfElCmtGgThZlep7qr7Et4dolWC4hVNXCQPTg=
Received: by 10.140.157.4 with SMTP id f4mr1013712rve.1.1235839964116; Sat, 28 
	Feb 2009 08:52:44 -0800 (PST)
In-Reply-To: <e38bce640902280824x3ae41d95qab1f1a450235e096@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111775>

On Sat, Feb 28, 2009 at 11:24 AM, Brent Goodrick <bgoodr@gmail.com> wro=
te:
> Thanks Jan. =C2=A0Was this choice made due to the conditional coding
> required to track the permission bits content between *NIX and
> non-*NIX platform(s)?

The short answer is: because Git was designed to track content. The
long answer is more complicated. Here's one of the more useful past
discussions:

http://thread.gmane.org/gmane.comp.version-control.git/91783

I'm sure you can find others by searching the git list for "metadata".

j.
