From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH] branch: optionally setup branch.*.merge from upstream local branches
Date: Tue, 19 Feb 2008 08:42:32 -0500
Message-ID: <76718490802190542l7fb58d58l29d7b18fb62fd8e2@mail.gmail.com>
References: <1203386832-43969-1-git-send-email-jaysoffian@gmail.com>
	 <76718490802181819o4cf742edi92bbcd9039f0cdac@mail.gmail.com>
	 <alpine.LSU.1.00.0802191054070.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 19 14:43:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRSkU-0000xe-0i
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 14:43:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753917AbYBSNme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 08:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753840AbYBSNmd
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 08:42:33 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:10076 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbYBSNmc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 08:42:32 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3482910wah.23
        for <git@vger.kernel.org>; Tue, 19 Feb 2008 05:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=VR73HD8w4tXHL356B/YjCHrPuftImCXHzygQxBP3I3Y=;
        b=UfqkTsG3d2x0QyeleCKc2lRB/TVsEdsjl8T/pNkh0ZAgIhSqzpKSkqnHEr1MVO2EEjf0mbK0VLnohmZg+3KoJZLSnhP0PSW/Mpm1Qn8rVRxydW2+ZK0rSYoEb68qPKGyEjFz0dB5wb+Zcs7pcaIDM894LASsmbv9Tx+1UEc0mVM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RrE9HRFTwKaDVSgz+k2ZQnWJA0HlqC/SC+cXyK3ufbgkDIBb/gBuAxs3fpDCvXyG9xUhA4WhKNaxSL+UcScZiAWg0ZKZsjeAtvFUdnSKvweMdZX4sJoH9WfTJq9/IarvWAb8TrmrQGeGBLyB/OTfwQ8CbB9Ccc7wjtRuQnVGNO4=
Received: by 10.114.15.1 with SMTP id 1mr5518852wao.27.1203428552457;
        Tue, 19 Feb 2008 05:42:32 -0800 (PST)
Received: by 10.114.255.11 with HTTP; Tue, 19 Feb 2008 05:42:32 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802191054070.30505@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74404>

On Feb 19, 2008 5:55 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> On Mon, 18 Feb 2008, Jay Soffian wrote:
>
> >
> >       if (!tracking.matches) {
> >               if (track != BRANCH_TRACK_ALWAYS)
> >                       return 1;
> >               tracking.matches = 1;
> >               tracking.src = xstrdup(orig_ref);
> >       }
>
> Ah, yes.  But I still maintain that xstrdup()ing orig_ref only to free it
> later is ugly.  Why not have the "tracking.src ? tracking.src : orig_ref"
> as I suggested?

Sorry, I'd missed that. Good idea, will do.

j.
