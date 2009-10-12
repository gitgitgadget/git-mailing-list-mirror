From: Steven Noonan <steven@uplinklabs.net>
Subject: Re: Git: "No you can't handle my root!" (?)
Date: Mon, 12 Oct 2009 11:06:44 -0700
Message-ID: <f488382f0910121106h64571b93jb92372a1d7720b10@mail.gmail.com>
References: <20091012012826.7sffggwmm8sk0cc8@webmail.demarque.qc.ca>
	 <20091012135910.ujqifycf9cwsk4ss@webmail.demarque.qc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: sylvain@demarque.qc.ca
X-From: git-owner@vger.kernel.org Mon Oct 12 20:16:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxPQz-0007Z0-8I
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 20:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933005AbZJLSHX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Oct 2009 14:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757463AbZJLSHW
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 14:07:22 -0400
Received: from mail-pz0-f188.google.com ([209.85.222.188]:65441 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757452AbZJLSHV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Oct 2009 14:07:21 -0400
Received: by pzk26 with SMTP id 26so8254277pzk.4
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 11:06:45 -0700 (PDT)
Received: by 10.142.151.16 with SMTP id y16mr473470wfd.46.1255370804937; Mon, 
	12 Oct 2009 11:06:44 -0700 (PDT)
In-Reply-To: <20091012135910.ujqifycf9cwsk4ss@webmail.demarque.qc.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130041>

I've had this problem too, but I eventually realized it was git's way
of telling me I shouldn't do that. But even so, it'd be good if we
_could_.

- Steven

On Mon, Oct 12, 2009 at 10:59 AM,  <sylvain@demarque.qc.ca> wrote:
> Hello there. I know I was being goofy, but here is the real down to
> earth question :
>
> Is there a known bug/feature that prevents Git from being used at "/"=
?
> It seems that there is a problem either at "git init" or "git add"
> when the repository is located at "/.git". (Git 1.6.4.4, see example
> below)
>
> Thank you!
>
> Quoting sylvain@demarque.qc.ca:
>
>> Git is good, Git is great! All praise the Git! :-D
>>
>> What do you people think about this strange phenomena?
>>
>> localhost / # git --version
>> git version 1.6.4.4
>>
>> localhost / # git init
>> Initialized empty Git repository in //.git/
>>
>> localhost / # cd etc
>> localhost etc # git add X11/xorg.conf
>> fatal: pathspec 'etc/X11/xorg.conf' did not match any files
>>
>> Aside from the obvious question of why would I want to Git the whole
>> tree ("But all files deserve the Holy Presence of the Git!"), why do=
es
>> Git refuse the love offering from "/etc/X11/xorg.conf"? Is it becaus=
e
>> it contains font directory configurations?
>>
>> Commit and [ENTER] to all,
>>
>> S! :-)
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
