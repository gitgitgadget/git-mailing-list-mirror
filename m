From: Arup Rakshit <aruprakshit@rocketmail.com>
Subject: Re: fatal: Unable to mark file .ruby-version
Date: Mon, 16 Mar 2015 05:29:12 +0000 (UTC)
Message-ID: <186241547.130512.1426483752551.JavaMail.yahoo@mail.yahoo.com>
References: <20150315174543.GA11832@vps892.directvps.nl>
Reply-To: Arup Rakshit <aruprakshit@rocketmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 16 06:39:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXNkP-0008BN-5u
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 06:39:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbbCPFjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 01:39:25 -0400
Received: from nm32-vm10.bullet.mail.gq1.yahoo.com ([98.136.216.233]:33867
	"EHLO nm32-vm10.bullet.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750822AbbCPFjX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Mar 2015 01:39:23 -0400
X-Greylist: delayed 409 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Mar 2015 01:39:23 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1426483953; bh=m17p1+6csZL4+MH1aoQVhp+3ZJ/jXLKtAtFUm8zwliI=; h=Date:From:Reply-To:To:In-Reply-To:References:Subject:From:Subject; b=gd9sK/0xJar8evSWVtMIyrgOtt5Zjg5/Tz3zG/34u0tZ1wvu7ls/pfYA63b8UtaQvYtLrnqb4a5Be8WrGd0P63eOV5eJi337/i3w+fRdk9yxs8nVi5HsUHqyO+GUfhQueZviRjHJbCbyekkxBLF4dRo2xQBHQ7Td/p4UZZ+CCMLgraJ+XDYoUzr6fGqEEkzCZX/0hbLpXgnv6IffciL7zhR7Dma03ifgyQMemSLQFkL/+hjcWvT53UGzEUVqduwB379JQKsZqnCkYx7KcmTzf0pzO3cNgtEgFnaMPF8Y8CA5eN2HO7OBzD+eCkmNs7ybAq/uJRfKwoq6OWtHWmUkKg==
Received: from [127.0.0.1] by nm32.bullet.mail.gq1.yahoo.com with NNFMP; 16 Mar 2015 05:32:33 -0000
Received: from [98.137.12.175] by nm32.bullet.mail.gq1.yahoo.com with NNFMP; 16 Mar 2015 05:29:32 -0000
Received: from [106.10.166.118] by tm14.bullet.mail.gq1.yahoo.com with NNFMP; 16 Mar 2015 05:29:32 -0000
Received: from [106.10.151.15] by tm7.bullet.mail.sg3.yahoo.com with NNFMP; 16 Mar 2015 05:29:31 -0000
Received: from [127.0.0.1] by omp1020.mail.sg3.yahoo.com with NNFMP; 16 Mar 2015 05:29:31 -0000
X-Yahoo-Newman-Property: ymail-4
X-Yahoo-Newman-Id: 856794.78172.bm@omp1020.mail.sg3.yahoo.com
X-YMail-OSG: HbfTFnUVM1mhyNNpEIoNNUpWB3WRHr00T6YsnTts5Ollm6BBFpoNtlGd5I37268
 AaNI59AeYUYc0T0PG5Zi7v1_PWbm.dPlMX3kygCQ5TbIAZ22JaP1KzQzGSZO3hxqH3IE85zVRMQl
 cZVw1AhfG6yy8Gk05GPfJ_xhMaQdf9Tab9tGKLikdXVUA539.sE_.LJfNLjJWK0YaqnrOhfhe0ww
 uBPWufxuS7ilo69Vyc1JHMmCz7XIIwdCA7v9.kuVWHfu1OlJo1i2CJrpm5qJq4yR9Rea_vVaF2Y8
 qhRr9AcXWZcJBRRzWmUVhTqE41GpdPECfZ_tOb7_hwdY8Nh_3BdSrCPWe4lqYTfFjifI9LXx9fah
 2RtVkyB8iORiw16g3gTVU8S._8BsYrSD.fJvZp0oN.0wqsk_B3motID8jYo8vVUp_MRYBtWNRnjI
 gH3cIY_g_zvjBW1rnYD7flOr2QEIbxbxWNCEHT.jON5ToxPhfCEloQysQnJYI.ke5pYKACPbC6PW
 ONA2uHDbz0XE94PLezdxG0IWl6DLgLodWZwoyj1Cp4zUyCGjfyc_k1WY8WfOnm8uGZkwTDxlJZNA
 eXSpJGRmOpwUKraFFqtHJYC0VFWQ91Cv3JDo-
Received: by 106.10.196.176; Mon, 16 Mar 2015 05:29:31 +0000 
In-Reply-To: <20150315174543.GA11832@vps892.directvps.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265544>



On Sunday, 15 March 2015 11:15 PM, Kevin D <me@ikke.info> wrote:
On Sun, Mar 15, 2015 at 05:58:19PM +0100, t.gummerer@gmail.com wrote:
> On 03/15, Arup Rakshit wrote:
> > On Sunday, March 15, 2015 01:30:04 PM you wrote:
> > > 
> > > With --assume-unchanged you're promising git that you will not change
> > > a file that is already in the repository.  Git doesn't check those
> > > files for changes anymore, which can improve performance.
> > > 
> > 
> > I didn't understand your point. Could you please elaborate more on it ?
> 
> --assume-unchanged only works on files that you added on the
> repository, not on untracked files.  Because you don't seem to want
> these files in the repository, update-index --assume-unchanged will
> not work for you.
> 

And to elaborate what on what t.gummerer meant earlier: git update-index
--assume-unchanged is often abused to ignore already tracked files,
thinking that they can change the file while git happily ignores it.

--assume-unchanged was neaver built for this purpose, it's built for
large code bases where parts of the code base never changes, and git
checking this part would only slow it down. So that's why it's called a
promise to git that the file never changes, because git doesn't check
the status of the file everytime you run git status.

But because the file is still tracked, any commit that changes the file
causes git to still update that file, but git will then protest, because
it found it the file actually changed in the mean time, and you broke
that promise.

But also already said, this only applies to tracked files, so not to files
that aren't being tracked in the first place.

Kevin


Thanks both of you. As per your suggestions I resolved it. I found a good link on this topic too 
https://help.github.com/articles/ignoring-files/.


Regards,
Arup Rakshit
