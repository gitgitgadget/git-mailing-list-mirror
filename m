From: "Thanassis Tsiodras" <ttsiodras@gmail.com>
Subject: Re: Are binary xdeltas only used if you use git-gc?
Date: Fri, 31 Oct 2008 16:22:57 +0200
Message-ID: <f1d2d9ca0810310722s4338a245wb4bb1c300d701332@mail.gmail.com>
References: <f1d2d9ca0810310243r669840bbj2c5ee7183e0caaed@mail.gmail.com>
	 <vpqy705rl5u.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Matthieu Moy" <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Oct 31 15:24:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kvuv7-0005pL-S2
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 15:24:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbYJaOW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 10:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbYJaOW7
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 10:22:59 -0400
Received: from mu-out-0910.google.com ([209.85.134.189]:29278 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbYJaOW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 10:22:58 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1154317muf.1
        for <git@vger.kernel.org>; Fri, 31 Oct 2008 07:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=3H7+qSaAAYEwqhwLbhnxeCbtV3vXOJ5HjgzSD1yJjsI=;
        b=RcEzaJUpneI/Oi3cqH4/5PMEQtel9eU9tBnIRISA4vDIricZ3TnVXtVjGeH7n24rC8
         5ozW2bTxhuioT/yCNU6XctmdH5zGBCIbed1qYOROq64yRVs8he+Y+zZ1jXkHgw+0H1RR
         cr5DgR/KbIY09lr7li7NPdLr8ltHInBjOw6As=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=IBSHv4rR9A9USFTqVjD+Q4INUgE8W+BtA2q2I35Vbqkowttb0dcRzY/8idRvePBIkg
         0f/rc1RMrnMJPIY3n03bvsKKNKrAFQNPyVRaoNGXdvgCBYB2YEdR17SAIAAY+ubNgwHr
         CpgADSKKGukje5TJd/U37q9BQlWxfojzrNZSI=
Received: by 10.181.141.7 with SMTP id t7mr3089945bkn.10.1225462977032;
        Fri, 31 Oct 2008 07:22:57 -0700 (PDT)
Received: by 10.181.5.13 with HTTP; Fri, 31 Oct 2008 07:22:57 -0700 (PDT)
In-Reply-To: <vpqy705rl5u.fsf@bauges.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99588>

Actually, I am not so worried about disk size - I am far more worried
about how long it takes to git-push over my PSTN modem connection.

I'll try Jakub's suggestion (git-gc on both my machine and the remote
machine hosting the repos) and report back.

On Fri, Oct 31, 2008 at 2:42 PM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> If you're worried about repository size and you have a permanently
> running machine, a good idea is to run git gc in a cron job, so that
> you work fast in daytime, and your computer optimizes hard at night
> time ;-) (I have gic gc + git fsck in a cron job, so I'll also know if
> a repository gets corrupted).
>
> --
> Matthieu
>



-- 
What I gave, I have; what I spent, I had; what I kept, I lost. -Old Epitaph
