From: Santiago Torres <santiago@nyu.edu>
Subject: Re: [RFC] tag-ref and tag object binding
Date: Tue, 26 Jan 2016 16:44:51 -0500
Message-ID: <20160126214449.GA5966@LykOS.WiFi.IPv4InfoBelow>
References: <20160125212208.GB26169@LykOS>
 <56A73DE6.5050201@drmicha.warpmail.net>
 <20160126152941.GA31951@LykOS>
 <20160126202651.GA1090@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 26 22:45:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOBQ6-0006ng-Bl
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 22:45:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326AbcAZVo7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 16:44:59 -0500
Received: from mail-yk0-f169.google.com ([209.85.160.169]:35369 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbcAZVo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 16:44:57 -0500
Received: by mail-yk0-f169.google.com with SMTP id u68so88853544ykd.2
        for <git@vger.kernel.org>; Tue, 26 Jan 2016 13:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to;
        bh=xr7ObgkORrd6+pDFMRhiKd+rPsxxSO4r2nFSvhunEec=;
        b=C+NiIFEY/KQJ5Na4cH/YV6kSZ1PskbYhO9/x/Cvk24Xs/VokbRlIkqtWXuAh2Aw673
         xLF35B6VcPsK8Jwoge2fGZqAe4/LQjw9X6K3QpdyDG2VruuYcVLlkiNdmH+lf4sk5vx+
         ao5HAiVeB/LaM9yEc6jbREsm4uI8SZC7Z6Y+VN2fr/4s3biFMBVWGJloFIA3TOguFDO3
         Fm4Mx+MDKdUplvjMHSHW344WkIGy0S/LacwM7lFFi+jKQ4aNII7PnIAKVDoOMQDk3vEc
         aYhxs64oXOTbqQ76SEVokK3H7uulc+Mtwqdk4XBJuokmpiL7N/FJbzYpF8s+Cx3OniYT
         1ivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to;
        bh=xr7ObgkORrd6+pDFMRhiKd+rPsxxSO4r2nFSvhunEec=;
        b=Qup3/2TzMF8FTKuXlRudtz+5YfgNBAA1WqDgcXwySlgxl9bpkelL5vLzb65IxSzdei
         wdckvhUJA33tCn5YPfTUz4xv2Q3JUHy/1ZCP21q2vAKT+8whok83hMT9zSNeuOYKYX9+
         feoi1/hjQXBQbbzfMmCbKkXzEOaNu60D21ET8c/en7f+eFqA+q3rm2y7hklx5bIy7E8C
         uKlyAweVWqiPqNGvaAJiQeO8nf5jPRvgD1s62ZX4onl51UF+mdqyWQ6vt9/jczUDIBsk
         +uFcawhoZfEJdhlf5g+7N6L6rH7ur/6NNcL5iuXUAeE4dxz/bXcLulHak+2CP6sWM2G2
         wfyg==
X-Gm-Message-State: AG10YOQq9ESHF81b0SXJCRfKWfsmgqS3ZxswuFFmmgm/+kZECd8Az7XTKcBpvMbN244UGuZG
X-Received: by 10.129.136.195 with SMTP id y186mr6551405ywf.72.1453844696313;
        Tue, 26 Jan 2016 13:44:56 -0800 (PST)
Received: from LykOS.WiFi.IPv4InfoBelow (ool-4b7ff856.static.optonline.net. [75.127.248.86])
        by smtp.gmail.com with ESMTPSA id y130sm2381155ywc.4.2016.01.26.13.44.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Jan 2016 13:44:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160126202651.GA1090@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284857>

On Tue, Jan 26, 2016 at 03:26:51PM -0500, Jeff King wrote:
> On Tue, Jan 26, 2016 at 10:29:42AM -0500, Santiago Torres wrote:
> 
> > > If you cannot trust those with write access to a repo that you are
> > > pulling and installing from you might want to re-check where you are
> > > pulling or installing from ;)
> > 
> > Yeah, I see your point, but mechanisms to ensure the server's origin can
> > be bypassed (e.g., a MITM). I don't think it would hurt to ensure the
> > source pointed to is the source itself. The tag signature can help us do
> > this.
> 
> Right. I think the more interesting use case here is "I trust the
> upstream repository owner, but I do not trust their hosting site of
> choice."

Yes, I think this is another possible scenario. Thanks for pointing it
out.

> 
> > > Your best bet is checking the signature of signed tags. Now, if you're
> > > worried about someone maliciously pointing you to the wrong, correctly
> > > signed tag then you should verify that the tag object contains the tag
> > > "name" that you expect (for example by using "git verify-tag -v" or "git
> > > cat-file -p"), since that is part of the signed content.
> > 
> > Yep, this is my intuition behind my proposal. While someone can manually
> > inspect a tag (git tag -v [ref]) to ensure he's getting the correct one,
> > there's no mechanism to ensure that the ref is pointing to the intended
> > tag. I do believe that package managers and git submodules could check
> > whether the ref is pointing to the right tag with a small change in the
> > tag header. Although it would be up to each tool to implement this
> > check.
> > 
> > I don't think that an addition like this would get in the way of any
> > existing git workflow, and should be backwards-compatible right?
> 
> Doesn't this already exist?
> 
>   $ git cat-file tag v2.0.0
>   object e156455ea49124c140a67623f22a393db62d5d98
>   type commit
>   tag v2.0.0
>   tagger Junio C Hamano <gitster@pobox.com> 1401300269 -0700
> 
>   Git 2.0
>   -----BEGIN PGP SIGNATURE-----
>   [...]
>   -----END PGP SIGNATURE-----
> 
> Tag objects already have a "tag" header, which is part of the signed
> content. If you use "git verify-tag -v", you can check both that the
> signature is valid and that the tag is the one you are expecting.

Oh, I inspected the tag object with cat-file, but I assumed this was
being inserted by the command itself (by "pretty printing"). This is
exactly what I was thinking.

> 
> Of course, "verify-tag" could do this for you if you give it a refname,
> too, but I think that may be the tip of the iceberg in terms of
> automatic verification. 

Yes, I think it could be a good first step though (maybe returning non-0
if the tag header could help in this case).

If this header exists, I think that package managers (and git
submodules) should use it to verify this metadata attacks don't take
place; it sounds rather simple.

> In particular, verify-tag knows it was signed by
> _somebody_, but it doesn't know what the signing policy is. As a human,
> _I_ know that Junio is the right person to be signing the release tag,
> but no tool does.

Yes, shipping a keychain might be helpful, I know the folks at I2P[1] do
that in their monotone repository. Maybe something similar could be an
extension to git? (using hooks, possibly?)

> 
> Git pretty much punts on all of these issues and assumes either a human
> or a smarter tool is looking at the verification output. 

Yeah, I agree. This works pretty well in some workflows (e.g., the one
in this very ML), but I have the feeling this is not the trend that
newer users of the tool are adopting.

> But I don't think it would hurt to build in some features to let git
> automatically check some things, if only to avoid callers duplicating
> work to implement the checks themselves.

Yeah, I think this check (and maybe others) could be quite simple to
integrate and lessen the workload on the git user. Inspecting each git
tag after recursively cloning might mitigate an attack like this, but it
sounds burdensome.

Thanks!
-Santiago.

[1]
https://geti2p.net/en/get-involved/guides/monotone#setting-up-trust-evaluation-hooks
