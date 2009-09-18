From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: Big project, slow access!
Date: Fri, 18 Sep 2009 16:05:26 -0300
Message-ID: <a4c8a6d00909181205x6b8c348ct270fba6d27df5604@mail.gmail.com>
References: <ffb2c0280909181138r7fde8722n80be4bdf95864c37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Toan Pham <tpham3783@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 18 21:05:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Moilx-0002ZA-6F
	for gcvg-git-2@lo.gmane.org; Fri, 18 Sep 2009 21:05:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754852AbZIRTFX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Sep 2009 15:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754782AbZIRTFX
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Sep 2009 15:05:23 -0400
Received: from mail-yx0-f173.google.com ([209.85.210.173]:35250 "EHLO
	mail-yx0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250AbZIRTFX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Sep 2009 15:05:23 -0400
Received: by yxe3 with SMTP id 3so1515790yxe.4
        for <git@vger.kernel.org>; Fri, 18 Sep 2009 12:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=z6zPwrZ1HT8bqbcTi1RhYnEfDWKKywdJineLu4MzRkQ=;
        b=MdkmUlQAbfUr06uNb4WlLPE+yH77jGmxjCmm9U1FajFRf/8O316qyeFXm4PPUR1T2p
         uFyUWzvK8KpkVY7zympQtnSaokBCc13qh8XG4BT4zHJiIclF4AB/HzjXJehmPyFfaLLw
         BkUJDQuvqWqR+aKgnwZYSnnZF5WmSb436s2rE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vAWI4kGAMHOHGKuaQ8KilvyOwev59H2lIhgeEQ9Fbs0u3HjWJBS/OdPPCUyWuKdxj7
         qGPJhckjfl7kAddFrGg4TpE1TX3c2diAnHQfzWlngjeNlR5L7fr4Iqilt/cwvacKTxxA
         Iv2sEl1jQy6rX/1+H3JZ6lLrRIsDOWWnIq430=
Received: by 10.101.203.6 with SMTP id f6mr1802189anq.172.1253300726394; Fri, 
	18 Sep 2009 12:05:26 -0700 (PDT)
In-Reply-To: <ffb2c0280909181138r7fde8722n80be4bdf95864c37@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128805>

On Fri, Sep 18, 2009 at 3:38 PM, Toan Pham <tpham3783@gmail.com> wrote:
> Hi,
>
> I use git to maintain a project that is at least 8 gigs in size.
> The project is a Linux from Scratch repository that includes source
> codes to approximately 2000 open source projects,
> gcc tool-chain, 1000+ configurations for different software packages,
> source code for different kernel versions,
> and many linux distributions/flavors resulted from this LFS build env=
ironment.
>
> The git's object repository is now 4.6 gigs and consists of approx.
> 610,000 files and folders.
> The speed of git is now terribly slow. =A0Each time I use basic comma=
nds
> like 'git status' or 'git diff',
> it would take at least 5 minutes for git to give me back a result.
> Again, the machine that i run git on is a P4 3.2 gig-hertz with HT.
>
> would =A0someone please recommend on how i can optimize git's perform=
ance?
> Git is so slow, are there better ways to manage a project like this?
Git is so slow? What you expect with 4.6 gigs? It take some time to do
the things. And it is not slow. It is very fast, and it was created
with this goal, to be more fast than others VCS.
>
>
> Thank you.
>
>
> Toan
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
