From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Merge made by recursive?
Date: Wed, 25 May 2011 23:12:28 +0530
Message-ID: <BANLkTikRW+k38sHcokL=FsNmLRNF0+E--w@mail.gmail.com>
References: <loom.20110525T192418-887@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Shawn Ligocki <sligocki@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 25 19:42:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPI6g-0000D2-Cx
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 19:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499Ab1EYRmt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 13:42:49 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:64376 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377Ab1EYRmt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 13:42:49 -0400
Received: by wwk4 with SMTP id 4so3691599wwk.1
        for <git@vger.kernel.org>; Wed, 25 May 2011 10:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=tNnVtPA6LUfkHXKafIKGKeC9SNS+0DgI1C7iVPxEKzI=;
        b=eBt9hH5Nf7TLYZzKcH8XsKumCa+XDUOCCyicirSFxkq0RD6El2voJeeOtZAm7D6Qsj
         fFwg0IfC1mNfTqzeAbE3nxHM9aMNHFR2sg29UUgF/qadoG9kyjKdh7ZLBjIV5suXXEie
         JKYTmr8zEKYNXUyC8o6RPBIB6yQm9EQRdFyZw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=mvahdX2okUFcBpILEQdSYCGzsM9bsQZABvAwXEk1+HQXin5/qbIGCroREQTLTLIJv5
         Q9bImZBNOPdQjAJn8RhhuGFqgtJzL22ugs90+LcV2Zd0v7A/Wh6hEx+9ESUWWUhOBCTk
         uXEm0OGYn6/+Hp0UkBxSZjx09N+HKVdSifLSw=
Received: by 10.216.255.201 with SMTP id j51mr4602907wes.94.1306345368211;
 Wed, 25 May 2011 10:42:48 -0700 (PDT)
Received: by 10.216.158.70 with HTTP; Wed, 25 May 2011 10:42:28 -0700 (PDT)
In-Reply-To: <loom.20110525T192418-887@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174437>

Hi Shawn,

Shawn Ligocki writes:
> Is this intentionally bad grammar? Every time I see it, I cringe a little. What
> does it even mean? That it merged incrementally through each subsequent revision?

I suppose it's yet another quirk I've got used to -- "recursive"
refers to the merge strategy that was used; see git-merge(1). We can
definitely make the Porcelain say something nicer like `merged
successfully using "recursive" merge strategy`.

Patches are welcome: see Documentation/SubmittingPatches :)

-- Ram
