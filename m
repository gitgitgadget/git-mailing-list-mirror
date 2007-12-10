From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [RFC] Configurable name(s) for .gitmodules
Date: Tue, 11 Dec 2007 00:20:51 +0800
Message-ID: <46dff0320712100820yb41cbc6q5b36143bc6b6d47f@mail.gmail.com>
References: <46dff0320712070800j6dd83714j265b3f7b291b855c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 10 17:21:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1lNn-0007ZD-6W
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 17:21:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461AbXLJQUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 11:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752282AbXLJQUx
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 11:20:53 -0500
Received: from el-out-1112.google.com ([209.85.162.176]:11220 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066AbXLJQUw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 11:20:52 -0500
Received: by el-out-1112.google.com with SMTP id v27so242003ele
        for <git@vger.kernel.org>; Mon, 10 Dec 2007 08:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=YZgWfUYkU77UoxY8+J7SAhovbOjv6/kgCtssczJNR1k=;
        b=OVHs2llLUbOBfg6wajuWb8ivqVkW7kJajjNtLVS3bvvambChf365XoHvOf5wfxL3kYlc7MWMDXJUUlv1XZtDSrbIg4150FC8P0XIZDibufeQ00kSlJca1NXC6ud48U4Oixt8jf1OEvq2qBy34wuPbpFVvHB+u6clcQn+kvImfL4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CvDIBzoqwnVBcmsSaV+aok3jol6JUwRIwUqVGwdwCiQoYI/bSMQd3dkfyk/US4IeCxphBlM6ufItTLl+YurVQXp8zAP7vua1XbY/mgyqBn6rvKGJAYDD8220kO2teWhSeWPdAUEiYpdmGJL3KIYf2TO00MqadAtwmQWEa9+rPiw=
Received: by 10.150.91.20 with SMTP id o20mr1269524ybb.1197303651363;
        Mon, 10 Dec 2007 08:20:51 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Mon, 10 Dec 2007 08:20:51 -0800 (PST)
In-Reply-To: <46dff0320712070800j6dd83714j265b3f7b291b855c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67729>

On Dec 8, 2007 12:00 AM, Ping Yin <pkufranky@gmail.com> wrote:
> I have a super project with many submodules. Each kind of role may
> check out different set of submodules. There are some common modules
> which are almost checked out by every role.
>
> Here comes my question: how to implement this elegantly? If all
> submodules are put in the same .gitmodules, every role has to in the
> command line manually designate all submodules to be checked out.
> However, it's hard to remember which submodules is required by which
> role, not to mention the so huge .gitmodules. Maybe a script for each
> role can help, but it's a little ugly.
>
> If the name for '.gitmodules' is configurable, we can check in
> modules.roleA and modules.roleB, etc. Then role A can designate the
> corresponding modules.roleA as .gitmodules. Furtherly, if mutiple
> names are allowed,  for common modules, we can have modules.common and
> then submodule.defaultnames="modules.common, modules.roleA"  to avoid
> duplicated module name entires in both modules.roleA and
> modules.roleB.
>
> I have gone deeply into git-submodule.sh and see
> "GIT_CONFIG=.gitmodules" is used. However, configuable multiple names
> can't be implemented in this way.
>
> Recap:
> 1. configurable name for '.gitmodules'
> 2. better to allow mutiple names
> 3. the implementation issue for mutiple names
>

Can anyone give me some suggestion? Does it make sense to make
GIT_CONFIG record multiple config files, such as
"GIT_CONFIG=modules.roleA:modules.roleB"? Or any better way?

> --
> Ping Yin
>



-- 
Ping Yin
