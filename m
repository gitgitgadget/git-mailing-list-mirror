From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 0/2] StGit patch series import
Date: Mon, 25 May 2009 00:04:31 +0200
Message-ID: <cb7bb73a0905241504s7d531f0lb5908a499d4345f@mail.gmail.com>
References: <1243149558-17160-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <7voctirzu6.fsf@alter.siamese.dyndns.org>
	 <cb7bb73a0905241443m6b5d6ba4vab438c856e47a947@mail.gmail.com>
	 <fabb9a1e0905241455j7045a920m11e7dcd6a92dd80a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 25 00:04:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8LoG-0001Hw-Kg
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 00:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758096AbZEXWEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 18:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755392AbZEXWEb
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 18:04:31 -0400
Received: from mail-fx0-f168.google.com ([209.85.220.168]:48218 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758584AbZEXWEb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 18:04:31 -0400
Received: by fxm12 with SMTP id 12so966652fxm.37
        for <git@vger.kernel.org>; Sun, 24 May 2009 15:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AVbPW98WFbXEge+F50n0feFAWjE6dindC57ag1XsMpk=;
        b=oDmafHwlVdQecphfmotHfKYkXhtDUYn93EgbM1Y6IkFzo75LW22TKmuVMUBV768hrn
         qSJZowba1vxullbnJerYuWG8vcGGDUPtAsgOSmY2hvVWFaSO4K1Ove8emQLx4pSR4Tc+
         Asz2evC5+7TwS3wx8ZX6Lntp35174j+5lJcmw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bH6mrZHwIO+rx1Kz1JvPI9OSv1StGIKKUBEN7Pl6/MLsBQ3HxwZ3zBT8cKXM78IJtU
         RDKRU8/yNGboucyhJ5BmD6u+Vpv7lOoNtVskjuRCdsUcbbWuK4XTKNEDNMGxYedAdDFV
         xaNdWSqxwlST7YeyUOmIyEQ4s+KAuofBlWutA=
Received: by 10.204.72.15 with SMTP id k15mr6272952bkj.14.1243202671817; Sun, 
	24 May 2009 15:04:31 -0700 (PDT)
In-Reply-To: <fabb9a1e0905241455j7045a920m11e7dcd6a92dd80a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119867>

On Sun, May 24, 2009 at 11:55 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Heya,
>
> On Sun, May 24, 2009 at 23:43, Giuseppe Bilotta
> <giuseppe.bilotta@gmail.com> wrote:
>> As I mentioned, Wine uses plain git, and we've tried asking this
>> (non-core) developer to expose a standard git tree. But he finds StGIT
>> much more comfortable for the task.
>
> Silly question, doesn't StGit have an export option? Methinks if all
> the developer has to do is run 'stgit export' and then attach those
> patches instead of the raw patches, it'd be really lame of him not to
> do at least that?

That's what he does. The problem is that StGIT export exports a patch
series using a given template which (by default) is not in mailbox
format.

-- 
Giuseppe "Oblomov" Bilotta
