From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Inexplicably deteriorating performance of Git repositories on Windows
Date: Wed, 24 Nov 2010 22:16:29 +0800
Message-ID: <AANLkTim-1uKTVacr1N=9bhZ+=ngggrJS=GD-YNjkSuBR@mail.gmail.com>
References: <AANLkTimTh7ka21inpovM=qqdWs6j2OcPXVsFh_CMiZ7N@mail.gmail.com>
	<AANLkTikXkWvHrc7=FjePfX5WyyNF1U=KH2DBCU+CcVu6@mail.gmail.com>
	<AANLkTimky3Ojc5w3PcCoJOs=NMfMpgUWUDcx+ry6h1dF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Wilbert van Dolleweerd <wilbert@arentheym.com>,
	Git ML <git@vger.kernel.org>
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 24 15:16:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLG9E-0007Bx-Mh
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 15:16:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493Ab0KXOQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 09:16:31 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:47520 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376Ab0KXOQa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 09:16:30 -0500
Received: by ewy5 with SMTP id 5so3149805ewy.19
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 06:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=oqDLWEEudjbgDzbqf/o59ggWywc/UfJy4FA7j+B2R94=;
        b=UZ4A2wzRiNu5m4LevTPDBlYAoQ2iY7nwsiT5pqkxkhwQU0v7KYSiLGYUaw/nATU3xK
         X3XwXLbfrJ5f1TDVnLX+TWfc2YKQr7xGtsU/qN+DAYOwPaXcwsHf3PHVe+NwMvIauWmI
         FeoVWz6FFxtO5Oa+0kNrhaoxwCxAx4mOR5K5w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Pf5GJGbLcfdlov7CztMhss/tubbD/PwXFfh2u8C8iuUdlJLvbyFxLgAtfxHLER5lCq
         C0MrCNP91NABUoEjjJG8WLntt6Mj3iWYVW9xNCnQTq8zIKJKWR/pvD37C3tXQaXtafd9
         Sd7e9xjx69jfgcK1MusB0Qx3Ki27Qv2tXeni4=
Received: by 10.213.28.133 with SMTP id m5mr3517115ebc.28.1290608189093; Wed,
 24 Nov 2010 06:16:29 -0800 (PST)
Received: by 10.213.112.195 with HTTP; Wed, 24 Nov 2010 06:16:29 -0800 (PST)
In-Reply-To: <AANLkTimky3Ojc5w3PcCoJOs=NMfMpgUWUDcx+ry6h1dF@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162063>

On Wed, Nov 24, 2010 at 3:59 AM, Dun Peal <dunpealer@gmail.com> wrote:
> On Tue, Nov 23, 2010 at 7:12 PM, Wilbert van Dolleweerd
> <wilbert@arentheym.com> wrote:
>> How big is your repository? We're using some fairly big repositories
>> over here but I haven't seen this behavior with the latest version of
>> msysgit.
>
> The working copy totals about 4GB. The .git directory, tightly packed, is 1GB.

What does the structure of your working tree look like? I think the
depth might be affecting performance.

-- 
Cheers,
Ray Chuan
