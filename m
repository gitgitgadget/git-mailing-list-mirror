From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Re: Finding a commit
Date: Wed, 21 Oct 2009 14:30:29 +0200
Message-ID: <9accb4400910210530k75a763cbtbc9294d937de9242@mail.gmail.com>
References: <4ADEF095.3020406@box.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Soham Mehta <soham@box.net>
X-From: git-owner@vger.kernel.org Wed Oct 21 14:30:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0aKr-00015N-Cy
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 14:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbZJUMa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 08:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751620AbZJUMa1
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 08:30:27 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:59702 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbZJUMa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 08:30:26 -0400
Received: by fxm18 with SMTP id 18so7687011fxm.37
        for <git@vger.kernel.org>; Wed, 21 Oct 2009 05:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=NaXcjvs81Pz3mNptHtzZf5m7nr6JdRZ/qmxDn1Od0rA=;
        b=khQON9BQMWFsBIaBRqm/0lSwnvDuLA8K3K15zC5ly20MDqpVRmZkmF2dvJve7oJ7bQ
         agSar+3IUKklxFxQ2uNePeWMzR6QriCP01kA9bdRr3MFk7qFUAlaUBDVav+5cMxgxri2
         INKcH75csUgQaSrGjMsAeNS4CnP+w20fWizpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=JQ/3aYej6iWP+lqI0/xtr7sAX4dA1EOi+bR4f4Wp3GMUWnt+niBgKHddiEcL6FgUDG
         39rUUgPNl1ddQO3jU+0qI/5KTJlTo1617R2Ci5WkSAcOw4T4K9vZ8VvVcnSUFQ7/gpQ5
         z6Z4WRM5vjlhxEmiiVGKcq7iMxZo5j/b56lLM=
Received: by 10.204.151.210 with SMTP id d18mr7804398bkw.203.1256128229848; 
	Wed, 21 Oct 2009 05:30:29 -0700 (PDT)
In-Reply-To: <4ADEF095.3020406@box.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130909>

On Wed, Oct 21, 2009 at 1:29 PM, Soham Mehta <soham@box.net> wrote:
> Because SHA1 can change if a commit is cherry-picked around, I cannot just
> grep for that SHA1 from git-rev-list or git-log on 'y'. I need a way to know
> if a commit with identical changes (as in 'x') is also present in 'y'.

I'm really not an expert of git..

but A commit is something like:

Commit -> Tree ---> Blob1, Blob2, Blob3

Commit, Trees and Blobs are all identified by sha1
the commit should keep information on the author, the "parent"
commit(s) and so on..
the tree should just keep the "snapshot" of the data..

so I think that if you search for the SHA-1 of the tree you should be fine..

But I don't know how you can get the SHA-1 of the tree from a commit
(may be git cat-file <commit-sha> could help you)
and I don't know how to search for that tree around your index...

But I'm sure google (or whatever) has the answer to those questions,

regards,
Daniele
