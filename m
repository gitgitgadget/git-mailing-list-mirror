From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Permission denied ONLY after pulling bundles
Date: Thu, 4 Jun 2015 20:25:38 +0100
Organization: OPDS
Message-ID: <41C6F74EB68C43E183AF26092D2AAD44@PhilipOakley>
References: <CAJeiYQGUsB-9XYdnqDgoSy5JU-EVTbf-1OuTU5BGfpT9q6xKbg@mail.gmail.com> <CAP8UFD1=96Y484GvG9ms2uiWm2uyWO0qE2Lh6SH2UwrwHpEF8w@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "git" <git@vger.kernel.org>, <dario.ligorio@selex-es.com>
To: "Christian Couder" <christian.couder@gmail.com>,
	"Rossella Barletta" <rossella.barletta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 21:25:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0alU-0000YX-9a
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 21:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbbFDTZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 15:25:15 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:49430 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752199AbbFDTZO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jun 2015 15:25:14 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CLbgAupXBVPBTKYAJbgxBUXoMegy5tuGyFdQQEAoE7TQEBAQEBAQcBAQEBQSQbQQECAoNXBQEBAQEDCAEBGRUeAQEhCwIDBQIBAxUDAgIFIQICFAEECBIGBwMUBgESCAIBAgMBiAcDFrdrhlSYEw2FR4EhiiKCTYI5gm8vgRYFghaEVIYQhiB7g0GFCYMOPo5agzCDWYEFgSgcgVM9MYJHAQEB
X-IPAS-Result: A2CLbgAupXBVPBTKYAJbgxBUXoMegy5tuGyFdQQEAoE7TQEBAQEBAQcBAQEBQSQbQQECAoNXBQEBAQEDCAEBGRUeAQEhCwIDBQIBAxUDAgIFIQICFAEECBIGBwMUBgESCAIBAgMBiAcDFrdrhlSYEw2FR4EhiiKCTYI5gm8vgRYFghaEVIYQhiB7g0GFCYMOPo5agzCDWYEFgSgcgVM9MYJHAQEB
X-Header: TalkTalk
X-IronPort-AV: E=Sophos;i="5.13,554,1427756400"; 
   d="scan'208";a="601891713"
Received: from host-2-96-202-20.as13285.net (HELO PhilipOakley) ([2.96.202.20])
  by out1.ip05ir2.opaltelecom.net with ESMTP; 04 Jun 2015 20:25:13 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270795>

From: "Christian Couder" <christian.couder@gmail.com>
> Hi,
>
> On Thu, Jun 4, 2015 at 3:04 PM, Rossella Barletta
> <rossella.barletta@gmail.com> wrote:
>> Dear git group,
>>
>>
>> I would like to ask your help for a problem that we cannot fix in any 
>> way.
>>
>> We have a git repository in folder on Windows.
>>
>> Then we use VMware player on CentOS_6 on which we create a clone of
>> the git repository, after of course having mounted the directory in
>> which the repository is.
>>
>> So the repository is on windows and the clone on Linux.
>>
>> We are able to perfom all the git operations we need, except for the
>> pull .bundle, which is successful in itself but prevent us from
>> pushing after that.
>
> It is not very clear how the bundle has been made, and on which
> machine you made it and you pulled from it.
>
>> As we try to push after pulling a .bundle in a branch we get the 
>> error message
>>
>> NODE1:fdp> git push
>> Counting objects: 1977, done.
>> Delta compression using up to 2 threads.
>> Compressing objects: 100% (423/423), done.
>> fatal: write error: Permission denied00 KiB | 158 KiB/s
>> error: pack-objects died of signal 13
>> error: pack-objects died with strange error
>
> Can you have a look at the machine you push to and see if some file or
> directory permissions changed between before and after you made the
> bundle or you pulled the bundle?
>
>> We have checked all the permissions, changed the users, recreated the
>> clone but nothing worked.
>
> What do you mean by checked all the permissions?
> You mean that permissions haven't changed at all since before you
> pulled the first bundle?
>
>> The push operation works perfectly until we pull a bundle. After
>> pulling a bundle we are not able to push anymore.We tryed to delete
>> the branches, recreate others and all works perfectly, also the
>> push.As we pull the .bundle we cannot get the permission to do the
>> push anymore.
>>
>> What has this to do with the bundle?
>
> Did you try to everything (cloning, creating a bundle, pulling it and
> pushing on the same machine to see if it makes a difference? Also did
> you try with another smaller fake repository?
>
> If you can reproduce with a smaller fake repo on just one machine it
> could help us reproduce on one of our machine and have a look.
>
> And could you tell us which version of git (using git --version) you
> are using on both machines?
>
--
Also, check the config file to see if the push url has somehow changed 
to the bundle file?

I know that if you clone from a bundle the origin is set to the bundle 
file, so that you can push back into it for the return sneakernet (RFC 
1194 ?) journey. It maybe that fetching from a bundle does the same 
setup (not looked at the code)

--
Philip 
