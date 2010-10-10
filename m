From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Useful tracking branches and auto merging
Date: Sun, 10 Oct 2010 20:30:22 +0300
Message-ID: <AANLkTimFYExqr_OcYMJ0kTv5K-wtu3pzsAu=rhq+19W-@mail.gmail.com>
References: <AANLkTimq0sKUavKiXepDOz+DvrymuRAVUyAyV+FzbCBD@mail.gmail.com>
	<20101004204625.GH6466@burratino>
	<AANLkTikkXdDepdeOY4MZvgfCEgX69Tx6d0-QS-g3bWK-@mail.gmail.com>
	<20101010171505.GA15495@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Oct 10 19:30:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4zjK-0002B7-Uf
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 19:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757982Ab0JJRa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 13:30:27 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37816 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757871Ab0JJRaX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 13:30:23 -0400
Received: by bwz15 with SMTP id 15so1269590bwz.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 10:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=54L0Hli8MuTrmx4QA7ii923RIW8ZCbtsmxbOJfMT0gg=;
        b=OL1KMeFks0byQGMYx0bBflJ45tUsbbxxoduA3uD6Y2G3UtyDoBEImtVOUs+k/z6jV8
         UJG8RngELzogU16FVcY8RBS/H/B+kwO4v405zg2r9hwxZ74tI58fZQZxt2iOTDSvVnQc
         4WZxrQuWn5ODQkEdSjl9prYy0rvMCa68Jchac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=dodSUYzPzZK6qkhnWIq6XhsozqfJVGiYT+ztAYoD56EMFQNik2JmHVdzPfYaHlp2eX
         vPGvLR1kcpcT4KtC9pW4hxEXXtr2044RpvCB8nJWHKGhTScsyDLFo3BclLM3KWNEg4Qk
         PW5L4AWpCPmTxkrN+ToLf3+7hDp7ORLa7s1dM=
Received: by 10.204.39.203 with SMTP id h11mr4167121bke.8.1286731822339; Sun,
 10 Oct 2010 10:30:22 -0700 (PDT)
Received: by 10.204.75.16 with HTTP; Sun, 10 Oct 2010 10:30:22 -0700 (PDT)
In-Reply-To: <20101010171505.GA15495@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158680>

On Sun, Oct 10, 2010 at 8:15 PM, Clemens Buchacher <drizzd@aon.at> wrote:
> On Mon, Oct 04, 2010 at 11:56:02PM +0300, Felipe Contreras wrote:
>>
>> Moreover, wouldn't it make sense to make 'git merge' = 'git merge
>> @{u}'?
>
> Isn't that what 'git pull' does? Especially after using 'git
> fetch'?

No, it hits the network again: git pull = git fetch + git merge @{u}

If I already did 'git fetch' why should I do it again?

> I prefer 'git merge' as one of the few git commands without magic
> behavior and DWIMery.

There's no magic involved, it's just what you would expect, what else
should 'git merge' (without arguments) do?

-- 
Felipe Contreras
