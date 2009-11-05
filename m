From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2 09/13] Honour the refspec when updating refs after 
	import
Date: Fri, 6 Nov 2009 00:51:42 +0100
Message-ID: <fabb9a1e0911051551r2e13cfb9me0e668adb962f6bd@mail.gmail.com>
References: <1257364098-1685-1-git-send-email-srabbelier@gmail.com> 
	<1257364098-1685-10-git-send-email-srabbelier@gmail.com> <alpine.LNX.2.00.0911041601170.14365@iabervon.org> 
	<fabb9a1e0911041321i1ccec898r53ddafb9405c6331@mail.gmail.com> 
	<alpine.LNX.2.00.0911041624401.14365@iabervon.org> <fabb9a1e0911041745x577f7e4rc678da4d7d559193@mail.gmail.com> 
	<alpine.LNX.2.00.0911050016360.14365@iabervon.org> <alpine.LNX.2.00.0911050145010.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Nov 06 00:52:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6C7f-0002jB-AF
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 00:52:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758191AbZKEXv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 18:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757855AbZKEXv6
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 18:51:58 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:63456 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513AbZKEXv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 18:51:57 -0500
Received: by ewy3 with SMTP id 3so581170ewy.37
        for <git@vger.kernel.org>; Thu, 05 Nov 2009 15:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=Vpg+sMC6eVck8YvogVZeroSXYQ1Niw5lf7HqVuvHieA=;
        b=Ul8FJYWn0zje+hCNNSaMPRyCnao4103KG5ImejQY34bCu1onYE5LkLNzy7hRDLBOmY
         arO+LAa7Hl7laLaOdppC4Kpyeylv7JylixrL6igpOKB3WsWWLEJ6v/LN+2LCIrqtSlJr
         RWIbv2KXhoAklQ8n0OeuKcdML8CLD88o7q9AQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=I6Eu58xTowrL/C6jcwwv+LOeFitLapWiR4u3iLUMdpue+3JD6jJirEwpTCPXGTqgnP
         A5TR6zDxTOtN3aJ+IMPnJRdibw1hWxdzGnkzYutL9rrKpKYVHMhHglHdcduVZybCrTI4
         NznsOKXKzf2XtWLp776WFxd0esCusug8FBjCY=
Received: by 10.216.88.75 with SMTP id z53mr1130815wee.46.1257465122111; Thu, 
	05 Nov 2009 15:52:02 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.0911050145010.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132253>

Heya,

On Thu, Nov 5, 2009 at 07:53, Daniel Barkalow <barkalow@iabervon.org> wrote:
> Here's a patch (on my original series, which doesn't seem to be in pu any
> more, but should be floating around somewhere).

Why didn't you just base it against sr/vcs-helper which is currently
in pu, now I have to try to find where your original series was, and
rebase this patch against it. Assuming your main goal was to
illustrate the direction you think we should go it would have been a
lot easier that way.

-- 
Cheers,

Sverre Rabbelier
