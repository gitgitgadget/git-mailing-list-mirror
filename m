From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: feature request: excluding files/paths from "git grep"
Date: Thu, 26 Feb 2015 18:58:14 +0700
Message-ID: <CACsJy8Dw5tfQ72kqc-QEfGmbs=ZOePGuXd6+tRtkmApMcdma-A@mail.gmail.com>
References: <54EDBEC2.8090107@peralex.com> <CACsJy8AM=W4f6u_7YpvmfiBwrJjqfJMJoq6CQYfKOh+qD6rF3Q@mail.gmail.com>
 <20150225143116.GA13567@peff.net> <xmqqk2z5on72.fsf@gitster.dls.corp.google.com>
 <20150225185128.GA16569@peff.net> <xmqqbnkholx9.fsf@gitster.dls.corp.google.com>
 <20150225191108.GA17467@peff.net> <54EF0089.6070605@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Noel Grandin <noel@peralex.com>, git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Feb 26 12:58:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQx5e-0001Pe-Aj
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 12:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753643AbbBZL6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 06:58:46 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:45187 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752978AbbBZL6p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 06:58:45 -0500
Received: by iecat20 with SMTP id at20so13809700iec.12
        for <git@vger.kernel.org>; Thu, 26 Feb 2015 03:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lykQzZDeimYVelVn5SMX3CR4IcHHpp+FXFhEDWXkvuM=;
        b=PLrbVpnd5k7GDl0Qj8E9OXumiJY/DOvy9Fgm7TdU7epho3uXLhLtxP+NczygUaU+Kw
         rjjRyCzyi40nNDakgnW3wft/PsmY7/vhMHp3KTldhAYEVTEd84WKHs9Gvmg6n+V1ZDrq
         FW44lXToZbwGlOski4LXTdqPRwgI6f0MjOAjwQbFqUb6AWBTYtqPS/ULgV6iXiJO3W6x
         3b3DnUK8WruDz8Wpcjzccy4D9RgZSw/9UrN/fTQg3jTy3lLAyMDTkSwQ3MSBNknD43Xh
         RPfd4Tb4h10O1zFTFk/OZe8+J7h1VZsNx9unK3Pa+s1nNhWgDX1xDRrmWhtUSPCYfhhN
         dtxA==
X-Received: by 10.43.20.71 with SMTP id qn7mr9170008icb.47.1424951924824; Thu,
 26 Feb 2015 03:58:44 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Thu, 26 Feb 2015 03:58:14 -0800 (PST)
In-Reply-To: <54EF0089.6070605@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264435>

On Thu, Feb 26, 2015 at 6:16 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> So, as a summary of the discussion, it seems it's time to switch the
> default to --textconv for git grep?

Either that or make it clearer in git-grep.txt about this diff
attribute. It takes me some time to make the connection after reading
both git-grep.txt and gitattributes.txt
-- 
Duy
