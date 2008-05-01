From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Re: reflog/show question
Date: Thu, 1 May 2008 09:45:40 +0930
Message-ID: <93c3eada0804301715r724e8b8xf0ed64ebe016beea@mail.gmail.com>
References: <93c3eada0804271859p1b4d8b52i811bdc5e42672822@mail.gmail.com>
	 <20080428092410.GD16153@sigill.intra.peff.net>
	 <93c3eada0804281847q267611aeke51b482cfbe100d6@mail.gmail.com>
	 <20080429201214.GB20509@sigill.intra.peff.net>
	 <93c3eada0804291506n7432b348p2b726926b5fc8f80@mail.gmail.com>
	 <20080429230715.GB22598@sigill.intra.peff.net>
	 <93c3eada0804291712u19c1047bl6d44df4ca025bb4d@mail.gmail.com>
	 <93c3eada0804291726l454ccbbv96217d6657d79ded@mail.gmail.com>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 01 02:16:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrMTY-0005GJ-AD
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 02:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760565AbYEAAPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 20:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760766AbYEAAPn
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 20:15:43 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:54160 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760363AbYEAAPm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 20:15:42 -0400
Received: by fg-out-1718.google.com with SMTP id 19so339026fgg.17
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 17:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=53EHXYiQHoCE9678lCPmf6SA/7kQMqGZnSV1PX7NWq8=;
        b=ZJ2Dl+00zw+eEOjyiqBrCgh4xEG742NfIlMghVCxpTHAhyiW3GJifsahraf01lbR1R/A1vJvuDT91WlvgC5b6omjGXFbecGMm4MPhWWK/G89txdImaZiMwr/HEblK5FWIXi8Wb0FkQRzk4v+UB46DEbwz2X1OouMq5zrtCxdDi0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NtxarJa6u6gAVg+QzjVBF9pi8Tk5L0neIBVbC7fJfBHPbDTDB7vfTfXKgQpMcWmb9t2ru8n+PztVwuh5M05194UI32DpWzLEx+ATtr7kbnJBvC+hUxsZemhCl6uq+Nea85h+qgrC1ePHENgQHQNl8PFrMIim1noCOnB/wZarBh8=
Received: by 10.82.191.3 with SMTP id o3mr195700buf.34.1209600940239;
        Wed, 30 Apr 2008 17:15:40 -0700 (PDT)
Received: by 10.82.105.8 with HTTP; Wed, 30 Apr 2008 17:15:40 -0700 (PDT)
In-Reply-To: <93c3eada0804291726l454ccbbv96217d6657d79ded@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80881>

N.B. This problem has vanished -- which means its probably something I
messed up. I haven't
worked out what yet, but I will.  Apologies for any time wasted.

Cheers,
Geoff.

On Wed, Apr 30, 2008 at 9:56 AM, Geoff Russell
<geoffrey.russell@gmail.com> wrote:
>
> On Wed, Apr 30, 2008 at 9:42 AM, Geoff Russell
>  <geoffrey.russell@gmail.com> wrote:
>  >
>  > On Wed, Apr 30, 2008 at 8:37 AM, Jeff King <peff@peff.net> wrote:
>  >  > On Wed, Apr 30, 2008 at 07:36:23AM +0930, Geoff Russell wrote:
>  >  >
>  >  >  > > Hmm. Are you sure that the commit you got from HEAD@{"3 minutes ago"}
>  >  >  > >  actually _has_ the file data/node/node.data? If it doesn't, then you get
>  >  >  >
>  >  >
>  >  > > Later today (touch wood) I'll prepare as small a test case as
>  >  >  > possible, then send
>  >  >  > a tar.gz of the .git directory. Okay?
>  >  >
>  >  >  That would be great, thanks.
>  >
>  >  Attached is tar.gz of working directory (.) - so unpack in a new directory.
>  >
>  >        git show HEAD@{"N seconds ago"}:data/node/.gitignore
>  >
>  >  works fine for values of N back to creationof file
>  >
>  >  But:
>  >
>  >        git show HEAD@{"N seconds ago"}:data/node/node.newds1
>  >
>  >  doesn't work for any values of N.
>  >
>  >  During my attempts to create this example, I managed created a
>  >  directory which where
>  >  the show command failed for both files, but when I changed the commit
>  >  message, the
>  >  show worked for .gitignore but not the node file. Hence my suspicion
>  >  of that the slashes
>  >  in the path are being interpreted as requesting a commit message match ...?
>  >
>  >  I hope you can track it down, I will install the latest version of git
>  >  later on today to
>  >  confirm the behaviour is still happening.
>
>  I just confirmed behaviour is still the same in 1.5.5
>
>  Geoff.
>
>
>
>
>
>  >
>  >  Thanks,
>  >  Geoff Russell
>  >
>  >  >
>  >  >  -Peff
>  >
>  >
>  > >
>  >
>  >
>  >
>  >  --
>  >  6 Fifth Ave,
>  >  St Morris, S.A. 5068
>  >  Australia
>  >  Ph: 041 8805 184 / 08 8332 5069
>  >
>
>
>
>  --
>  6 Fifth Ave,
>  St Morris, S.A. 5068
>  Australia
>  Ph: 041 8805 184 / 08 8332 5069
>



-- 
6 Fifth Ave,
St Morris, S.A. 5068
Australia
Ph: 041 8805 184 / 08 8332 5069
