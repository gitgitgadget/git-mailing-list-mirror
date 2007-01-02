From: "Deepak Barua" <dbbarua@gmail.com>
Subject: Re: git not tracking changes
Date: Tue, 2 Jan 2007 15:24:13 +0530
Message-ID: <b5a19cd20701020154w63fd4c4s46a6cb3c6f50ce5a@mail.gmail.com>
References: <b5a19cd20701012152n4f496198h93cab1b9b85a9a45@mail.gmail.com>
	 <20070102055937.GD27690@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 02 10:54:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1gLb-0007g5-RY
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 10:54:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932691AbXABJyP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 04:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932732AbXABJyP
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 04:54:15 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:9501 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932691AbXABJyO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 04:54:14 -0500
Received: by nf-out-0910.google.com with SMTP id o25so7275301nfa
        for <git@vger.kernel.org>; Tue, 02 Jan 2007 01:54:13 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Xqe26E2VVXCthPCp2kcsHFkOQTTVxhWm+W5gihD5HUZAjzFXEWhw73l+tToSp9PokD1Z8my5wDsOLW8cE9JEjZfib5pZ6d9jycntrJRw2UpQemRlOfz161vnRAgTwA+7OUgY65Ol6b1fN2EK1F7qc9oILdiYtXx8Bw+9C1OqP/E=
Received: by 10.49.93.13 with SMTP id v13mr4202778nfl.1167731653353;
        Tue, 02 Jan 2007 01:54:13 -0800 (PST)
Received: by 10.49.11.7 with HTTP; Tue, 2 Jan 2007 01:54:13 -0800 (PST)
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070102055937.GD27690@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35784>

Thank you shawn.

Regards
Deepak

On 1/2/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Deepak Barua <dbbarua@gmail.com> wrote:
> > Hi,
> >    When i do a git add of a config.h file then make some changes and
> > then do git commit it does not reflect the changes..
> > eg
> > dep@zion:~/programs/elinks/elinks-0.11-20061220$ git add config.h
>
> Here you told Git to take the current contents of config.h and
> stage it into the index.  That content will be in the next
> commit.
>
> > dep@zion:~/programs/elinks/elinks-0.11-20061220$ vi config.h
>
> Then you modify it.  Git doesn't know about those changes to
> config.h, nor does it care at this point.
>
> > dep@zion:~/programs/elinks/elinks-0.11-20061220$ git commit
> > nothing to commit
>
> This is occuring because the content staged in the index does not
> differ from the content in HEAD (the last commit on this branch).
> You need to run `git add config.h` again now that you have modified
> it to restage the modified file.
>
> Basically I'm assuming that when you ran `git add config.h` the
> first time the content must have matched HEAD, which meant you
> didn't actually stage anything.
>
> --
> Shawn.
>


-- 
Code Code Code Away
