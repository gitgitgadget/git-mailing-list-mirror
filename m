From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Documentation: 'cherry' does not cope well with merges
 from upstream
Date: Thu, 1 Jul 2010 20:04:00 -0500
Message-ID: <20100702010400.GA6058@burratino>
References: <1278012954-sup-3724@pimlott.net>
 <20100701210919.GA4283@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>,
	=?iso-8859-1?B?RnLpZOlyaWMgQnJp6HJl?= <fbriere@fbriere.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Andrew Pimlott <andrew@pimlott.net>
X-From: git-owner@vger.kernel.org Fri Jul 02 03:04:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUUgJ-0006Y6-KE
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 03:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755792Ab0GBBEe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 21:04:34 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47538 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753680Ab0GBBEd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 21:04:33 -0400
Received: by iwn7 with SMTP id 7so2643255iwn.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 18:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=uYtfpEXSfww7zpXjfzkD+Woh95o3tYU1RxvwZshplNA=;
        b=aKJ8BZNJ/UKbXc3Ld2Qdhet1oO4sDNCnvW2BhY82Y09PVhBJj4ECIO7YTgw3Dn3zhb
         o9Z1qqJAUI6fiLbT2tNYMGlE6Tu9J9uob/WaoRmMefMGPvViHA3YzPCkOnAGO3q9hk++
         LPqsp84RSfNjhJYkVX01zGd+oL4zrBBP+jMS4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=nOZBTjcShYK8a7rISZ5roENbUM82PtF+5+3KWvzTF+mhTvbAa0KSP8WqOfPsW14yFl
         PbwyQab2F6ZdHEf7RFUF1uH9W/HyqiBqtEGp9/VbZxZ/mjaaFitcdzLce1APhQoeLETH
         GocogTEF23lzuKF+BBCk+C0aW4lL9UPuI+FpA=
Received: by 10.231.66.79 with SMTP id m15mr281508ibi.197.1278032669116;
        Thu, 01 Jul 2010 18:04:29 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id r3sm270071ibk.19.2010.07.01.18.04.27
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 18:04:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100701210919.GA4283@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150095>

Jonathan Nieder wrote:

> +'git cherry' does not cope well with merges from upstream on the
> +working branch.  Any commits after the original fork point and
> +before the latest merge from upstream will be reported as not found
> +in <upstream>.
> +
> +                       ____*____*____*_____*__> <upstream>
> +                      /                     \
> +   original fork point                       \
> +                      \__+__+__+__+__+__+__+__*_> <head>
> +
> +While these commits are part of upstream..head, their upstream
> +counterparts are not in head..upstream.

As Junio mentioned, the text and diagram are hard to reconcile since
=E2=80=9Cthese commits=E2=80=9D are not clearly explained to be =E2=80=9C=
the commits after the
original fork point and before the latest merge, marked with a +=E2=80=9D=
=2E

Actually, the whole text is kind of awkward, which is why I left this
hanging for so long[1].  Sorry.

Adding =E2=80=9C(marked +)=E2=80=9D after =E2=80=9Cthese commits=E2=80=9D=
 sounds reasonable to me as
a quick fix.

[1] http://bugs.debian.org/575577
