From: Israel Garcia <igalvarez@gmail.com>
Subject: Re: backup git repo on every commit
Date: Tue, 13 Oct 2009 13:08:16 -0500
Message-ID: <194a2c240910131108h10acbacdy68306c9c3389517@mail.gmail.com>
References: <194a2c240910120641sccf0e55xef4226269df78864@mail.gmail.com>
	 <20091012141544.GF9261@spearce.org>
	 <194a2c240910120725u72cdb588p3c66bc730e6953d@mail.gmail.com>
	 <20091012143043.GJ9261@spearce.org>
	 <194a2c240910130943j40c12902o760e463e7a8ce8fa@mail.gmail.com>
	 <20091013174913.GV9261@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 13 20:24:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxm2z-0006Ju-2v
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 20:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760844AbZJMSIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 14:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760842AbZJMSIy
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 14:08:54 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:58134 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760822AbZJMSIx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 14:08:53 -0400
Received: by fxm27 with SMTP id 27so10515670fxm.17
        for <git@vger.kernel.org>; Tue, 13 Oct 2009 11:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=s9lsX9r4IrV8rmWvGtoDdYQZlaQZBbZ6EDodJThuDK4=;
        b=jE4lcj7HQj0/RELh/h/4DetFOrlu85LhgMpko8MymNoPIbBhAEjhLoQELn3wo7ArNg
         bBk4sIqcR+dGm/dVjuaCSO00YqABhizjnRKfrZlfK0KONGgRMHJBUXg9U+tYcPkMnyln
         enW8/91WAbvpMtLFCYgthbxb828aS2Zj/APbo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=TVyYYHEdgRuu6+Nnk65VTCATsvgdAOfqvvCCDNoA8yEOHHuUnj2PjN960dqoiBwOhM
         bK12FNKX8u10jbMJ1drLT32gIOvVdrNzBaNg75JZtqie83PXsG+4xfDSQTi40X6JjGSh
         yTOL0wC4Ck+q1JZXyCDj4ne+rvfL+OZxZ1ogg=
Received: by 10.204.174.209 with SMTP id u17mr6464478bkz.7.1255457296524; Tue, 
	13 Oct 2009 11:08:16 -0700 (PDT)
In-Reply-To: <20091013174913.GV9261@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130175>

On 10/13/09, Shawn O. Pearce <spearce@spearce.org> wrote:
> Israel Garcia <igalvarez@gmail.com> wrote:
>> Sorry to ask again, but I'm a little confuse about how git work in my
>> case.
>> I use gitosis on a server where I have all repos
>> (/usr/local/git/repositories/), so different people clone their repos
>> on their computers. What I want is to backup, on gitosis server, all
>> repos in /backups/git/repositories/ after every commit. So, my
>> questions are:
>>
>> Do I have to run these two comands on tha gitosis server?
>
> Yes.
>
>> The post-commit are execute on gitosis server or on the remote pc?
>
> Actually, you need the post-update hook.  post-commit doesn't run
> on the gitosis server.
>
> I suggested post-commit because I thought you were talking about
> backing up your local working directory each time you called
> "git commit".  But since you are actually backing up every
> "git push" you need to use the hooks invoked by that instead.
Hi Shawn,

Thanks for your answer,  could you please put here how you think
post-update file should be setup? Remember in my case I want to backup
every repo to /backups/git folder for example.

Thanks in advance.
regrads

Israel.
>
> --
> Shawn.
>


-- 
Regards;
Israel Garcia
