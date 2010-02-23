From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Allow '+', '-' and '.' in remote helper names
Date: Tue, 23 Feb 2010 14:07:02 +0100
Message-ID: <fabb9a1e1002230507i56b32e8cwd7643a79284f6567@mail.gmail.com>
References: <1266928428-19075-1-git-send-email-ilari.liusvaara@elisanet.fi> 
	<alpine.DEB.1.00.1002231402350.3980@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 23 14:07:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjuU7-0002PA-1J
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 14:07:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471Ab0BWNHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 08:07:24 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49826 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359Ab0BWNHX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 08:07:23 -0500
Received: by pwj8 with SMTP id 8so3770313pwj.19
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 05:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=Ypcyv88ofZZg20b2yI40J4uK+YlvuaBagzFJBbe83gw=;
        b=uj+OhxVndxYOXjj3swIgqeA5mt13iHFdE16m4PnGfSo3RY1V6X6YyrC/PKYJ2LEWof
         mioML79+ZooUApXv07oXmavvWPTMr/n+nkDkv+8wk5r7scEsr7pDb4sYoe4kRFdBdmDq
         +TCYkh/hO+OIPKgFEyQ1aC4iQUrRQMdO+QoW4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=UIWBwvmysrBu2b8J9G3fFERPgPll/iwUrmEZNJhVrNotPqqFU7tiYbzbS3zX9bOtUM
         aJLzgMm3rrKAZP09Zc0HZW9Mnie87mehVC1sfF+UpCTflO98S6kS+LrvKfBIabhCJT9i
         ShFAshRKQ3KzapuBFdb8JgbElb2W9vKGtB5mw=
Received: by 10.142.210.13 with SMTP id i13mr4048546wfg.68.1266930442755; Tue, 
	23 Feb 2010 05:07:22 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1002231402350.3980@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140797>

Heya,

On Tue, Feb 23, 2010 at 14:03, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> May I caution against allowing "+" as part of filenames? On Windows,
> thanks to the DOS garb^Wheritage, "+" is not really allowed...

Would it be safe to say "raplce all occurences of '+' and '.' with
'-'? Is it feasible that we would want to support two protocols with a
different helper that map to the same 'name' using that scheme? So,
would there ever be a case where we want to handle "bzr+ssh"
and "bzr-ssh" with a different helper? I reckon not, and if it does
occur it's always possible to put a simple dispatcher in between?

-- 
Cheers,

Sverre Rabbelier
