From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: commiting while the current version is in conflict
Date: Thu, 16 Oct 2008 21:16:10 -0400
Message-ID: <32541b130810161816r1667f018paa74525091f0682a@mail.gmail.com>
References: <2d460de70810161510ha220593g4615a55b2c3e3b25@mail.gmail.com>
	 <20081016224808.GO536@genesis.frugalware.org>
	 <20081016230035.GC9877@spearce.org>
	 <2d460de70810161626n4f4c4489k489b20f2e6cce186@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Miklos Vajna" <vmiklos@frugalware.org>, git@vger.kernel.org
To: "Richard Hartmann" <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 17 03:17:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kqdy1-0007rr-63
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 03:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752606AbYJQBQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 21:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752492AbYJQBQM
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 21:16:12 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:15659 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbYJQBQL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 21:16:11 -0400
Received: by yw-out-2324.google.com with SMTP id 9so73055ywe.1
        for <git@vger.kernel.org>; Thu, 16 Oct 2008 18:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=qSsmYoNJ59rFGEPZxwL6mm07f+v/JvG0b7sL6DoL/XU=;
        b=JyVyvLosSMX658VsAy5W+CzGgqLMu5mz9IP8Oa3CkncXeNTWsln4LRGceZ88RRcyaJ
         7DcOrOlOUbxI3+EUhHkmKWVzYkB8VXYOaex4CYFN8rHR+9JgK+Jgsh1npZ2kPGUj6IGv
         Xsol0cyFz2JmGxRhQ3GchvNrGPAPd+cMZBnQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=C9c9NNevAZic9Ep8JOK06cflzQzhjLXNmAECjj3eZ6f8wKUKfTsOIatZFVf439USWt
         0aYiZBN9tNMYA9fHEABSC6Zl9jsv0U9pa6NZRIbKcKO3ewus7Jx8w4d6AzU4EG1Kxqd9
         +8E4YKJK9KIXDaL7Gbk15I6wOugfnbnS9QRB0=
Received: by 10.150.148.1 with SMTP id v1mr1225009ybd.82.1224206170161;
        Thu, 16 Oct 2008 18:16:10 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Thu, 16 Oct 2008 18:16:10 -0700 (PDT)
In-Reply-To: <2d460de70810161626n4f4c4489k489b20f2e6cce186@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98439>

On Thu, Oct 16, 2008 at 7:26 PM, Richard Hartmann
<richih.mailinglist@gmail.com> wrote:
> On Fri, Oct 17, 2008 at 01:00, Shawn O. Pearce <spearce@spearce.org> wrote:
>> and merge conflicts are "resolved" by you running "git add $path"
>> after you have finished fixing that path.
>
> True, git add is an implicit resolving, I did not think about it this way.
> Personally, I think that git should break at this point, but that's
> just me.
>
> The obvious fix would be a pre-add hook. Does anyone else think
> this would make sense?

That would be awesome.  I've frequently been bitten by accidentally
running "git add" on a file that I *think* I've resolved the conflicts
on, but it turns out I missed a commit marker or two.  And then the
handy conflict-style "git diff" is no longer available, among other
things.  If "git add" could prevent me from adding the file at all, it
might save me some trouble.

On the other hand, an even better alternative would be to have a way
to "unadd" a file and bring back the conflict information, but I don't
know how that would really work.

Have fun,

Avery
