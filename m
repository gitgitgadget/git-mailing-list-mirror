From: Kevin <ikke@ikke.info>
Subject: Re: cvs2git migration
Date: Tue, 14 Feb 2012 20:45:02 +0100
Message-ID: <CAO54GHDa5x5v3WooQ4gVcVvAy4XOUP7BbhjZx6xWFm=JzTxdQg@mail.gmail.com>
References: <1329220866066-7283631.post@n2.nabble.com> <1329244386868-7285021.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: supadhyay <supadhyay@imany.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 20:45:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxOJc-0007F6-Ub
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 20:45:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760053Ab2BNTpY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Feb 2012 14:45:24 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:49091 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754994Ab2BNTpX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2012 14:45:23 -0500
Received: by werb13 with SMTP id b13so180098wer.19
        for <git@vger.kernel.org>; Tue, 14 Feb 2012 11:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=CCT6iPHUcIRb3+Hwii9p2AyCoZ6/Zq3wl3cuLwRu1vE=;
        b=a03XcGkry3EItqDuY7SE6B8lT8/QybDo8xa5XmBQ/Inb4M5m3m9cvFRezFgyuDcX7c
         lDFq/i+AYWto8d6MuG/K9UGHcXfUzu9+ZCBBFrxL9XewCwYhBoUSUnhd+5NqDGUhy9FL
         1txKi94UZV3IoMXgeVErXLX9wnE+cB+Jo8G9M=
Received: by 10.180.78.6 with SMTP id x6mr4087137wiw.18.1329248722300; Tue, 14
 Feb 2012 11:45:22 -0800 (PST)
Received: by 10.227.113.74 with HTTP; Tue, 14 Feb 2012 11:45:02 -0800 (PST)
In-Reply-To: <1329244386868-7285021.post@n2.nabble.com>
X-Google-Sender-Auth: 6Q4Pm8K8nQA4JhTy8uMDHGMIlu4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190739>

Hi,

Because git is distributed, it has no user management (which is
impossible to do). Every user adds his name and e-mail address to his
global .gitconfig file.

=46or access control, you can check gitolite [1].


[1]: http://github.com/sitaramc/gitolite

On Tue, Feb 14, 2012 at 7:33 PM, supadhyay <supadhyay@imany.com> wrote:
> Hi All,
>
> Can any one please update me what would be the method/steps to migrat=
e
> existing CVS users to GIT in CVS2GIT migration? User migration is pos=
sible
> or not?
>
> Thanks in advance...
>
> --
> View this message in context: http://git.661346.n2.nabble.com/cvs2git=
-migration-tp7283631p7285021.html
> Sent from the git mailing list archive at Nabble.com.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
