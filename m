From: Eugene Sajine <euguess@gmail.com>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor 
	with no changes written
Date: Tue, 2 Feb 2010 18:34:55 -0500
Message-ID: <76c5b8581002021534i1f0dbd18y1b216233d282cd84@mail.gmail.com>
References: <76c5b8581002021207y3eccdc19i9a4abcc3d04315f0@mail.gmail.com>
	 <8c9a061002021214j673afbc8vfa5d941fba518648@mail.gmail.com>
	 <32541b131002021227o1ec9f369w6096e85382857b8a@mail.gmail.com>
	 <76c5b8581002021247j6df8f609ld9e5d87a060a5423@mail.gmail.com>
	 <394FB581-C9B9-40AB-AFB6-39B68ED5BEAD@wincent.com>
	 <76c5b8581002021356m52bb1817k9a4a29da0d4b681d@mail.gmail.com>
	 <77153A83-158D-4D36-A622-7AA3947C7D52@wincent.com>
	 <76c5b8581002021431o2b5073a0s42b273b6d61893db@mail.gmail.com>
	 <alpine.DEB.1.00.1002022356460.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Wincent Colaiuta <win@wincent.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 03 00:35:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcSGt-0005FP-1D
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 00:35:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754469Ab0BBXe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 18:34:58 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:41880 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792Ab0BBXe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 18:34:57 -0500
Received: by iwn39 with SMTP id 39so819434iwn.1
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 15:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=4pWHLLGjM1wc8bkTSUYawhzHVOxGYNDcx82PZ/tEBPA=;
        b=UWbDrmvQUQo5hNoOEhWqDMbS7JGP1pHCo+4zppMXOxRHaVqlHi9ZxGwVHYiHFTLNjw
         chUJxYNhK4+JINwuLtjdc93h8io6SxUuD1pxdvbz5MTUgJ0lHZDjiLWg6rKQoka0w3YL
         8ai/ZMVuj/m8x8kPookAx87BuHnvxkL+ESQeo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=lcLa2UgdHk8MffZI76RlsnZtqBRXolo/iOafoGK1B2//dsSA12krU0Muv+7JiJW88x
         UM+CKzlzy81YjYoPkDpkSijFg3mfF6QV3QP2zXeq8LjeB4nw4lpUEmtqFMeYYZYJ/Dmj
         rwO5kafenDTlhfbJqASRhzHjjZHWkgu3TQdHs=
Received: by 10.231.154.207 with SMTP id p15mr869436ibw.91.1265153696118; Tue, 
	02 Feb 2010 15:34:56 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1002022356460.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138781>

> Of course, you could come up with wonderfully complicated strategies such
> as "if nothing was added, then an unmodified commit message means 'abort',
> else it means 'go ahead'", but I hope that you agree that this would be
> very bad from the users' POV: it would be utterly confusing.

No complicated strategies necessary.
I'm not talking about modified or not modified commit message. I'm not
forcing anybody to modify commit message in order to proceed with
commit --amend.
I'm talking about consistent behaviour of main operations:

Commit - you must save on exit from your editor, simply exiting will abort.

Same should be applied to rebase -i and of course to commit --amend as
it is still commit operation.

Even if the text is OK or you agree with generated sequence of rebase
- confirm that explicitly by saving on exit from the editor, else it
should abort. Pretty obvious to me...;)


Thanks,
'Eugene
