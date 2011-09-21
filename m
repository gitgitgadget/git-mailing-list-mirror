From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] git-read-tree.txt: correct sparse-checkout and
 skip-worktree description
Date: Wed, 21 Sep 2011 19:39:34 +1000
Message-ID: <CACsJy8AmvgjCwEikB-0NOf5gV+fcnFsAnhtYj6w6y8kfHu9b9Q@mail.gmail.com>
References: <cover.1316590874.git.git@drmicha.warpmail.net>
 <4E7996AA.4040909@drmicha.warpmail.net> <31152a2ddb83e37be1efce1d0cd742b71ea3efdd.1316590874.git.git@drmicha.warpmail.net>
 <CACsJy8BrBsBM-DwC_CkYrrpFU6aTqpcohWDPxTnRhMEX+w3Nug@mail.gmail.com> <4E79AF57.3010300@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Joshua Jensen <jjensen@workspacewhiz.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Sep 21 11:40:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6JHr-0007Ja-I1
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 11:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753882Ab1IUJkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 05:40:07 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46417 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748Ab1IUJkF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2011 05:40:05 -0400
Received: by bkbzt4 with SMTP id zt4so1274394bkb.19
        for <git@vger.kernel.org>; Wed, 21 Sep 2011 02:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=wsaM8NTJEWOJB6kCSuxPfwszDHW1/F+VAW4A8oabRU4=;
        b=LwiDr7LwY5lZR2S7a496xMaAgbwoF8lJ5ZDn+miSJtKLOvmT5ga/BCZAPjLHXtvkZJ
         i1cmSC9gveI6+2dYlY96TcqKKYVPyCJlxFtiZubupc4vwEAu7q5KgXPOYSVaPrsBmiVj
         YgGbNFy7jOEjTQelqLWOfvwxKoz0alnywwC9w=
Received: by 10.204.133.193 with SMTP id g1mr370741bkt.131.1316598004088; Wed,
 21 Sep 2011 02:40:04 -0700 (PDT)
Received: by 10.205.114.134 with HTTP; Wed, 21 Sep 2011 02:39:34 -0700 (PDT)
In-Reply-To: <4E79AF57.3010300@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181833>

On Wed, Sep 21, 2011 at 7:33 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
>>> In hindsight, it would have been much better to have a "sparse-ignore"
>>> or "sparse-skip" file so that an empty file would mean a full checkout,
>>> and the file logic would be analogous to that of .gitignore, excludes
>>> and skip-worktree.
>>
>> .gitignore works towards excluding files. No rule means no excluding.
>> sparse-checkout file works towards including files, no rule means no
>> inclusion.
>
> Sure, but with a "sparse-skip" rather than "sparse-checkout", we would
> not even need an additional config variable, and the skip-worktree
> centered explanations would follow the same logic (no need for the
> additional negation) as the ignore files and the new sparse-skip file.

I'll kill that config variable some day when sparse checkout code has
no overhead over normal case ("include all").
-- 
Duy
