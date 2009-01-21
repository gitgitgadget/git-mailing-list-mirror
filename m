From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] user-manual: Simplify the user configuration.
Date: Wed, 21 Jan 2009 21:39:27 +0200
Message-ID: <94a0d4530901211139x6296a48m14aa7ce1d8e65145@mail.gmail.com>
References: <200901211955.47362.markus.heidelberg@web.de>
	 <1232564650-3701-1-git-send-email-felipe.contreras@gmail.com>
	 <20090121191808.GF21686@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 21 20:41:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPiwa-0006gc-46
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 20:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbZAUTjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 14:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbZAUTja
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 14:39:30 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:44761 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbZAUTja (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 14:39:30 -0500
Received: by nf-out-0910.google.com with SMTP id d3so594614nfc.21
        for <git@vger.kernel.org>; Wed, 21 Jan 2009 11:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=x1UhmG2U3PNmRizZVBmvQbZx0W/Lt8DYFR8zVK8Tf0g=;
        b=GrteyVTo0bLAaNtk4VJkrjfs8xEkbzC1SHFjdF+mc8WRlBJ59l+cx9Ox2J/fU3A3Tb
         +Qw/Y7b5Jai2tKXAZwXbmoCP0YOzTp68Tm+AJGTSV8nRRAEQgm5lrF5Za0CnDXobKIXm
         J1LmjLQxxZmie0zDtiFlx+eg2ohAokEMhxZtY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UwImv4NGCXHn6QoqyMVy1NXzy7+v5OdzEEUGKzIQ0voEf0E7UXwVlLwVALo7fz/6nS
         6C6PDzF4OwykLEbmlmxhrw22jQmacP00U5ZiwNG38gNV69Kv/GRjfoI4l6qHmWLo09SY
         LzSohwH7dJ5oM3BcW8mPmahJR7q0sp1VQSkL4=
Received: by 10.86.91.12 with SMTP id o12mr42687fgb.16.1232566768029; Wed, 21 
	Jan 2009 11:39:28 -0800 (PST)
In-Reply-To: <20090121191808.GF21686@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106654>

On Wed, Jan 21, 2009 at 9:18 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Jan 21, 2009 at 09:04:10PM +0200, Felipe Contreras wrote:
>
>> This is shorter, avoids the burder to think about the format of the
>> configuration file, and git config is already used in other places in
>> the manual.
>
> I seem to recall this coming up several times before, and there being a
> sentiment that it was _good_ to introduce the user to concept of a
> config file. It lets them know that it exists, approximately what the
> syntax looks like, and demystifies what is going on when you type "git
> config" (i.e., it intentionally shows that there is more than way to do
> it).
>
> I don't have a personal preference, but you may want to grep the
> list archives for other discussion.

That's over complicating the user with what should probably be one of
the first things to do. Besides, do Windows users know which is their
home directory?

Maybe a comment like previous git config commands:
If you examine the file .gitconfig in your home directory, you will see this:

------------------------------------------------
...
[user]
       name = Your Name Comes Here
       email = you@yourdomain.example.com
...
------------------------------------------------

-- 
Felipe Contreras
