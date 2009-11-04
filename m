From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2 11/13] Allow helpers to request the path to the .git 
	directory
Date: Wed, 4 Nov 2009 23:42:32 +0100
Message-ID: <fabb9a1e0911041442k493c5d7cx493c2e5dac9d892c@mail.gmail.com>
References: <1257364098-1685-1-git-send-email-srabbelier@gmail.com> 
	<1257364098-1685-12-git-send-email-srabbelier@gmail.com> <alpine.LNX.2.00.0911041621400.14365@iabervon.org> 
	<fabb9a1e0911041406tce0956ai2ad3fe6cfbdc546d@mail.gmail.com> 
	<alpine.LNX.2.00.0911041723010.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Nov 04 23:43:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5oZ9-0007L0-Lq
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 23:43:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932949AbZKDWmt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 17:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932925AbZKDWms
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 17:42:48 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:36140 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932791AbZKDWms (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 17:42:48 -0500
Received: by ewy3 with SMTP id 3so3685843ewy.37
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 14:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=gbxSxSZsjZaJCkLEhL86LMRYm6oYB16drABjTCaAiSU=;
        b=OZwxqvDJ67ig1KJyLpXotL0z2CFvg1LeDMFVcAmFLAdvOiQkh5zdQoJnbRBfr2XMyr
         uBiYHiVaH7SIajG+iRFH9INg/XjZwaiOHklJiBeEmbbXJzkSzGtWFDuXYzJGOhFU6Iui
         Bd/lfLRNkyaLLHLlFpceOCLDGms81SiiI4LKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=FI4FeDPvoYStgh+9qu99PUuWVW+0KiFdOJv2HrWCC6h7jRunEbG0jUKQXINv+JvLFb
         zRHtxnENbJ/rsrAaoRxfkAiw8r1gLkQ/HZPIWDANimi+5BGLTFCneFJbgzUpNgvN/Mde
         e7DOik29X7KRNxjWWChEzMI9nwR61Q+pcPtA0=
Received: by 10.216.91.84 with SMTP id g62mr602855wef.216.1257374572235; Wed, 
	04 Nov 2009 14:42:52 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.0911041723010.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132164>

Heya,

On Wed, Nov 4, 2009 at 23:27, Daniel Barkalow <barkalow@iabervon.org> wrote:
>> Yes, that would probably be a good idea, .git/info/remote-<vcs>/<alias> perhaps?
>
> Seems reasonable to me, unless we make it .git/info/remote-<vcs>, and tell
> helper authors to deal with having different imports not conflict with
> each other.

Ah, yeah, the helper might want to store some global state as well, so
'.git/info/remote-<vcs>' is probably best.

>> The marks option has been dumped in favor of 'feature import-marks='
>> and 'feature export-marks=' which will be in the reroll of
>> sr/gfi-options.
>
> Right, but the values of those have to be paths, and I think they should
> be relative paths, relative to the helper's state directory.

Hmmm, I don't remember exactly what we decided the paths should be
releative, pretty sure it was somewhere in .git/ though.

-- 
Cheers,

Sverre Rabbelier
