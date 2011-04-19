From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: rebasing branch with reverted patches
Date: Tue, 19 Apr 2011 11:19:27 +0200
Message-ID: <BANLkTi=2LZGdZ7+QfVbd3g9dTKEcjNwsHw@mail.gmail.com>
References: <BANLkTim5mf6okFN8V5V+B=Ns1JORD47a5A@mail.gmail.com>
	<4DAD4B0F.9030908@drmicha.warpmail.net>
	<BANLkTimbSes-B8zK2a2t1Jp1v+29HdNvqw@mail.gmail.com>
	<4DAD52BA.5000206@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Apr 19 11:19:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QC75p-0004g2-3J
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 11:19:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833Ab1DSJT3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 05:19:29 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:40244 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422Ab1DSJT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 05:19:28 -0400
Received: by pwi15 with SMTP id 15so2656506pwi.19
        for <git@vger.kernel.org>; Tue, 19 Apr 2011 02:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=nOj9od7VeiFJeNR5ax0DXIzCbNHQ33R8xo9YImv2bIM=;
        b=HL0ucVFEIfaqqrfQrHNYbXHgsBEm1Gv83xSmkXtSfFvJC+lZtIjb76d1xtv5Wu0I4l
         h5ES+rjJZi6XnMI1IjrhgRGOpe+IxJffpz8Fz+fR9tSW3cX6rGkBNH5rcg6hF/GLqqbT
         +iEVLk1nIxZTMD5EUnanbq0hSdhVc+e5lUk30=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Zn/GMV2iI+c3R+HGCOpG6uBPxh/jdZ6Go093t3h9fketCQydEUolDgxTtFkNDWsJJH
         e4JUKoOP962FrLwYh/Fq6qP4hCPFdarqXLVyj3ezXtDkOeBUTi0UEtbtSTnsLrcR1TaC
         Kpk6mQ3Ij3xTBLvUkvpws0zi/zCM1/EJsbQdE=
Received: by 10.143.25.22 with SMTP id c22mr3261423wfj.267.1303204767546; Tue,
 19 Apr 2011 02:19:27 -0700 (PDT)
Received: by 10.143.18.11 with HTTP; Tue, 19 Apr 2011 02:19:27 -0700 (PDT)
In-Reply-To: <4DAD52BA.5000206@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171786>

On Tue, Apr 19, 2011 at 11:15 AM, Andreas Ericsson <ae@op5.se> wrote:
>
> That would be akin to removing in-code comments of why it's a bad idea
> to implement a particular solution in a particular way, and it also
> removes the capability of reverting the revert (ie, re-doing the change)
> at a later time when stability can be sacrificed temporarily.

That's right but OTOH I use git-rebase for development stuff where all
correct points you raised don't apply.

-- 
Francis
