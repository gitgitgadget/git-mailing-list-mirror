From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Failure cloning from a separate-git-dir repository
Date: Sun, 21 Aug 2011 10:27:44 +0700
Message-ID: <CACsJy8A4kvjn5Bgo6FtS+x4z=CRz8ctoDHh7D8XV3frOjDVfbw@mail.gmail.com>
References: <6csv47te4qv41ni53q0kf1fne0a4e1grnm@4ax.com> <CACsJy8AavETJb-Lm0Qd6Sz54zYbgvDUWmf+uXYTxO3+iYNHvoA@mail.gmail.com>
 <p800579qgdoocnq388veh5gpjbu7r9ph52@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Richard Tibbitt <gitlist@lazyprune.com>
X-From: git-owner@vger.kernel.org Sun Aug 21 05:28:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuyiC-0005YT-Sw
	for gcvg-git-2@lo.gmane.org; Sun, 21 Aug 2011 05:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755372Ab1HUD2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Aug 2011 23:28:17 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57925 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755468Ab1HUD2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2011 23:28:16 -0400
Received: by bke11 with SMTP id 11so2999344bke.19
        for <git@vger.kernel.org>; Sat, 20 Aug 2011 20:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GFWRotMAluCveriFz6eVvM+53KvCbCs8Deeog+9XiNs=;
        b=bMwgt1bllGF/kw3dHlPr0DkJQVmxDZR59plpyhRDSeHO2iWQEqwDqytoTkZxMe/+Zb
         +2aXbgC8chouemAHO2w/jDm71X7NNzE0WbmSPQ7egCvUNR696xoiP0/v1k4rxx3qU3uu
         DAZbWjPsnHMNsKN2m327AbAmi2EsPtawgyiUk=
Received: by 10.204.132.23 with SMTP id z23mr368654bks.383.1313897294288; Sat,
 20 Aug 2011 20:28:14 -0700 (PDT)
Received: by 10.204.156.19 with HTTP; Sat, 20 Aug 2011 20:27:44 -0700 (PDT)
In-Reply-To: <p800579qgdoocnq388veh5gpjbu7r9ph52@4ax.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179792>

On Sun, Aug 21, 2011 at 1:56 AM, Richard Tibbitt <gitlist@lazyprune.com> wrote:
> call git clone repo2git\.git clone2
> fatal: repository 'repo2git\.git' does not exist
>
> I guess this must be a peculiarity of msysgit on windows.

Yes. Try "call git clone repo2git/.git clone2" (forward slash). The
forward slash is hard coded some places in git-clone. I just want to
make sure you dont hit another problem.
-- 
Duy
