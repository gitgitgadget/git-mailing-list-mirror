From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Please discuss: what "git push" should do when you do not say what to push?
Date: Tue, 20 Mar 2012 09:43:26 -0700 (PDT)
Message-ID: <m3ty1j2pg4.fsf@localhost.localdomain>
References: <7v7gyjersg.fsf@alter.siamese.dyndns.org>
	<7vty1ndcoi.fsf@alter.siamese.dyndns.org>
	<CACPiFCKbfgSZMnpc6Q_Lg6n5YMHQ2bad-bwQsyASk0eMuiAFTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 20 17:43:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SA29m-0001Sf-C6
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 17:43:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756240Ab2CTQn3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 12:43:29 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:60980 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754472Ab2CTQn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 12:43:28 -0400
Received: by wibhq7 with SMTP id hq7so331381wib.1
        for <git@vger.kernel.org>; Tue, 20 Mar 2012 09:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=qyOELcwjCeJMnGBAjyQpc2VxUSqJtm3f+NM5YdmYk7M=;
        b=Zu1m4ceSgPpacqIfBJdvpkogXcoJqdw6DDd0r/UJYTwQ/P+yUltQOJ588+E9QB3qE3
         j6T1bj6o3iwrXZefbmbj+CnaX/IGsJ6Xg0tnq+NSrWdVXckNF4+pQwmnqqF1B+XP0BNP
         XhXeMBCrkELbXSIKGYQVmdyXy493DnMR4FUvqcatHVv7m12errcSQ7ZIb7RmdsU9vN26
         CgNpc+CXD2L0spvUNGSXG8bwDCjUxJmJDf2zWYeyNqbhVfXEUvL1mcJZy5B14G8RHeSd
         j/H0gEgAGAELGmFiS4e4+zTfyT7ghi6lakkSDbBPCiptqGM2M5lK8tHumy2GT9lLKZhW
         bZPg==
Received: by 10.216.203.146 with SMTP id f18mr332232weo.21.1332261807163;
        Tue, 20 Mar 2012 09:43:27 -0700 (PDT)
Received: from localhost.localdomain (abwt72.neoplus.adsl.tpnet.pl. [83.8.243.72])
        by mx.google.com with ESMTPS id ff2sm8461586wib.9.2012.03.20.09.43.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 20 Mar 2012 09:43:26 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q2KGhOOL022690;
	Tue, 20 Mar 2012 17:43:24 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q2KGhNOk022686;
	Tue, 20 Mar 2012 17:43:23 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CACPiFCKbfgSZMnpc6Q_Lg6n5YMHQ2bad-bwQsyASk0eMuiAFTQ@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193519>

Martin Langhoff <martin.langhoff@gmail.com> writes:
> On Sat, Mar 17, 2012 at 1:22 AM, Junio C Hamano <gitster@pobox.com> wrote:

> > If the conclusion of the discussion is that we will change the default,
> > the transition to the new default will go like this:
> 
> I am in general agreement with the course of action outlined. There is
> one little thing I had expected in addition, that is not discussed:
> 
>  --force should change behaviour, immediately, to "current" or even
> none (forcing the user to name the remote and branch explicitly).
> 
> The potential for messups with --force combined with "matching" and a
> repo that allows it is considerable. And I cannot imagine any
> mainstream use cases for --force defaulting to matching; at least none
> important enough to counterbalance the damage.

Well, one can always use

  git push <remote> +:

instead of

  git push --force

for "matching" push... but I think you would have to provide name of
repository.

-- 
Jakub Narebski
