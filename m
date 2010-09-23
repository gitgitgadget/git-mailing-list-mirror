From: Pat Notz <patnotz@gmail.com>
Subject: Re: get-upstream
Date: Wed, 22 Sep 2010 22:05:42 -0600
Message-ID: <AANLkTikQ8sHrp+sSZ8e8u7L+6=NHVY3cD9DwChAzLEk0@mail.gmail.com>
References: <AANLkTikqJmsUo53dRngXcWsoEfcFzLQ-J1V5oZOGUL03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ramana Kumar <ramana.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 23 06:06:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oyd4X-0003yG-UR
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 06:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750Ab0IWEGG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Sep 2010 00:06:06 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35302 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709Ab0IWEGF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Sep 2010 00:06:05 -0400
Received: by fxm12 with SMTP id 12so536214fxm.19
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 21:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=zUhmQ/Tr0fB/kYr/K3ZhZ/QaQKcIL61SKytu7oE4FOA=;
        b=Ezkno8upcT8nA4mk1+j+u1XF6BJDTCAoZALYmbtuydjPbT9schC7D98E6a823S8nD5
         XvdS8A8XyfVg2JFMDv4GH22qJrq1IwGNsRp3N5CPFqpZMGRPqDHaU1urGPGEJnKh2R6F
         F0wc1brvGRNEofaqQvHgQWCEmN0G1wHbcNekY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=aTNxQJqXppbmnFSgpxlGSyAqa9Pt9RKfgjeJ5e9qpctQ7D6I+yhBBZ8EyLdU05/n/s
         VCigcDRuFslgOgZHchP/khhGWvV7GoWLWVMqVIh7SM2rIlp2lZFB2tQK2NITIP2dxUZN
         A8oziLgMsf2dBDaXbLMAFaiGH7EowvfGNolqw=
Received: by 10.239.131.147 with SMTP id 19mr89916hbn.76.1285214763082; Wed,
 22 Sep 2010 21:06:03 -0700 (PDT)
Received: by 10.239.185.65 with HTTP; Wed, 22 Sep 2010 21:05:42 -0700 (PDT)
In-Reply-To: <AANLkTikqJmsUo53dRngXcWsoEfcFzLQ-J1V5oZOGUL03@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156845>

$ git rev-parse --symbolic-full-name @{upstream}

On Wed, Sep 22, 2010 at 9:46 PM, Ramana Kumar <ramana.kumar@gmail.com> =
wrote:
> Is there an easy command to get a symbolic reference to the upstream
> branch of a tracking branch?
>
> For example, to get the current branch name I can do this:
>
> $ git symbolic-ref HEAD
> refs/heads/mybranchname
>
> Now I can see the upstream name as follows
>
> $ git branch -vv
> branch1 ...
> mybranchname sha [upstreamname: ahead n] ...
> branch3 ...
>
> My question is is there a way to get upstreamname directly to stdout,
> similar to the symbolic-ref command?
>
> (I don't want to have to type it manually; tab completion helps a
> little, but looking for more. Plus this would be necessary to avoid
> scraping in a script.)
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
