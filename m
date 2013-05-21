From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Reading commit objects
Date: Tue, 21 May 2013 16:25:51 -0500
Message-ID: <CAMP44s2YLK=EQ+YGh5s9HLGAtgvtNvgDdmXMPpw+PRbODD08RQ@mail.gmail.com>
References: <CABx5MBQ57-=MPamvV-peZUdD_KDLX+5cy9vD7CL7p_Vz9BkvTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Chico Sokol <chico.sokol@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 21 23:25:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ueu4E-0002cm-5G
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 23:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544Ab3EUVZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 17:25:54 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:55006 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199Ab3EUVZx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 17:25:53 -0400
Received: by mail-la0-f53.google.com with SMTP id ea20so1230561lab.26
        for <git@vger.kernel.org>; Tue, 21 May 2013 14:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LLbWxrhOZmzaQBaetLU8zKf90s7gPwA91deOwJad12I=;
        b=No/uIVjS7GDVS0Kq5yc0leIsp3sIk3P4fBXVa0qMX988E5YDUM8T9E4oYDmlTyNZKp
         UwnPByrJz1enKpZ/If1Jw2qxIyQu9e1v0DeT7EJURw82tpANNWATbuvWP+j3xuVUPrm8
         DwjnvnVb1qcSn30krzGZeT7GH2Y137CdHFKT7LYEwakkgDw66lSENznfn1fJBAMi37bC
         aK8rZB4UXnQ6EBqpFPT4F4rCv8ZkZ9wgDjO2zmyhIrvFxm780WrDRqaGmWlCWTpWkaFD
         x7GFRk/gOfUyoxZjJpx4lw8SmFk0ArW9sl06hF9+fsE4Z+8yljbL8iXErkXLIoEVSZvX
         Iu0g==
X-Received: by 10.112.172.40 with SMTP id az8mr2539970lbc.88.1369171551827;
 Tue, 21 May 2013 14:25:51 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Tue, 21 May 2013 14:25:51 -0700 (PDT)
In-Reply-To: <CABx5MBQ57-=MPamvV-peZUdD_KDLX+5cy9vD7CL7p_Vz9BkvTg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225082>

On Tue, May 21, 2013 at 4:21 PM, Chico Sokol <chico.sokol@gmail.com> wrote:
> Hello,
>
> I'm building a library to manipulate git repositories (interacting
> directly with the filesystem).
>
> Currently, we're trying to parse commit objects. After decompressing
> the contents of a commit object file we got the following output:
>
> commit 191
> author Francisco Sokol <chico.sokol@gmail.com> 1369140112 -0300
> committer Francisco Sokol <chico.sokol@gmail.com> 1369140112 -0300
>
> first commit
>
> We hoped to get the same output of a "git cat-file -p <sha1>", but
> that didn't happened. From a commit object, how can I find tree object
> hash of this commit?

git rev-parse <sha1>:

-- 
Felipe Contreras
