From: Victor Engmark <victor.engmark@gmail.com>
Subject: Re: [RFC] Possibility to have a per-user config directory
Date: Wed, 30 May 2012 13:49:37 +0200
Message-ID: <CAA5Ydx9u_nckv8MHXLhKR2JwCgptJq81vXpaHsA1Hqvb4Enuqg@mail.gmail.com>
References: <20120530015035.Horde.XJPMC3wdC4BPxWDLkXMByVA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr
To: nguyenhu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Wed May 30 13:49:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZhPT-0007FX-0R
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 13:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752962Ab2E3Ltj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 07:49:39 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:44302 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573Ab2E3Lti (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 07:49:38 -0400
Received: by gglu4 with SMTP id u4so3355842ggl.19
        for <git@vger.kernel.org>; Wed, 30 May 2012 04:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OTy/H+CZAQQBeiJi92HJfS+Y6QnlzYKEHDFuqZlRxV4=;
        b=yrEy8/fkZkIRLX0S2f7xfep5jA23E/D5o6Y0285WxdDVW4we1m2+FBBG1OKaTcwIik
         ssgvTJDePm2k1vz/mpeWgJxgn1Vectowq/hvEe0PTGeNZ9l7Rj4Z37318ZqVms49/If1
         aC03GWeOauyDg6/RrLVNBCgWvbZ4iplU1hYjln2+w1UjCt65fkoggdAGO9SGCdExVIYO
         w3T8QBWKCHAVs1Qfcdfwn1YDqLKT724MDd6QQaQpxwcvsy8DPQ7FNvAPeF31VwOFoi06
         BcB1SukyG2SEbOmWOynRqjBFXeLbWPev0crulj1uHWSVGJfASzY8MJroA9TbyFdGHCwG
         eAkQ==
Received: by 10.236.185.38 with SMTP id t26mr15045961yhm.92.1338378577650;
 Wed, 30 May 2012 04:49:37 -0700 (PDT)
Received: by 10.147.133.2 with HTTP; Wed, 30 May 2012 04:49:37 -0700 (PDT)
In-Reply-To: <20120530015035.Horde.XJPMC3wdC4BPxWDLkXMByVA@webmail.minatec.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198805>

On Wed, May 30, 2012 at 1:50 AM,  <nguyenhu@minatec.inpg.fr> wrote:
> Patch for writing:
> Git would write its configuration in $XDG_CONFIG_HOME/git/config file if:
> - this file exists,
> - and ~/.gitconfig file doesn't.
> Otherwise git would write its configuration in ~/.gitconfig as usual.

Minor suggestion: Write to $XDG_CONFIG_HOME/git/config if:
- $XDG_CONFIG_HOME/git exists (and therefore is planned for use even
if there is no config file within)
- [etc. as before]

Cheers,
Victor
