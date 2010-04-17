From: Miguel Ramos <mail@miguel.ramos.name>
Subject: Re: Using a git repository on the root directory
Date: Sat, 17 Apr 2010 12:58:45 +0100
Message-ID: <v2l3e2876431004170458ib2d40b28he1fb56906f94a7ed@mail.gmail.com>
References: <q2k3e2876431004161344vfff638a7ncfa74aa0e3b979dc@mail.gmail.com>
	 <4BC9364D.7020204@gmail.com>
	 <alpine.DEB.2.01.1004162120490.16996@asgard.lang.hm>
	 <t2g3e2876431004170415r71d5f834z3bfdedfaec076c6c@mail.gmail.com>
	 <alpine.DEB.2.01.1004170439170.16996@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Gabriel Filion <lelutin@gmail.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sat Apr 17 13:58:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O36fk-0008L7-7U
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 13:58:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757236Ab0DQL6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 07:58:47 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:37780 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756574Ab0DQL6q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 07:58:46 -0400
Received: by qyk34 with SMTP id 34so4250252qyk.22
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 04:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:received:message-id:subject
         :from:to:cc:content-type;
        bh=8AILdwkKGAJbKUB8ugfPxBLVmaVpGggkWld8EhyCOEE=;
        b=H0QwLE/UyX36pMF6hd4Xm2V0TfIHQDQeD50InIoqaoZYaRUQOHU8tDqvTiCArlz+S9
         pmgflrNY5liGZt4W7zuIBI2Mfde7/9mR4SJ6Q2tFwt9UYi4PunhlhIYzS0Nl3qRIRjEe
         EH8QGWcfoyTn/lnTUchpA24X4h9bcECvmSeTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=eOcbyjbAk0kpciL6gnHH5qErEOHI3SS+zNffFgH3OV7+Waauxin6AGNcz9B9nAriAB
         LoNBRqHMkAKI12sB7xn7OcEW6LeqDy9w2PBCVbn6h/MzpQCLb8ZE0vM7M7jSmdPF/qC0
         s7ctcdO5iUTbo26BQaHMhqU98bbqsPpnjLVo8=
Received: by 10.229.90.199 with HTTP; Sat, 17 Apr 2010 04:58:45 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.01.1004170439170.16996@asgard.lang.hm>
X-Google-Sender-Auth: 4f9982cdba3e78d5
Received: by 10.229.232.144 with SMTP id ju16mr3799502qcb.107.1271505525718; 
	Sat, 17 Apr 2010 04:58:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145141>

2010/4/17  <david@lang.hm>:
> On Sat, 17 Apr 2010, Miguel Ramos wrote:
>
>> Well, David, you certainly made a good case defending using a VCS for
>> filesystems.
>> However, a versioned filesystem should be more adequate for that.
>
> a versioned filesystem will not let you easily clone or backup your system.
> a versioned filesystem could be a nice UI to access a DVCS that would give
> you this sort of ability
>
>> Why would one want diffs, patches, branches, merges for the entire
>> filesystem?
>
> these all seem like very useful things to me
>
> diffs to find out what changed when a system gets broken, or after something
> new is installed.
>
> patches could be a way to either install software, or to propogate updates
> between systems.
>
> branches could easily be different systems
>
> merges are for when you have two systems each doing one job and you want to
> combine them onto one piece of hardware (could could do it with
> virtualization, if you are willing to pay the overhead). you wouldn't want
> to merge the binary files, but you would want to merge the branches that
> contain binary files.
>
> there are many reasons why you don't just use your linux distro tools to
> manage large numbers of machines and configurations.
>
> David Lang

Yes, you certainly are right.
It does open up a set of new possibilities.
Even better if it was based on a binary diff, because otherwise you
either had to be very conservative updating software or run out of
space.

-- 
Miguel Ramos <mail@miguel.ramos.name>
PGP A006A14C
