From: "Peter Harris" <git@peter.is-a-geek.org>
Subject: Re: Working with remotes; cloning remote references
Date: Thu, 16 Oct 2008 15:20:41 -0400
Message-ID: <eaa105840810161220k26eebd48q8de606597f2be055@mail.gmail.com>
References: <48F7852F.109@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Marc Branchaud" <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Thu Oct 16 21:21:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqYQ0-0000Gt-Sk
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 21:21:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756537AbYJPTUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 15:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756205AbYJPTUn
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 15:20:43 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:23950 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755993AbYJPTUm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 15:20:42 -0400
Received: by rv-out-0506.google.com with SMTP id k40so140083rvb.1
        for <git@vger.kernel.org>; Thu, 16 Oct 2008 12:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=PY3GvM0Nd3JgMzIhCg4ZeJfo3NH6E1YukV9hukcPP74=;
        b=e7Nha6QQq/RxeMvizvKcsl56+nDXozI8LyafogZlt9HD1wnoHBQKl8ETAZKVsiXYyM
         H8Bf/8Y+5Wyxp+NpL1FkbQXWMp1i+lkROOa/A4bjLUlBNt0YYZ5QJcGdHtPkD1/Or1eK
         GklBni8EUE3F4/seJZypamKjB9VrvkibngQLk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=NKZ0FqHvoZmNt3LY9DvwDAdLp/jh18u973eDPIzEv45ljCfv+noZ0PQ+DfvaQe3UDa
         e9JXXqIxs3ufL9J4bVGvexhPi7JOo3sPz5U7/g8eZ9XJjZ3HQkJmzefGMZr3fY6LFBpf
         H3UZ/9KTC89tRWJONl6bCVAS6H5D/gBT2rs4E=
Received: by 10.141.156.11 with SMTP id i11mr1931325rvo.1.1224184841781;
        Thu, 16 Oct 2008 12:20:41 -0700 (PDT)
Received: by 10.141.97.15 with HTTP; Thu, 16 Oct 2008 12:20:41 -0700 (PDT)
In-Reply-To: <48F7852F.109@xiplink.com>
Content-Disposition: inline
X-Google-Sender-Auth: 867bad5720db90e8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98405>

On Thu, Oct 16, 2008 at 2:17 PM, Marc Branchaud wrote:
> From this point of view (and please correct me if I'm wrong), it would be
> good if "git clone" had an option to include a repo's remote references in
> the clone.  The clone's origin reference would point to the original repo as
> usual, but all the other remotes would be in the clone.

"git clone" doesn't have this option, but you can turn it on
immediately after with something similar to:
git config --add remote.origin.fetch +refs/remotes/*:refs/remotes/*
(which I use for fanning-out my git-svn repos)

See "git help fetch" for further documentation.

Peter Harris
