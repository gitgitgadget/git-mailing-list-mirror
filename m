From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Incremental cvsimports
Date: Wed, 24 May 2006 17:16:57 +0930
Message-ID: <93c3eada0605240046t10e00119n4cfc39ec33fe1d92@mail.gmail.com>
Reply-To: geoff@austrics.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed May 24 09:47:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fio57-0004LA-BU
	for gcvg-git@gmane.org; Wed, 24 May 2006 09:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932642AbWEXHq6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 03:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932646AbWEXHq6
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 03:46:58 -0400
Received: from wx-out-0102.google.com ([66.249.82.205]:21548 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932642AbWEXHq6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 May 2006 03:46:58 -0400
Received: by wx-out-0102.google.com with SMTP id s6so1162117wxc
        for <git@vger.kernel.org>; Wed, 24 May 2006 00:46:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LRN4ommkoCmlXoFPglwj6rv96zKG51XtOeGjxrJSOrpJ5+RhDgbgfidchi5IbildLP/NM7/SdafFf6COwMo0z0udncCW9unsP+9C8Ajr12y7D6xpHZbPgakhfhYTbF6t+M2nsJNSDxBSZL4LjKXVLqeXF3Jc0tge6LC46lVEaUk=
Received: by 10.70.46.9 with SMTP id t9mr4907884wxt;
        Wed, 24 May 2006 00:46:57 -0700 (PDT)
Received: by 10.70.32.19 with HTTP; Wed, 24 May 2006 00:46:57 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20669>

Dear Git,

I have a 3Gb repository (10 years of history) which I want to import into git.

I have tested little pieces of that and a 23Mb directory expands to 120Mb prior
to packing/pruning.  Therefore I don't have a big enough disk to import the
whole repository at once. So I figure I could do it in pieces with a pack after
each piece.

So I tried something like:

 1.      $ git cvsimport  -o austrics -v -d /cvsroot -C /GitRepo /cvsroot/A

followed by

 2.     $ git cvsimport  -o austrics -v -d /cvsroot -C /GitRepo /cvsroot/B

After 1, /GitRepo/.git is set up but /GitRepo has the members of A,
not A itself.
After 2, /GitRepo also has members of B. This isn't quite what I wanted!

Is there a way to do this?

Cheers,
Geoff Russell
