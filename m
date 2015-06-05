From: Rossella Barletta <rossella.barletta@gmail.com>
Subject: Re: Permission denied ONLY after pulling bundles
Date: Fri, 5 Jun 2015 08:54:27 +0200
Message-ID: <CAJeiYQH9jF4S6FivHW5xc_xeef5kL1r1xF+yjJuHf7Wa0yUifw@mail.gmail.com>
References: <CAJeiYQGUsB-9XYdnqDgoSy5JU-EVTbf-1OuTU5BGfpT9q6xKbg@mail.gmail.com>
	<CAP8UFD1=96Y484GvG9ms2uiWm2uyWO0qE2Lh6SH2UwrwHpEF8w@mail.gmail.com>
	<41C6F74EB68C43E183AF26092D2AAD44@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>, dario.ligorio@selex-es.com
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 08:54:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0lWU-00067k-4z
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 08:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075AbbFEGy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 02:54:29 -0400
Received: from mail-qc0-f175.google.com ([209.85.216.175]:33146 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858AbbFEGy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 02:54:27 -0400
Received: by qcnj1 with SMTP id j1so802086qcn.0
        for <git@vger.kernel.org>; Thu, 04 Jun 2015 23:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CEPBRfWsumzVsjnRYbRFineTA4hztPU+gK37L1u5muY=;
        b=kzEj+9Fj1TPCr+S3uPYAKpORPXkidc3SaoX5UY6zlarfQhDtv6Eg9WX2RipI5leCjb
         1OLo9GBwyJVtm6ATZ9gQ7wfOm3E+qijuWT0hZTysMqy4eDQ6+DSpw+g0Wsrf4igCRsLi
         QjxBCjWocT207PjD5z8Q2u138bL1/A2+OxDRcwgrW7wBLrTT13nlrRTBm8+feKc+HfxS
         NttIlTF1nS3aGvVslqL8cuh0vEV6WyptZy88HZY8K6PfEAXfxR3z5wzTLdsLFv3aLljr
         55uf06JPHZHBGdnebWQ+H/EgHOiurF340T2K/7rwcBIUJ9gxv1VuXc2KZbaIMK+LQFZ/
         k/ag==
X-Received: by 10.55.16.146 with SMTP id 18mr3675362qkq.39.1433487267063; Thu,
 04 Jun 2015 23:54:27 -0700 (PDT)
Received: by 10.96.58.165 with HTTP; Thu, 4 Jun 2015 23:54:27 -0700 (PDT)
In-Reply-To: <41C6F74EB68C43E183AF26092D2AAD44@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270815>

Dear Philip and Christian,

Here my answers:

1)  We have a repository that we got from another person in another
city.We use the same CENTOS_6 . We put the repository on Windows
machine, on which we can access remotely and mounted the directory on
CENTOS_6, that we use by the WMVare Player (basically we all have
Windows on our machines, through the VMPlayer we access the local
files of CENTOS_6) .

As i got the bundle file i pulled it on my CENTOS_6 machine on the
same branch :  git pull NAME_BRANCH.bundle NAME_BRANCH

The bundle has been created : git bundle create NAME_BRANCH.bundle NAME_BRANCH

The 2 repositories, the one we get from our colleagues and our local
one are the same.Now are trying to share changes through bundles and
we are using the same branch name to create bundles and pull bundles.


2) I did not check the permission before and after , we have several
files and several directories, ,but after having the problem i just
gave the chmod -R 777 to all the files, i am sure that all the files
involved have those permission. Still i get the problem when trying to
push.

3) I tryed to clone the repository using --bare, and i used it as a
local repository on linux. Only in this case i can push without
problems after pulling the bundle.

So if the repository is on the local machine itself (CENTOS_6) i do
not have the problem. But we need to have it in a shared folder on
windows. When we try to push on the repository on Windows we get
permission problems.(Of course we dont get problems before pulling the
bundle).

So again the 2 possibilities that we tryed are:

FIST ONE (PERMISSION PROBLEMS)

- Repo is on windows
- Repo folder is shared
-Repo is a copy of another repository being on a machine in another
city on which we cannot access. We got all the files, included the
folder .git a put everything in our shared folder
- Mounted the Repo folder on Linux
-Created the clone
- got a bundle from the original repository (bundle created from a branch)
-pulled the bundle in the same branch



SECOND ONE (NO PROBLEMS BUT WE CANT USE THIS)
- Repo is on Linux
-Repo is a copy of another repository being on a machine in another
city on which we cannot access.
- got a bundle from the original repository (bundle created from a branch)
-pulled the bundle in the same branch



4) Git version is 1.7.1

5) For Philip: The config file has not changed.


Thank you all for your support


2015-06-04 21:25 GMT+02:00 Philip Oakley <philipoakley@iee.org>:
> From: "Christian Couder" <christian.couder@gmail.com>
>
>> Hi,
>>
>> On Thu, Jun 4, 2015 at 3:04 PM, Rossella Barletta
>> <rossella.barletta@gmail.com> wrote:
>>>
>>> Dear git group,
>>>
>>>
>>> I would like to ask your help for a problem that we cannot fix in any
>>> way.
>>>
>>> We have a git repository in folder on Windows.
>>>
>>> Then we use VMware player on CentOS_6 on which we create a clone of
>>> the git repository, after of course having mounted the directory in
>>> which the repository is.
>>>
>>> So the repository is on windows and the clone on Linux.
>>>
>>> We are able to perfom all the git operations we need, except for the
>>> pull .bundle, which is successful in itself but prevent us from
>>> pushing after that.
>>
>>
>> It is not very clear how the bundle has been made, and on which
>> machine you made it and you pulled from it.
>>
>>> As we try to push after pulling a .bundle in a branch we get the error
>>> message
>>>
>>> NODE1:fdp> git push
>>> Counting objects: 1977, done.
>>> Delta compression using up to 2 threads.
>>> Compressing objects: 100% (423/423), done.
>>> fatal: write error: Permission denied00 KiB | 158 KiB/s
>>> error: pack-objects died of signal 13
>>> error: pack-objects died with strange error
>>
>>
>> Can you have a look at the machine you push to and see if some file or
>> directory permissions changed between before and after you made the
>> bundle or you pulled the bundle?
>>
>>> We have checked all the permissions, changed the users, recreated the
>>> clone but nothing worked.
>>
>>
>> What do you mean by checked all the permissions?
>> You mean that permissions haven't changed at all since before you
>> pulled the first bundle?
>>
>>> The push operation works perfectly until we pull a bundle. After
>>> pulling a bundle we are not able to push anymore.We tryed to delete
>>> the branches, recreate others and all works perfectly, also the
>>> push.As we pull the .bundle we cannot get the permission to do the
>>> push anymore.
>>>
>>> What has this to do with the bundle?
>>
>>
>> Did you try to everything (cloning, creating a bundle, pulling it and
>> pushing on the same machine to see if it makes a difference? Also did
>> you try with another smaller fake repository?
>>
>> If you can reproduce with a smaller fake repo on just one machine it
>> could help us reproduce on one of our machine and have a look.
>>
>> And could you tell us which version of git (using git --version) you
>> are using on both machines?
>>
> --
> Also, check the config file to see if the push url has somehow changed to
> the bundle file?
>
> I know that if you clone from a bundle the origin is set to the bundle file,
> so that you can push back into it for the return sneakernet (RFC 1194 ?)
> journey. It maybe that fetching from a bundle does the same setup (not
> looked at the code)
>
> --
> Philip



-- 
Rossella
