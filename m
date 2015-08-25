From: Rafik E Younan <rafik.arkdev@gmail.com>
Subject: Re: index file list files not found in working tree
Date: Tue, 25 Aug 2015 16:50:08 +0200
Message-ID: <55DC80A0.3060309@gmail.com>
References: <55DAF343.2050908@gmail.com> <55DC408B.5030804@gmail.com>
 <20150825103214.GH1412@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Aug 25 16:50:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUFYe-0008WK-N7
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 16:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755223AbbHYOuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 10:50:15 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38546 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754657AbbHYOuN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 10:50:13 -0400
Received: by wicja10 with SMTP id ja10so17413248wic.1
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 07:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=OTd12QvOneC7ToeRh/CsBW3ygPoHZ4TDY5K6kbN1kxA=;
        b=lTGhC/fPFsZa2uLp/MJ+hF8y2VHbQm4VsEQvQ2+0yFJUSuPCo/x0CJXg+PuXLiVhoA
         It193QqxW9QdlC9emUjnffviV7VH5+Vfqd4pPCZFXx+XcVMI1pjAmp6JhjyA/UpfOpc3
         xj4jLOms6SOO2X4oEYXxopdyNOCdAZ6WdpVvpPdA9fh2yxXcYV3MSTtDwjtYyqY1Gd6b
         S4K6LRG+4Qx/d0rmMkvsVepVq0qPj+UhtzzPWLxm9BQtWea0munv71u2nTVcJeSir7f+
         ydsXfJm3LJ0BfNYUIogjAVbqrMmg3x0NtIis8v98a1J1NHwySV/GBc0hp3OFFV6EXI0j
         +L3Q==
X-Received: by 10.194.71.65 with SMTP id s1mr51797108wju.96.1440514211616;
        Tue, 25 Aug 2015 07:50:11 -0700 (PDT)
Received: from [192.168.1.115] ([196.205.146.227])
        by smtp.googlemail.com with ESMTPSA id ul1sm28450531wjc.30.2015.08.25.07.50.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 25 Aug 2015 07:50:11 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <20150825103214.GH1412@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276530>

On 08/25/2015 12:32 PM, John Keeping wrote:
> On Tue, Aug 25, 2015 at 12:16:43PM +0200, Rafik E Younan wrote:
>> I got a recommendation to use reset --hard. I tried it and it says the
>> HEAD is now at correct commit, but missing files are not restored!
>>
>> I tried `ls-tree --name-only` and it lists missing files and folders,
>> but the actual working tree doesn't have these files and folders.
> Is there any chance that you have enabled sparse checkouts?  See the
> documentation at the bottom of git-read-tree(1).
>
>
There was `.git/info/sparse-checkout` file in the local repo, but not in 
other cloned repo. I remove the file, the `.git/index` and did reset 
--hard, and all seems works now.

Thanks for your help.

Git community rocks!

Regards,
Rafik
