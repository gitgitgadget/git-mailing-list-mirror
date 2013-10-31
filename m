From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] commit: Add -f, --fixes <commit> option to add Fixes:
 line
Date: Fri, 01 Nov 2013 00:03:21 +0100
Message-ID: <5272E1B9.6000705@googlemail.com>
References: <20131024122255.GI9378@mwanda> <20131024122512.GB9534@mwanda>	<20131026181709.GB10488@kroah.com> <20131027013402.GA7146@leaf>	<526CA7D4.1070904@alum.mit.edu> <20131027071407.GA11683@leaf>	<874n83m8xv.fsf@linux-k42r.v.cablecom.net>	<526CDC5C.40208@googlemail.com> <87zjpuznf1.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Fri Nov 01 00:03:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vc1Gl-0000Rx-BI
	for gcvg-git-2@plane.gmane.org; Fri, 01 Nov 2013 00:03:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753311Ab3JaXDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 19:03:11 -0400
Received: from mail-ee0-f47.google.com ([74.125.83.47]:51506 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574Ab3JaXDK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 19:03:10 -0400
Received: by mail-ee0-f47.google.com with SMTP id c13so1680410eek.34
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 16:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ImKOO5VUtJYmJKt1TSaShH9UQHVf+F+LiGsTv4mxPk4=;
        b=MDHjYArOUGLKp0ZeMUd+kv4CugQBKAiFSXY5zB1eKjBOgluDg6uzKdkQcO1ggc57Jk
         6adggmiyZHaDh7h7ZpwkXkCanlo0bZfjhspAOm4Fs7jtUL9wx9dCOTC3gS+3PX39j/v2
         aCgVMp6eUpp31A+Aa+Rw/ytlhZMAxwlCZURbPx5LM24fBLaEEJbTgkFfZaLG68RPIrBG
         ltD8a7prh+m0jDOGeRxNDs2UUmO/avE64TUjVWecdOGToHfkJBua09M/1WmG0OnLhvNv
         KfjLqfBp2IPvlPtdCt9D42s0rk0Zb5ZEemJ3w/P3T8dP2v07j5xibmHneytoY3pZFty0
         yaaw==
X-Received: by 10.14.149.13 with SMTP id w13mr92888eej.134.1383260588605;
        Thu, 31 Oct 2013 16:03:08 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id s3sm168636eeo.3.2013.10.31.16.03.07
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 31 Oct 2013 16:03:07 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <87zjpuznf1.fsf@thomasrast.ch>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237191>

On 10/27/2013 05:30 PM, Thomas Rast wrote:
> Stefan Beller <stefanbeller@googlemail.com> writes:
> 
>> I assembled an overview table, which plots the long options of 
>> git commands by the short letters.
> [...]
>> (In case thunderbird messes it up, here it is again http://pastebin.com/raw.php?i=JBci2Krx)
>>
>> As you can see, f is always --force except for git-config, where it is --file
> 
> Woah!  Impressive work.  Did you autogenerate this?  If so, can we have
> it as a small make target somewhere?  If not, can you send a patch to
> put your table in Documentation somewhere?
> 

[ Removing the linux related mailing lists and participants ]

Would you mind to define 
> in Documentation somewhere
a little more precise?
I cannot really find a suitable place for such a table as in the main
Documentation direcotry there are basically the man page informations 
and some git development related things, such as SubmittingPatches.
The sub directories are even less fitting, so maybe 
	Documentation/ShortOptions 
would be fine?

Anyway, as I couldn't really come up with a reliable way for the shell
commands, I just went manually through all the missing commands 
(be it written in shell or missing compiled commands), 
and added it to the script. The script itself was reworked a little,
to better be able to add manual information.

Any suggestions how to improve the script or the table itself is 
welcome.

Thanks,
Stefan
