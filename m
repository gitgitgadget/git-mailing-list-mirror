From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-completion: fix zsh support
Date: Tue, 26 Apr 2011 20:35:59 -0500
Message-ID: <20110427013534.GA14286@elie>
References: <1303867612-15975-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stefan Haller <lists@haller-berlin.de>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Mark Lodato <lodatom@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 03:36:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEtfs-0004Wf-5R
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 03:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755807Ab1D0BgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 21:36:10 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:40674 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755458Ab1D0BgI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 21:36:08 -0400
Received: by yia27 with SMTP id 27so456032yia.19
        for <git@vger.kernel.org>; Tue, 26 Apr 2011 18:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=2r90fZBD2TAiwUvYRYxuvZVsfedgFU2968c52WdffcE=;
        b=ibRIq0jtIq/yyAEfOtNFcuzPMHaBbG37/PuSW7/Dpp/W8s5sBhmR6ubuqh3fcY6DvN
         tnvnciRMK1fuwgamHQZ3pMJLqr8U0Wfk27wRC1+TKecpEzNGPJU4zejHxC0njEUxbwr+
         xxf79HIZ5IaRFY3HEn7+0A7zSxXcijHtGFq68=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=YErMmA8FU/LwdovQ5r2btGH9HxEHTY4UqdxlhmSyvKsDpfdrTMtcbDM4nFEloZNqjQ
         Nh7OBH7a3fAJvzFLUmnrdVLQfjtYFy/Wg/IIWOYiHS6bTS9KWuRQfep6/PWcb9d28B/j
         KJJP2WunTmriua3lJTZrky8PQJMbd2TsY3Whs=
Received: by 10.150.58.3 with SMTP id g3mr1477444yba.23.1303868167068;
        Tue, 26 Apr 2011 18:36:07 -0700 (PDT)
Received: from elie (adsl-68-255-96-190.dsl.chcgil.sbcglobal.net [68.255.96.190])
        by mx.google.com with ESMTPS id q34sm605492ybk.3.2011.04.26.18.36.04
        (version=SSLv3 cipher=OTHER);
        Tue, 26 Apr 2011 18:36:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1303867612-15975-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172143>

Felipe Contreras wrote:

> It turns out 'words' is a special variable used by zsh completion, and
> it has some strange behavior as we can see.
> 
> Better avoid it.

Hoorah!  I imagine this fixes a regression introduced by
v1.7.4-rc0~11^2~2 (bash: get --pretty=m<tab> completion to work with
bash v4, 2010-12-02).

 Acked-by: Jonathan Nieder <jrnieder@gmail.com>

>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/completion/git-completion.bash |   66 ++++++++++++++++----------------
>  1 files changed, 33 insertions(+), 33 deletions(-)

Stefan and Mark, if you'd like to try this out, the patch is at
http://download.gmane.org/gmane.comp.version-control.git/172142/172143

Happily,
Jonathan
