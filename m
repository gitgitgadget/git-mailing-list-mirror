From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 2/2] git-svn: support fetch with autocrlf on
Date: Sun, 14 Feb 2010 01:27:53 +0100
Message-ID: <40aa078e1002131627x10fb9dfaq479b731f16d816aa@mail.gmail.com>
References: <1265997155-3592-1-git-send-email-kusmabite@gmail.com>
	 <1265997155-3592-2-git-send-email-kusmabite@gmail.com>
	 <20100213122532.GA31653@dcvr.yhbt.net>
	 <40aa078e1002130616u478397c0xf757d5424630e6cf@mail.gmail.com>
	 <alpine.DEB.1.00.1002140055550.20986@pacific.mpi-cbg.de>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Eric Wong <normalperson@yhbt.net>, git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 14 01:28:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgSLT-0001c2-8B
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 01:28:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758081Ab0BNA1z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 19:27:55 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:57118 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464Ab0BNA1y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 19:27:54 -0500
Received: by ewy28 with SMTP id 28so3010985ewy.28
        for <git@vger.kernel.org>; Sat, 13 Feb 2010 16:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=MUEeabRvA96anPE2rsRsDCcJyIl86mBm+3TAs00Kfaw=;
        b=b2zsF/+PXOcJAfNaEh/PqjgPIkjRvHkcmOG3E3mg4br8hX9rHJun4lUr+IKY25VT+4
         al0/c4M5mq5qeJ1LuvenLgHB9IijKHQs78cBHgipD5eK7O9EB3WVm3JQx5vEVyn7mOfK
         3TWb4x+o1HMFOwY/hDCC7PkdcTmLYJnDvUv9U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=XU6WzD6gZzNbcfBVBZ2wOHi9IbmlULFwqcOt3FxNVp/L4HGHQDJI4MBd/v0mqUl3WT
         X51CcxU2ESF5D2MPmnpTORSN97WONy0BR4GfGBMgjVZHT85q6O8pfAL73Bxp6z/8Bm0d
         7WXEa7RkSwnvnQO2YUi9ihlDx/udHaXHs4CdI=
Received: by 10.216.86.82 with SMTP id v60mr1594038wee.180.1266107273390; Sat, 
	13 Feb 2010 16:27:53 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1002140055550.20986@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139872>

On Sun, Feb 14, 2010 at 12:59 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sat, 13 Feb 2010, Erik Faye-Lund wrote:
>
>> I don't think it affects svn dcommit in any way, except from the
>> implicit svn rebase that svn dcommit performs. d3c9634e sets
>> core.autocrlf to "false" on init, but re-enabling it hasn't shown any
>> problems in my end. I'm using git-svn with these patches and
>> core.autocrlf enabled every day at my day-job.
>
> To elicit a warm and fuzzy feeling about your patch, you will have to
> analyze the code paaths of dcommit, and how crlf affects them. Then you
> will have to describe why dcommit does not have a problem with crlf with
> your patches anymore.
>
> Remember, the idea of a commit message is to optimize the overall time
> balance, i.e. avoid the many to perform what the one can do for them. And
> since you have to do that analysis for yourself anyway, it makes sense to
> write up the result in the commit message.
>

I'm sorry, but I'm confused. What missed from my commit message?

The question of dcommit was a question that Eric asked, and I'm not
really sure why he did. I tried to explain why in my reply. d3c9634e
never was about dcommit the way I understand it, but about clone:
http://code.google.com/p/msysgit/issues/detail?id=232

If there's something that isn't sufficiently explained in the commit
message, I'd like to know so I can improve it for the next round...

-- 
Erik "kusma" Faye-Lund
