From: Patrik Gornicz <patrik-git@mail.pgornicz.com>
Subject: Re: SSH version on Git 1.8.1.2 for Windows is outdated.
Date: Sat, 16 Mar 2013 16:49:27 -0400
Message-ID: <5144DAD7.50203@mail.pgornicz.com>
References: <CAJ5Q6vXTyaegQq2uMoK7QQVYiYS9GcJhCefkQs9tXxqU=M10Vg@mail.gmail.com> <20130315210325.7b0a3505ffa4d46e7e716324@domain007.com> <51438058.7080204@workspacewhiz.com> <51447052.1020407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	Konstantin Khomoutov <kostix+git@007spb.ru>,
	Kristof Mattei <kristof@kristofmattei.be>, git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 16 21:55:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGy8x-0007x5-FI
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 21:55:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433Ab3CPUz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Mar 2013 16:55:29 -0400
Received: from li287-246.members.linode.com ([66.228.37.246]:46088 "EHLO
	mail.pgornicz.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751325Ab3CPUz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Mar 2013 16:55:28 -0400
X-Greylist: delayed 354 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Mar 2013 16:55:28 EDT
Received: from [192.168.1.110] (CPEc0c1c09f18e2-CM0026f321196d.cpe.net.cable.rogers.com [99.236.108.68])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.pgornicz.com (Postfix) with ESMTPSA id 6C6D549C1B;
	Sat, 16 Mar 2013 16:49:33 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130120 Thunderbird/17.0.2
In-Reply-To: <51447052.1020407@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218318>


On 03/16/13 09:14, Sebastian Schuberth wrote:
> On 15.03.2013 21:11, Joshua Jensen wrote:
>
>>> Yes, you should grab the msysGit (the Git for Windows build
>>> environment) [2], tweak it to include the new OpenSSH binary, ensure it
>>> builds and works OK and then send a pull request (or post your patchset
>>> to the msysgit mailing list [3].
>>>
>> Wow, we can do that now?
>>
>> When I brought up the vastly improved performance from a newer SSH
>> executable, I was told the only way to get it in would be to build from
>> source [1].
>
> "tweak it to include the new OpenSSH binary" is supposed to include the
> step to adjust the release.sh script to grab the updated sources and
> build the binary.

I attempted to do just this about a month ago though things really 
started to snowball. To get openssh to compile you need to update a 
bunch of other programs in the msys branch and I just lost interest in 
doing so. More info can be found in the msysgit issue "Upgrade SSH" [1].

> However, another option is to take a look at the new mingwGitDevEnv
> project [1], which relies on mingw-get to retrieve binary packages. I
> hopefully find soon the time to include OpenSSH 6.1p1 incl. HPN-SSH
> patches [2].

Any idea as to when this mingwGitDevEnv project will be mature enough to 
use as a replacement for msysgit? One of the reasons I gave up trying to 
tweak things to get openssh compiling was that this seemed like a much 
better idea. Though if it's fair off I might find time to give it 
another shot.

> [1] https://github.com/sschuberth/mingwGitDevEnv
> [2] https://github.com/sschuberth/mingwGitDevEnv/pull/5

If someone is keen to try and update openssh in msysgit I'd be willing 
to share my hacks from a month ago which could be used as a starting 
point. It was left nowhere near ready for a pull request, partially due 
to binary issues mentioned above, but at least it'll provide reasonable 
ideas to a few of the things that need to happen.

[1] https://github.com/msysgit/msysgit/issues/31

Patrik
