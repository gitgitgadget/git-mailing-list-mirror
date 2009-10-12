From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Git: "No you can't handle my root!" (?)
Date: Mon, 12 Oct 2009 20:15:04 +0200
Message-ID: <81b0412b0910121115s26c6c08s1ea54c28851faf05@mail.gmail.com>
References: <20091012012826.7sffggwmm8sk0cc8@webmail.demarque.qc.ca>
	 <20091012135910.ujqifycf9cwsk4ss@webmail.demarque.qc.ca>
	 <f488382f0910121106h64571b93jb92372a1d7720b10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: sylvain@demarque.qc.ca, git@vger.kernel.org
To: Steven Noonan <steven@uplinklabs.net>
X-From: git-owner@vger.kernel.org Mon Oct 12 20:16:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxPR7-0007Z0-C1
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 20:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757202AbZJLSPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 14:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755043AbZJLSPm
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 14:15:42 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:33969 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754846AbZJLSPm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 14:15:42 -0400
Received: by bwz6 with SMTP id 6so3316973bwz.37
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 11:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=QUf3m+PrjUwdRCckl5K1s7JzO1jlyXcXLAbJU9DeoSk=;
        b=USo4rtqF3JVXj0zc12bVVtEKSQhp8GxAWjX8KQVTUaaU2LYAH31dLHcXsaq6Hn+B31
         ANDScrLAVv8u7csZXSVbY3IB8Xs0EoDX4ol0TlfJVVja3/W07Fcqk2FyYs8r24SjJmZP
         Z8oyeMrygeBlPgEyF/v7RTUdUVGhPpu5FxPuI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=GY2RCWRCGLnE/fqYcne+gJTgQWeBlPdd598KQ+PxlEmUWt3DMruWXM7O8LMxUTF9Ix
         6yhMudpMvGnDjaedNXfaBie3Ff78P8DXwrB893We8hXKa89kLW26mLcSmC7diyyQbdUg
         ffTgQRCWb6duuvOd0dNGWz2fo8OKMsrNnerTA=
Received: by 10.204.32.16 with SMTP id a16mr5325390bkd.190.1255371304957; Mon, 
	12 Oct 2009 11:15:04 -0700 (PDT)
In-Reply-To: <f488382f0910121106h64571b93jb92372a1d7720b10@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130042>

On Mon, Oct 12, 2009 at 20:06, Steven Noonan <steven@uplinklabs.net> wrote:
> I've had this problem too, but I eventually realized it was git's way
> of telling me I shouldn't do that. But even so, it'd be good if we
> _could_.

It's more of "a note to the future generation of developers": "Hey guys,
we didn't need that working, but if you have a night to spare could you
please finish that?"
