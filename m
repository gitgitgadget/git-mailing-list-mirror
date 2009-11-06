From: Patrick Doyle <wpdster@gmail.com>
Subject: Re: How to merge into my working copy?
Date: Fri, 6 Nov 2009 13:15:37 -0500
Message-ID: <e2a1d0aa0911061015o412f1ab0k9fbfdb88431d49c9@mail.gmail.com>
References: <e2a1d0aa0911060653t7bbb54ebp948eac0dffeaba64@mail.gmail.com>
	 <7v8wejzgim.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 19:15:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6TLd-0002cK-Hi
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 19:15:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757160AbZKFSPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 13:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756162AbZKFSPd
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 13:15:33 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:45931 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755581AbZKFSPd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 13:15:33 -0500
Received: by ewy28 with SMTP id 28so1420796ewy.18
        for <git@vger.kernel.org>; Fri, 06 Nov 2009 10:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=wZrcKCUg6c5P416zqKIRmgDfbWxYPJjF9uxVDlfJ7x8=;
        b=WR+IOFGwT3Y/qyjT6prPKxBbJIYQCW4bnB+jDydPYHbrrnc79Bb1iicLQowrIUIkWn
         +edI2f+WWi3jpskan5VL9M6wDGPuizUU+EKk7YDXKPVSyBoPHXJ5B78lMzqhoWR4YjoR
         sovl2sD3hTikkRmaAvj/OiQZ5/JwZzLuZdrVk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=TFnFmtMEECtC8jsrBwZQPMjvLl4y+Ukbu3vsfsEqiDg60kKm1IpMF0rAP9x1ORg7fC
         2/ZH/uyuHtNSY6/qj4ECCDaCsomtAWezHpV43njEtPZs2zS6d0p66so58wV3Fzw9V0os
         RRfMVnVBF2Q+kZPAhVBjKuea+SACWCY8c2g+k=
Received: by 10.213.57.80 with SMTP id b16mr1221624ebh.36.1257531337397; Fri, 
	06 Nov 2009 10:15:37 -0800 (PST)
In-Reply-To: <7v8wejzgim.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132319>

On Fri, Nov 6, 2009 at 12:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> If you do not have to have your extra "without affecting the index"
> constraint (which I do not see a sensible reason to want to, by the way),
> you can "merge --no-commit that_branch", I think.
>

After bouncing this around a couple of times with Bruce Stephens, and
only now noticing that I hit "Reply" instead of "Reply-All"... sigh),
I realized that what I wanted was:

$ git merge --squash that_branch
$ git reset

I only wanted to affect my working copy, editing and adding things to
the index (which I think of as "staging area for my next commit") as I
was ready.

--wpd
