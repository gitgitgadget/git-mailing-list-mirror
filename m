From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: DWIM "git checkout frotz" to "git checkout -b frotz
 origin/frotz"
Date: Sun, 6 Jun 2010 19:32:33 +0200
Message-ID: <20100606173233.GA11041@localhost>
References: <20100605110930.GA10526@localhost>
 <AANLkTilbg2nGr_sVmJLboMgXbas_qsB4V6gYxDxcDgKy@mail.gmail.com>
 <20100605135811.GA14862@localhost>
 <AANLkTikE5BPD_DDqwEvPGxsMAIQCulpVwRKaCSnULcoP@mail.gmail.com>
 <20100606161805.GA6239@coredump.intra.peff.net>
 <20100606165554.GB10104@localhost>
 <AANLkTinTI3XaE6P_WZ_k56fgI4LNOLSalv_1GlVZNO7n@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Sverre Rabbelier <srabbelier@gmail.com>,
	git@vger.kernel.org, Peter Rabbitson <ribasushi@cpan.org>
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 06 19:33:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLJiU-00013c-Rc
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 19:32:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174Ab0FFRck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 13:32:40 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:38136 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932125Ab0FFRcj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 13:32:39 -0400
Received: by ey-out-2122.google.com with SMTP id 25so170133eya.19
        for <git@vger.kernel.org>; Sun, 06 Jun 2010 10:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=f9XfXfGTKhEftwRzd9cDFR4EIPjGK10LN/9vxUKhoMQ=;
        b=jLHNdotDpODw++re6HGbcd75pF9RWKb8w4JYWyLP9m4AXnLeurJIBglocMuEkXtF5/
         LdVp+pez88zM56DxzYX6a791Fv/dM3IAS6+qron7AxQWmAHL/F4D/egHWND/T2nveOmd
         RkzNnzmr4hO0hMdZci3WM49jfXb5qLpvud0PU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=gYAWgsKSlbUdjgotUcG0MxCHUnH2Pl8+KKdw9yj+Epc/RG7yn5Hr3V8XmqPTmxjCfL
         phchGGoN/7rZ2riuuLrzljVrgWKHDXKrEVO2SQYcsbNuTULIy88+e5Priy67UYyFcznM
         IPF5wiOhlslpW6uHv1sPfNlWGLH7NuilbRPhg=
Received: by 10.213.2.194 with SMTP id 2mr353077ebk.77.1275845557779;
        Sun, 06 Jun 2010 10:32:37 -0700 (PDT)
Received: from darc.lan ([80.123.242.182])
        by mx.google.com with ESMTPS id 16sm2099617ewy.15.2010.06.06.10.32.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Jun 2010 10:32:37 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OLJi5-0002wp-QD; Sun, 06 Jun 2010 19:32:33 +0200
Content-Disposition: inline
In-Reply-To: <AANLkTinTI3XaE6P_WZ_k56fgI4LNOLSalv_1GlVZNO7n@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148528>

On Sun, Jun 06, 2010 at 09:59:08AM -0700, Jacob Helwig wrote:
> On Sun, Jun 6, 2010 at 09:55, Clemens Buchacher <drizzd@aon.at> wrote:
> >
> > I argue that people are more likely to be surprised and confused by
> > this feature rather than being accustomed to it already. I am also
> > waiting to hear from someone who actively uses this feature.
> >
> 
> I am someone that "actively" uses this feature.  I will often have
> repositories that I use on multiple machines, and will forget which
> remote branches I have local tracking branches for, on which machines.
>  I'll end up just doing `git checkout $random-branch`, thinking I'm on
> one of the machines where I've already setup the local branch, and
> find it quite handy that Git _does_ DWIM.

I see. But would it be so terrible to have to type "git checkout -t
origin/branch" instead?

Also, isn't this more like "foretell what I really want" rather
than "do what it means"? Who would guess that "git checkout
$branch" means "create $branch tracking <random-remote>/$branch"?

And this is exactly _why_ it can be marginally useful if the
foretelling is correct, but all the more confusing if it's not.
