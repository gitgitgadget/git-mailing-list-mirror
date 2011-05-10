From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: git rebase --interactive commits order
Date: Wed, 11 May 2011 01:05:09 +0200
Message-ID: <BANLkTik6ZYVFP=2TnYiZ4iVZhOzSdizTEg@mail.gmail.com>
References: <BANLkTimX2tupqV464+Re8u06TT+qRmqPuw@mail.gmail.com>
 <BANLkTi=PyBfMxCbWNfJEXEP6-MphdeE+_Q@mail.gmail.com> <m2d3jr1mev.fsf@Spindle.sehlabs.com>
 <BANLkTim1e=+yoyxd1AAThVYMZ_X3nfz=7Q@mail.gmail.com> <7vbozai2qe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 11 01:05:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJvzt-0003AX-6O
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 01:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272Ab1EJXFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 19:05:40 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:38497 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142Ab1EJXFj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 19:05:39 -0400
Received: by qyg14 with SMTP id 14so4991484qyg.19
        for <git@vger.kernel.org>; Tue, 10 May 2011 16:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=q1WnhHtGZ3KHdFUZkQI8m92niC9NKjOmXfF2aQjwu+0=;
        b=sQ86XlLAvc1GqZAOGjLmr38ztIkjou897ldEK6wmfEqJHHpuS8omNEh76MQpcx8yFU
         WoZFqY7GO+RwGmQrbGGe6tLYR8j9Dq9QiXSv2yNoAd0Mg9y/woPiT84fyHs04hIJpQr8
         /36Og1/MW+nT8yA0cRaqdOVOKUMgJB3wCdYno=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=jHXN4nMmnCJpuxmrTraAw1vnM18teTX5M2Y+o7uWBqrdMnMRqmseZOJnrUTlZdr59S
         +B5owvvHaf/slG/6Gg6/tiFYkQjWzdaQkLt3zEPGwtH3CQ0wUf5iPo8fpa/8gYEFEthb
         /T/3S8Yd7XuiUsQ0N/0Qig/5Sd41eZAARvMf4=
Received: by 10.229.67.142 with SMTP id r14mr6614820qci.209.1305068739174;
 Tue, 10 May 2011 16:05:39 -0700 (PDT)
Received: by 10.229.234.15 with HTTP; Tue, 10 May 2011 16:05:09 -0700 (PDT)
In-Reply-To: <7vbozai2qe.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173380>

>> So, sounds like most people agree with me.
>
> No. You have to realize that happy majority are usually silent.
>
> It is just most people including me know better than reading your thread
> and filling the thread with the same "I have been completely content with
> the current order to read from top to bottom when reading text at the
> beginning of the screen (i.e. in the editor); do not change it".

Well if people really don't want it to change they'd speak up (like
you did), otherwise things will change and as you seem to suggest the
majority will be pissed off.

IMHO it's more like the majority don't really care.
Anyway, offering a "--reverse" patch off by default would please
everyone, I'll see what I can do.

Philippe
