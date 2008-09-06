From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Alternates and push
Date: Sat, 6 Sep 2008 14:24:59 -0400
Message-ID: <9e4733910809061124r3759ea79sda98b549df3e6e58@mail.gmail.com>
References: <9e4733910809060542s5ede6d6m5bdb894c958ea8b7@mail.gmail.com>
	 <20080906162030.GT9129@mit.edu>
	 <7viqt9rvwm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Theodore Tso" <tytso@mit.edu>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 20:27:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kc2UW-0007QR-Fx
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 20:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754894AbYIFSZD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 14:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754876AbYIFSZD
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 14:25:03 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:48111 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754853AbYIFSZA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 14:25:00 -0400
Received: by wr-out-0506.google.com with SMTP id 69so936944wri.5
        for <git@vger.kernel.org>; Sat, 06 Sep 2008 11:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=/fioHGxTW2UsJfKwSW+pkSGNFCu7KynPLlW2Sy7ls6c=;
        b=ZpFRcg0tAPlaRfOZcdbVgiEtcUcCpKr0kaXTIpKtd0fZKk3n4QC/9U1f3u5hMvN0Xe
         JFmjcc0EGcegNqGEw7Ako5RgEnmEO2jiNkh65oBdMAawZNsLlZPTvTkSjIO7uc2xvo9Y
         ea6mlmuakpZ7QV/lGgaeWkc2Jw0b6N+vXlo/U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=XXLcFTr/7HHWGJBNXhCqC1NtJvHk6/8rE3lMjjOzzxutjlqvRFwTlm8UzY3tRyeiuT
         8+25KrNdrU9dZB95cu97PpwpXVbWKXhAuaTwT+Jwm1WPfINHo9cuHdvMoo73woDy5Geh
         VYcTe7wwKGlUVDtvMNOMN7gLn+xK81DX3puOA=
Received: by 10.70.110.1 with SMTP id i1mr16182426wxc.59.1220725499591;
        Sat, 06 Sep 2008 11:24:59 -0700 (PDT)
Received: by 10.70.55.6 with HTTP; Sat, 6 Sep 2008 11:24:59 -0700 (PDT)
In-Reply-To: <7viqt9rvwm.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95088>

On 9/6/08, Junio C Hamano <gitster@pobox.com> wrote:
> Theodore Tso <tytso@MIT.EDU> writes:
>
>  > Long-standing mis-feature in git's logic in deciding what to push.
>  > It's been reported a few times, but apparently it's hard to fix, or at
>  > least it never hsa been fixed as far as I know.
>
>
> This comes from an early (mis)design of git.

What happens if I set a remote in my github digispeaker repo pointing
to github's linus repo and the set a chron script to fetch it once a
day? The alternates link is still in place.

-- 
Jon Smirl
jonsmirl@gmail.com
