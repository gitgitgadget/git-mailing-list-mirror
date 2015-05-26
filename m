From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] submodule documentation: Reorder introductory paragraphs
Date: Tue, 26 May 2015 10:53:15 -0700
Message-ID: <CAGZ79kZHRRqKpSmnEfd7-UOL9QrPOhQYt7wsfaqGVTZkHc+mhQ@mail.gmail.com>
References: <1432323527-26868-1-git-send-email-sbeller@google.com>
	<xmqqfv6k9v1x.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philip Oakley <philipoakley@iee.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 26 19:53:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxJ2Y-0005oI-Nf
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 19:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411AbbEZRxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 13:53:17 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:36786 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbbEZRxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 13:53:16 -0400
Received: by qgf2 with SMTP id 2so33907136qgf.3
        for <git@vger.kernel.org>; Tue, 26 May 2015 10:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+Hxuilxm/wRijBWRbfkAz6s8DlAJJzr7oC4tUj3qA2U=;
        b=mYsM9zgfOrm/U2uHzWF5n8jkwpxsUm/YQAhqV49Zda7WIhv5fL4jYKsNqCCYcDBJP2
         hHN/sLBLJ55Q8FD+LzsNcZfjGhH8jCoGNSI5btPTBIXxqrM6FcIv9VZ/YRTgRm+PwlK6
         qqytBR1bxVt4+xJeB6mooBHI8AjZVKlIkZNQPhAGtTSTGKkuMz3gKW2lOPGXwsQtYk2z
         C8ipUKPn1NpO8wfHQ7PJX72OBchSvAoMoYE/9XRgMo6Z0+fNKntmxhuelnKXcmnFO00h
         Sby0HiLT55YqL3GwCyG8wNKsllwwifbmnVDiNMiGoG+KB+gc1qrwlZRw8MB/7tZW/W8p
         WMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=+Hxuilxm/wRijBWRbfkAz6s8DlAJJzr7oC4tUj3qA2U=;
        b=U7RNqxOLG7PsSlEHLLci7DkAfgHwidc0yjptb2UBw0Rp0ULDEi7nvYZpAeC3TVcxF8
         bgAuk94d46CRaZ55lHbGEOvzUYHqx56HAOYRhsmhlJUzD+6ZGmCjAIH9cfFaGbUbGGjG
         oNLS/zgO4FxpRSRnPVm5M3wYbxZC+YsibVZ0+W0BGfBAt0SxE9fTKR8j5Y7PjvCnMIYK
         uJNZPz5M3y2TDmdeIw0cQwidESLlDLCx6WjuTwSHY2CQN4VMlMA9MEeWSjAX2Vo3Mv61
         QnEzNB2kBln5cnewLlJhCzGhUPSHsPC2hpONphPoz30aWqY5RUXa85qtXJd8jLRF1PCS
         D87A==
X-Gm-Message-State: ALoCoQl6jg/q7xCxUDo4w3Q0sO2NLOtrBJs9ZvloJ6iliGNv5ceVs/4YXuWKANgbqxP3LTFObwqj
X-Received: by 10.55.19.197 with SMTP id 66mr58790635qkt.24.1432662795453;
 Tue, 26 May 2015 10:53:15 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Tue, 26 May 2015 10:53:15 -0700 (PDT)
In-Reply-To: <xmqqfv6k9v1x.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269960>

On Mon, May 25, 2015 at 3:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>  DESCRIPTION
>>  -----------
>> +This command will inspect, update and manage submodules.
>>
>> +Submodules allow you to keep another Git repository in a subdirectory
>> +of your repository. The other repository has its own history,...
>
> The first line somehow bothered me, so I took a random sample of
> commands I often use:
>
>     git log
>        Shows the commit logs.
>
>     git show
>        Shows one or more objects (blobs, trees, tags and commits).
>
>     git commit
>        Stores the current contents of the index in a new commit along with a
>        log message from the user describing the changes.
>
>     git diff
>        Show changes between the working tree and the index or a tree, changes
>        between the index and a tree, changes between two trees, changes
>        between two blob objects, or changes between two files on disk.
>
>     git push
>        Updates remote refs using local refs, while sending objects necessary
>        to complete the given refs.
>
> I _think_ what bothered me was "This command" (drawing the reaction
> "eh, what other command are you going to talk about in the help page
> for this command?").  Perhaps
>
>     Inspects, updates and manages submodules.
>
> may match the style of other help pages better.

Sounds much better than my patch.

>
> On the other hand, I probably would not have felt such a strong
> "strangeness" if it were described like this:
>
>     This command can help you inspect, update, and manage
>     submodules.
>
> I haven't analized it enough to say why it is, but I suspect it has
> something to do with (my own) perception that "git submodule" is not
> very essential to do any of these things (i.e. .gitmodules is a very
> simple text file), but is primarily a helpful wrapper.

My perception is that the submodule man page similar to the subtree
man page tries to explain an underlying concept as well. The other man
pages you quoted don't do that as the concepts are explained elsewhere(?)

As a side note: In the Gerrit test suite I use the JGit implementation of
the config command to write out .gitmodules files. So maybe `git submodule`
can be understood as a specialized form of `git config`.

>
> The description of "git config", on which I have a similar
> perception, seem to match ;-)
>
>     git config
>        You can query/set/replace/unset options with this command.
>
