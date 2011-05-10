From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v5 0/2] git-completion: fix zsh support
Date: Mon, 9 May 2011 21:55:29 -0500
Message-ID: <20110510025529.GA26619@elie>
References: <BANLkTikkhryMa69DSx4EAYjw+aar4icKcQ@mail.gmail.com>
 <1304979299-6496-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 04:55:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJd6r-0000mr-10
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 04:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753031Ab1EJCzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 22:55:36 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:34326 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855Ab1EJCzf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 22:55:35 -0400
Received: by yia27 with SMTP id 27so2019312yia.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 19:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=86cYf67zatr8qJQgcWe+Y/dYfiwY/TkXO+dry+z5RNU=;
        b=IEXenialDndxGOQVKjgfLRttd0B9hrxFxl7mb9qRjvth6i1LxpZWrdMT5tAf7YZU3p
         KzjcdLllEof7p7Jxp6F2xnumIHg1v4hn7mIG2nmg88LBt5r9InXVakuniLbxk3Fck4nB
         obhrFDaX/aE2WzJabPIg9tjcQQEBBPkMRv+HY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=OvhH7c+mcRIKg5uf7M0RsQ92ixukIE3dhuqLpf0QJReBnuLdvTgkiDTtRZtS7gKAew
         nJFmnmiZc6X3Vbm7LBIiCOazhTGwH4E73w/M2/zH9/h7PAzpvLN4/i2HlNGRzm9gqj7u
         sVzIx5t5VwshQ0lNikFsQJUERvHn22zPuwuBk=
Received: by 10.151.60.9 with SMTP id n9mr1038671ybk.394.1304996134597;
        Mon, 09 May 2011 19:55:34 -0700 (PDT)
Received: from elie (wireless-165-232.uchicago.edu [128.135.165.232])
        by mx.google.com with ESMTPS id u32sm1942488yba.24.2011.05.09.19.55.32
        (version=SSLv3 cipher=OTHER);
        Mon, 09 May 2011 19:55:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1304979299-6496-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173299>

Hi again,

As promised, here are two patches.  No doubt I have done all sorts
of horrible things to ruin them.  Sorry about that; thoughts,
improvements, bug reports welcome.

Felipe Contreras (1):
  completion: suppress zsh's special 'words' variable

Jonathan Nieder (1):
  completion: move private shopt shim for zsh to __git_ namespace

 contrib/completion/git-completion.bash |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)
