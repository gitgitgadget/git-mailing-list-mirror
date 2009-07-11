From: Tim Harper <timcharper@gmail.com>
Subject: Re: commit hooks on merge
Date: Fri, 10 Jul 2009 23:11:40 -0600
Message-ID: <e1a5e9a00907102211m43522a09l49093ae50ea16e2a@mail.gmail.com>
References: <4A43D37B.20203@surfmerchants.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kurt Milligan <kurt@surfmerchants.com>
X-From: git-owner@vger.kernel.org Sat Jul 11 07:12:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPUsg-0001qs-Un
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 07:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbZGKFMB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Jul 2009 01:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbZGKFMB
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jul 2009 01:12:01 -0400
Received: from mail-px0-f193.google.com ([209.85.216.193]:40213 "EHLO
	mail-px0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbZGKFMA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Jul 2009 01:12:00 -0400
Received: by pxi31 with SMTP id 31so924420pxi.33
        for <git@vger.kernel.org>; Fri, 10 Jul 2009 22:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=EKPxlHfPl+1z0snsE4g4uFK+XXRCPbqtc1Lt7Vbf1xo=;
        b=xOhCskyCUkSVhrHgbYlpTq6yRkruVLV/idw58tTeYwvSrZWxm3WdDgX+RnAodTIFVW
         sJrNNfirtLAiWSaMIQDhbT6hDpWOIMLWdPhNLGSygJj2wNe1sF4Tfq7OgGB2oLHwNZe1
         Q9+LXa6VaprSdMvotxjaZSZRYuQJrd3+IyUNs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=iqrmkgRLiAHlj2dQOatzZGrtsJPFXRWgffPhActs4H2vIKgEhieXdgayI8SVwJxb/u
         J1riUhny5erFaDYfrkl081BjucJ9uT/6dXBWdCLYzQsEm2qUfSAPrdjM78/TVbUmo2YI
         YBRoLSfX50Fj2ZRi8VzTcE4PzfWd5mGtJjrf4=
Received: by 10.140.162.3 with SMTP id k3mr1882737rve.3.1247289120059; Fri, 10 
	Jul 2009 22:12:00 -0700 (PDT)
In-Reply-To: <4A43D37B.20203@surfmerchants.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123099>

Kurt

I don't think there is a hook to prevent a merge from occurring.  I
mean, you could probably rename git-merge, and then put a wrapper
script in its place.  That script could call the hook for the current
repository, if it exists and you could implement pre-merge.

This is if you REALLY REALLY want to do it :)

Tim

On Thu, Jun 25, 2009 at 1:43 PM, Kurt Milligan<kurt@surfmerchants.com> =
wrote:
> Hi
>
> I asked this in #git, and did a quick Google search to no avail...
>
> According to the docs, merge does an auto-commit, but it seems that t=
he
> pre/post commit hooks are not run for this commit. Is that intentiona=
l? Is
> there a way I can make them run for the merge commit? I see there is =
a
> post-merge hook, but that doesn't really help me if I want to stop th=
e
> merge...
>
> Thanks in advance
>
> -Kurt
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
