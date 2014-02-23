From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Cygwin + git log = no pager!
Date: Sun, 23 Feb 2014 14:33:01 -0600
Message-ID: <CAHd499AbsUwmA0HWu31jW2n8eUNnRtU7URKPfBU7EhU6-F48zg@mail.gmail.com>
References: <CAHd499BT1Q308+q0NB9Dpx=ncQZwRn0tg=q_PE8RutaVqH+xQQ@mail.gmail.com>
	<53085434.4060106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 23 21:33:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHfjb-0000EE-H6
	for gcvg-git-2@plane.gmane.org; Sun, 23 Feb 2014 21:33:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbaBWUdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Feb 2014 15:33:03 -0500
Received: from mail-ve0-f176.google.com ([209.85.128.176]:59506 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbaBWUdC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Feb 2014 15:33:02 -0500
Received: by mail-ve0-f176.google.com with SMTP id jx11so4942170veb.21
        for <git@vger.kernel.org>; Sun, 23 Feb 2014 12:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=voMh6os4fsFtYiqgFYAxCppZwml44CS0yiUhUIx+Gso=;
        b=HTs54OSwJtgF+Hln+K8/Ae/Cxy1zTOHbYhTqt5qTtyN1aJPIa7N7XdRCxUb0WMy2GM
         YZLPMIZ40fWn/F0zxDwF0Uk29RhW3L5GwdIUGfZEg1JbDhEhB1plVnRD6McH9PkBZsOW
         mfmoxbbUbqoPnT8jvGFAcRJD1awq54jj93L4CNhogZEVY6hALrLCEGu9eCrc4zL+lEGv
         1Id2HZZklfgjus6+h4lOG3KFsf0cg94tis/kjZERuJlO21SsJBuVE/NVNLRzYlymC95f
         OLyeYz6RLDUmQCX7AvIc94NOJLgHm2P2AXUGxqT7n7rKTS7Nm8XvtLAXFSd3oR6gum6K
         zV4w==
X-Received: by 10.220.159.4 with SMTP id h4mr10548031vcx.1.1393187581165; Sun,
 23 Feb 2014 12:33:01 -0800 (PST)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.221.49.68 with HTTP; Sun, 23 Feb 2014 12:33:01 -0800 (PST)
In-Reply-To: <53085434.4060106@gmail.com>
X-Google-Sender-Auth: Ser5sRlT6MKcowbRi4Qzk8sK9og
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242546>

On Sat, Feb 22, 2014 at 1:39 AM, Chris Packham <judge.packham@gmail.com> wrote:
> On 22/02/14 18:18, Robert Dailey wrote:
>> So it seems that the pager doesn't work by default when running `git
>> log` from Cygwin like it does in msysgit for Windows.
>>
>> I know I can pipe to `less` but that requires the additional typing
>> obviously. Does anyone know how I can get the pager to work in Cygwin
>> for git log, reflog, and other commands like it does in msysgit?
>>
>> Thanks in advance.
>
> Add GIT_PAGER=less to your environment. I don't know if you were using
> the cygwin packaged git or building from source but I'm surprised the
> pager is not set by default as you actually have to define the use of
> something other than less.

Thanks for the response. I did set this environment variable in my
.bashrc like so:

export GIT_PAGER=less

However after I do a 'git log' it is just spitting it out all at once
and not entering the pager.
