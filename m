From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git status --porcelain is a mess that needs fixing
Date: Sat, 10 Apr 2010 01:12:24 -0500
Message-ID: <20100410061224.GA18715@progeny.tock>
References: <20100409184608.C7C61475FEF@snark.thyrsus.com>
 <20100410040959.GA11977@coredump.intra.peff.net>
 <20100410054645.GA17711@progeny.tock>
 <20100410055124.GA17778@progeny.tock>
 <20100410060353.GA4585@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Raymond <esr@snark.thyrsus.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 10 08:12:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0TvT-0002hv-IN
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 08:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244Ab0DJGL6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Apr 2010 02:11:58 -0400
Received: from mail-yw0-f194.google.com ([209.85.211.194]:44708 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896Ab0DJGL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 02:11:57 -0400
Received: by ywh32 with SMTP id 32so724765ywh.33
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 23:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=kdlZR7Tk7lSvoz2RxqV5QtZ0bc2SIK2h3u6W/7qhx4c=;
        b=Mc1yqd9HDCN9USA9ZN/DzRGmk37dFZKv1YVPq7mKPVoRYc4wmw08OE6S65VMH8NUii
         IEprRPivvZudmR/x65sKLDR4cx4MWnL4EMq6pRKqv9v9FgDYUEM1RtnhhtE3Vl59vCR6
         f7lYJnUQc/Xjqe/GIOlzf1Sthd97aW+QcrxH8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=bk04BnDRXM8dGPo2lhNciuSaPzl98ZhjLOK+qoh6Hcjp2QxYEwZNfsLHvlNfiNp/gM
         IDqJwc5VhoRRMrLuXnnvA+dwhlvDrswblB+6za95TAk2Q8j3kvLl2VjMTxxG1s6SM9aQ
         nj+25yHaxZbWwUMzOBiSATcgMPbcUX55+AsnA=
Received: by 10.100.245.28 with SMTP id s28mr1791621anh.190.1270879916801;
        Fri, 09 Apr 2010 23:11:56 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm1532375iwn.8.2010.04.09.23.11.55
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 09 Apr 2010 23:11:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100410060353.GA4585@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144517>

Jeff King wrote:

> You do "git clean -ndX" to see
> _everything_ that is untracked, and "git clean -nd" to see things tha=
t
> are untracked but not ignored.

No, the capital X tells clean to only list excluded files.  The
standard use is as a poor man=E2=80=99s =E2=80=9Cmake maintainer-clean=E2=
=80=9D, leaving
unrelated files alone.

I only learned about it just now.  I=E2=80=99m glad I did (I often use =
the
lowercase version for this because I just didn=E2=80=99t know about -X)=
, but
as you mentioned, it is not so applicable here because not plumbing.

Jonathan
