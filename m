From: Tor Arntsen <tor@spacetec.no>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Sat, 24 Apr 2010 15:26:18 +0200
Message-ID: <q2ld2d39d861004240626hf7cfb5a4p1b6d7a594ef3d0fb@mail.gmail.com>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
	 <20100422155806.GC4801@progeny.tock> <4BD1EE10.4010009@gmx.de>
	 <k2ub4087cc51004231234z29228ac8ia0f62a4e16cedae4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthias Andree <matthias.andree@gmx.de>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 24 15:26:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5fNP-0001BZ-U2
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 15:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753525Ab0DXN0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Apr 2010 09:26:22 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:60204 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487Ab0DXN0V (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 09:26:21 -0400
Received: by fg-out-1718.google.com with SMTP id 19so815292fgg.1
        for <git@vger.kernel.org>; Sat, 24 Apr 2010 06:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        bh=9wN0ZwiejZrwfGlQZ1sskx+7p7xiDQ3IzL8FYwVVG0c=;
        b=JvRu2xgE8eNjw1yFThae3thfjYskSFjzpRWXcvltKTFphDI+5HykikcfkqZc3s3Xsk
         2fqm9T2MFgHjDdAVU6vhAAZrLF3XP+YKTDjW28T5HMwgPU0TfhzeAG2fhsvFVJ64Mx9G
         mW/ruGtwX1Dq4udCwxeplvz18gQ00CN6AqSeM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=Z/lEl6a2Yw8F6pQE9W1xGPLlqjEjCyBweLjlAZOg1YyTjzBIDnP9anYjctf05lVwsQ
         B+QQHIZXoe1YuPFmJf/XHxj10sj1wgPLN6PyAJJg+DMhfhwmy3UePtMRAGH69ZtmLfds
         6zNZ+q81kb35iCAPfEo/LEeMX812bX9sXOpP4=
Received: by 10.239.160.11 with SMTP id a11mr115305hbd.119.1272115579382; Sat, 
	24 Apr 2010 06:26:19 -0700 (PDT)
Received: by 10.239.179.197 with HTTP; Sat, 24 Apr 2010 06:26:18 -0700 (PDT)
In-Reply-To: <k2ub4087cc51004231234z29228ac8ia0f62a4e16cedae4@mail.gmail.com>
X-Google-Sender-Auth: d728b216d3df7ef9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145673>

On Fri, Apr 23, 2010 at 21:34, Michael Witten <mfwitten@gmail.com> wrote:

> The proposal was not "default to commit -a" but rather "default to
> commit -a when the index has not been explicitly updated with
> something like git add".

For what it's worth, from another relative newcomer: The above would
actually cause trouble sometimes for me. Having learned to use git
add+git commit, and working on several things at once:

edit file1
edit file2
edit file3
git add file3
git commit -m"fixed file3"

In the above sequence (relative newcomer, but not entirely) I
occasionally forget to do the 'git add file3' part (I just mistakenly
thought I did). The way it works now means nothing happens, which is
good. The way I understand the proposal I would instead end up with a
commit of all my changed files, which is exactly not what I want.
I can't stop thinking that it should be easy for anyone who wants the
proposed behaviour to make an alias, or certainly a wrapper. Problem
solved, without changing the way it works now.

-Tor
