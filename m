From: David Turner <dturner@twopensource.com>
Subject: Re: Migrating away from SHA-1?
Date: Tue, 12 Apr 2016 19:15:34 -0400
Organization: Twitter
Message-ID: <1460502934.5540.71.camel@twopensource.com>
References: <570D78CC.9030807@zytor.com>
	 <CAGZ79kaUN0G7i0GNZgWU7ZzJvWY=k=Rc6tqWvJsTu8gcRhP5bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>,
	"H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 01:15:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq7X8-0007ka-P3
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 01:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933712AbcDLXPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 19:15:37 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:34011 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756403AbcDLXPh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 19:15:37 -0400
Received: by mail-qk0-f181.google.com with SMTP id r184so13033790qkc.1
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 16:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=xeS7nw0/B2BcWwlBPpaivTorSCaDy9VGL0zuxoR/GcY=;
        b=z9JxAcnyXR2vQP9Ub/dYeHnROHLPpCxcmIV/ZCl+D8B3m/2EtcpmYJHCeKw87IrZ9e
         2zh0IdnyM6aDALFiN34Ab/+uHRKZntPZ94eWTXDHhERKYZEOiPoFXJdYcDPDm4/vwOtt
         GTVSaQssRhygmwzEE+0S+AQjmyAryrlBa+lGM9Mdz25SuKbInzNFkWbLb2fHnux5jpzv
         GWt6GTPV3iBQ74MWMcWKipIaqe8i0dm5OyjjtJ/Ox8cc1Y0iWt5OoZfjOgbyn4rkJnSH
         xipIXeT5LCussNi/0TAIGaPMw4iXcMiyq8hUGXoZs0Hk9VB9SuaE03HLXlznv1qKKVpE
         qkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=xeS7nw0/B2BcWwlBPpaivTorSCaDy9VGL0zuxoR/GcY=;
        b=PNS3krxzsr7Nt69AMDANvZSqdpqqAoKvk5rFisuDigJJCWAMzYbhg6h9uzVclw0FRB
         rZSGEsKHGdzYL+IQMFEpx+Fyj37wUVVChpHUQLRpXvEA5AJcn2MZXJui2eyTwcNMOQTS
         PJeNYFEzR/hor9NGAnGj6nV+srh1ZXJl0++q2iahRlfk/bYbAdCEpy2zizXtmp7DLRAk
         P6rPPObKQVhGnuXF37H531WBm75fI9D2zw4CrdTcmQuU3AJyypEeZBl+hvqf6QazQh6F
         5b9FrWzJAx09k4RizXSrBM7UakbJkWRVeC1mt9ciT66j5FiaiXD6cW21UpREPYT3czdO
         Hq7w==
X-Gm-Message-State: AOPr4FXgReVmGfN3BUFq0EiSQf6JXBTvIHT0vc/G2dWnbwT4S88gG3WZEdmEQzPIFlQtoQ==
X-Received: by 10.55.11.137 with SMTP id 131mr6937177qkl.51.1460502936118;
        Tue, 12 Apr 2016 16:15:36 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g11sm6930972qhg.22.2016.04.12.16.15.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Apr 2016 16:15:35 -0700 (PDT)
In-Reply-To: <CAGZ79kaUN0G7i0GNZgWU7ZzJvWY=k=Rc6tqWvJsTu8gcRhP5bA@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291321>

On Tue, 2016-04-12 at 16:00 -0700, Stefan Beller wrote:
> On Tue, Apr 12, 2016 at 3:38 PM, H. Peter Anvin <hpa@zytor.com>
> wrote:
> > OK, I'm going to open this can of worms...
> > 
> > At what point do we migrate from SHA-1?  At this point the
> > cryptoanalysis of
> > SHA-1 is most likely a matter of time.
> 
> And I thought the cryptographic properties of SHA1 did not matter for
> Gits use case.
> We could employ broken md5 or such as well.
> ( see http://stackoverflow.com/questions/28792784/why-does-git-use-a-
> cryptographic-hash-function
> )
> That is because security goes on top via gpg signing of tags/commits.
> 
> I am not sure if anyone came up with
> a counter argument to Linus reasoning there?

Here's my reasoning as to why the security of SHA1 matters:

If SHA-1 is not broken, and someone hacks into e.g. kernel.org, they
can't replace an arbitrary blob with anything else without being
detected by git's automatic checksumming of objects.  GPG is necessary
here because otherwise the HEAD commit could be changed (to point to a
new tree that points to the new blob). 

If SHA-1 is broken (in certain ways), someone *can* replace an
arbitrary blob.  GPG does not help in this case, because the signature
is over the commit object (which points to a tree, which eventually
points to the blob), and the commit hasn't changed.  So the GPG
signature will still verify.

It would be possible, of course, to GPG-sign the entire commit's
transitive data (rather than just the SHA1s of same).  But as far as I
know, that is not ever what is done.

This is the argument for migration to a more-secure hash.
