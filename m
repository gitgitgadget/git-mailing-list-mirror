From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: Git feature request: mark a commit as minor
Date: Sat, 3 Oct 2015 23:01:10 -0700
Message-ID: <CA+P7+xqS0iLmo2+nLz7PyCTP7CmxjX-VONvB+-HQX9sHEiSwAw@mail.gmail.com>
References: <560EF966.3000501@walltime.info> <CA+P7+xq8Ds3hYjv2x8S4v8+6F3G+ciGreiZxHxDfzzft520ChQ@mail.gmail.com>
 <CAHYJk3Qb89YhVJoOpBLYMoNJX5GvVHnJhf41Gdbtypcp+Yq96g@mail.gmail.com> <560F794F.2010809@walltime.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mikael Magnusson <mikachu@gmail.com>,
	Git List <git@vger.kernel.org>
To: Felipe Micaroni Lalli <micaroni@walltime.info>
X-From: git-owner@vger.kernel.org Sun Oct 04 08:02:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZicN0-0000HU-34
	for gcvg-git-2@plane.gmane.org; Sun, 04 Oct 2015 08:02:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbbJDGBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2015 02:01:31 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37827 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbbJDGBa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2015 02:01:30 -0400
Received: by igbni9 with SMTP id ni9so39535737igb.0
        for <git@vger.kernel.org>; Sat, 03 Oct 2015 23:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Ujzp3C7AjgkHnKRsRM0lC4+y3INApxr8q/wanngD27I=;
        b=s0gnuyva/NbVH9sYyCxdx8h0t27EDE4STqQZzefGCh58eKNI/7VdFFL9A+tq1YV8mf
         NZgYDnC4up+fQbujFc6M6bKMlZ0heMz/824PjIo6Vumo3ak+I+j9/iESHp3I8eUDBmMZ
         StoL2p6PCp/b8MlxhVQl6ueGBL57Ml3xjTVFFhysJxjpWN0K2cQa/ywVM7stZnXtJahY
         S8FVaIyq28N9QFN+x9plrYkuv+nm8FrSXcV3oc44gXh5sxxaRP+LQhIYUd7ch07nUOh4
         wETmz1DSaeKWCZyB2QHsKL2crb6cCqzf73r9cT237ZxRoOSdENXDzMh36S52qXEonwPX
         ivxg==
X-Received: by 10.50.64.211 with SMTP id q19mr4088463igs.73.1443938489444;
 Sat, 03 Oct 2015 23:01:29 -0700 (PDT)
Received: by 10.107.132.155 with HTTP; Sat, 3 Oct 2015 23:01:10 -0700 (PDT)
In-Reply-To: <560F794F.2010809@walltime.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278992>

On Fri, Oct 2, 2015 at 11:44 PM, Felipe Micaroni Lalli
<micaroni@walltime.info> wrote:
> Actually we already use the keyword MINOR for that, exactly as you said.
>
> The suggestion was made because I think it is a common behavior and it
> would be nice to be a meta info to standardize this (today each team
> adopt a different pattern for that - you used "TRIVIAL" e.g.). Nice
> things could be done with this meta-info. It could be totally ignored
> (current git operation) or it could be used to filter, to sort, to group
> commits, to show the log pretty etc.
>
>> The issue is that not everyone considers these changes as "minor".
>
> I understand this issue, I know it is subjective. But if someone don't
> want to make the distinction just don't use the argument --hide-minor
> for example.
>
>

I think use of git-notes is probably the best way. Not sure how/if you
can implement filtering on that, but I don't personally think
something like this belongs in core git.

Regards,
Jake
