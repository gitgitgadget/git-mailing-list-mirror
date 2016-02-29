From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Trouble Cloning Git remote repository
Date: Mon, 29 Feb 2016 08:20:46 +0700
Message-ID: <CACsJy8CSrmahLztOmmU+R4KTifhRs5nsSPKOdYHHw57UqDv8oQ@mail.gmail.com>
References: <009f01d170e9$ecd5cae0$c68160a0$@optonline.net>
 <CACsJy8A5539X+VhUAnNfn5Q_uW1pa5oYb9YAAF8=u3XfdhAeMw@mail.gmail.com> <00e001d17250$47c63fe0$d752bfa0$@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: "Fred's Personal" <freddiewik@optonline.net>
X-From: git-owner@vger.kernel.org Mon Feb 29 02:21:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaCWY-000671-AL
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 02:21:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752295AbcB2BVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 20:21:18 -0500
Received: from mail-lb0-f169.google.com ([209.85.217.169]:35644 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027AbcB2BVR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 20:21:17 -0500
Received: by mail-lb0-f169.google.com with SMTP id bc4so71776244lbc.2
        for <git@vger.kernel.org>; Sun, 28 Feb 2016 17:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=T9wLrf9UlpOANVeWesVAy+Da9SiVlhAo64nf6WLbnQs=;
        b=bZLVCnkXCuol7gjjY+ilrhZO+OAPR7lh1Me22UHZQOK2Ex/o8oQkpjGKF1/HdD1xCl
         J3M4KUf9jFvbedYKrLMw24uwnUshw1H3jonuQ2rPhTusHfsTkLa5QiTfAeTuvfrvDFLe
         Y0oO98WTL+ZyNhFMwYho5V8AiDkCsCiDVrtWdUxUIORE3ESnhXtCaU8UJfRUEr7/ppnI
         knshkdLdkdA6UJqYV6a6OIPxr5QKmM/xuROjpo/AG/3dfGrbU32ALfgtOl4aIVJlrpB0
         iJa6Z6MjVLFVqHGjoVd7rHvCkguREUS7nwoXu/MuIGfG4jPOlEcThoGyTeZq+2f5C7VS
         Xp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=T9wLrf9UlpOANVeWesVAy+Da9SiVlhAo64nf6WLbnQs=;
        b=BYo/aTjlENskFStYy9fI1nY+qlpgA3lat3Vfnu2uMjRibBltv8kEp5bw/GVmI+tMit
         JjNJeWYTSTzFL3UCx9empieg+VHnpnJxlb/TB+zD+6ayPXPfI89uBIhPXTkynloO4iMs
         OZ+WxwpYMzVvvMgHyyqKoAGd9FZonseo8T7GNdPn/pCPncZdkBDFMlt/2YpTsGVFUfTX
         hMYG1dhaqa8QzJcHBY1c1QeDX5cyPHEg4MIHSidmVpL39DGeB3rhh7VrZ8x2SNOKtaYA
         MHCx0hNlyMqJ9yXxChSl3zV5UKLlvzoQUbjB2EvvrddQxn7uy5iMlvA0drX6WklygzUt
         E6aQ==
X-Gm-Message-State: AD7BkJIiCWGxD5Mac15n8rqMibR1s5Qqnn0oKA2PiCYP1WHXoQd3UJEq+HDpKukCK5CGhwMIttcrgMfA7dZw3A==
X-Received: by 10.112.150.133 with SMTP id ui5mr4410810lbb.12.1456708875927;
 Sun, 28 Feb 2016 17:21:15 -0800 (PST)
Received: by 10.112.51.99 with HTTP; Sun, 28 Feb 2016 17:20:46 -0800 (PST)
In-Reply-To: <00e001d17250$47c63fe0$d752bfa0$@optonline.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287796>

On Mon, Feb 29, 2016 at 12:48 AM, Fred's Personal
<freddiewik@optonline.net> wrote:
> Duy,
>
> Thanks for advice, here is the result of executing the lines you suggested:
>
> user1@Host1 MINGW64 ~/gitrepository (master)
> $ export GIT_TRACE=1
>
> user1@Host1 MINGW64 ~/gitrepository (master)
> $ git clone -v ssh://user1@Host2/srv/centralrepo
> 12:33:47.928365 git.c:348               trace: built-in: git 'clone' '-v' 'ssh://user1@Host2/srv/centralrepo'
> Cloning into 'centralrepo'...
> 12:33:48.022110 run-command.c:343       trace: run_command: 'C:\Program Files (x86)\PuTTY\plink.exe' 'user1@Host2' 'git-upload-pack '\''/srv/centralrepo'\'''

This command looks good to me. So I have no clue what goes wrong :-)
Maybe you can execute this command directly, with more plink debugging
options or something. You don't have to run git-upload-pack. Just
spawn a shell. Another option is try something other than plink (does
git-for-windows come with ssh.exe?)

>
> ##>>>Lines from $HOME/.bashrc (See below, removed here for clarity)
>
> + user1@Host2 git-upload-pack /srv/centralrepo
> bash: user1@Host2: command not found
> fatal: Could not read from remote repository.
>
> Please make sure you have the correct access rights
> and the repository exists.
>
>
> Regards,
> Fred
>
> freddiewik@optonline.net
>
>
> -----Original Message-----
> From: Duy Nguyen [mailto:pclouds@gmail.com]
> Sent: Saturday, February 27, 2016 4:36 AM
> To: Fred's Personal
> Cc: Git Mailing List
> Subject: Re: Trouble Cloning Git remote repository
>
> On Sat, Feb 27, 2016 at 6:03 AM, Fred's Personal <freddiewik@optonline.net> wrote:
>> $ git clone -v ssh://user1@Host2/srv/centralrepo Cloning into
>> 'centralrepo'...
>>>>>Lines from $HOME/.bashrc
>>   + export
>> PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr
>> /games
>> :/usr/local/games
>>   +
>> PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr
>> /games
>> :/usr/local/games
>>   + PROMPT_COMMAND=
>>   + CDPATH=
>>   + '[' '' = yes ']'
>>   + PS1='${debian_chroot:+($debian_chroot)}\u:\W\$ '
>>   + export GIT_TRACE_PACKET=1
>>   + GIT_TRACE_PACKET=1
>>   + export GIT_TRACE=1
>>   + GIT_TRACE=1
>>>>>End of Lines from $HOME/.bashrc
>> ## WHERE DOES The following line COME FROM????What Script spits out
>> this line????
>>   + user1@Host2 git-upload-pack /srv/centralrepo
>
> Try set GIT_TRACE=1 at the clone line, I have a feeling that this line should be "ssh user@Host2..." but "ssh" is missing.
>
> $ export GIT_TRACE=1
> $ git clone -v ssh://user1@Host2/srv/centralrepo
> --
> Duy
>
>
> -----
> No virus found in this message.
> Checked by AVG - www.avg.com
> Version: 2016.0.7442 / Virus Database: 4537/11702 - Release Date: 02/26/16
>
>



-- 
Duy
