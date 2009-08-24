From: bill lam <cbill.lam@gmail.com>
Subject: rebase hint unmerged file removed
Date: Mon, 24 Aug 2009 22:05:49 +0800
Message-ID: <20090824140549.GA3973@debian.b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 24 16:06:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfaBR-0000YS-6X
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 16:06:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552AbZHXOF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 10:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752487AbZHXOF4
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 10:05:56 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:8475 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473AbZHXOFz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 10:05:55 -0400
Received: by wa-out-1112.google.com with SMTP id j5so425129wah.21
        for <git@vger.kernel.org>; Mon, 24 Aug 2009 07:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:user-agent;
        bh=9KrXZhgzls7nsMReR8+L0V4j3oWOKeclI4W1BwpDREM=;
        b=G6mqLvTg2NEONsEVYrSHwtAGz4xsAbQYCNDPW2vdGsVQXIrNaF3l7WNcLMR5lC+1Cc
         IYixH+lbYtY851llz3hdLiLtlPj4Kb4niATAjF2XnH8+Z1z1DryZkUmR24NBwW4FH4zb
         6l38aCMt2x2tG0ax8n0VXONCeZaK1UtFYDfJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:user-agent;
        b=sKOtOI10G3So3Qu4/9B3DeUFq/EzWgHj5haiYY4sVBWrf8zC4me5D9iJyCfGo7aLzm
         wfZXHrda3m08CAhFOopeVCJcWaTb0ZYo0RGep8LvfxObq0ZoUYyzDXG9O87KZi4bQVOR
         MvkcwLospVrfDsTwjI95sZISJTSaa1GMVUwA8=
Received: by 10.114.138.20 with SMTP id l20mr5951497wad.126.1251122756551;
        Mon, 24 Aug 2009 07:05:56 -0700 (PDT)
Received: from localhost (n219078081149.netvigator.com [219.78.81.149])
        by mx.google.com with ESMTPS id j31sm9450016waf.49.2009.08.24.07.05.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 Aug 2009 07:05:55 -0700 (PDT)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126927>

Sometimes during rebase -i, it stopped with an unmerged file but that
file did not have any sections of conflict marked.  ls-files showed it
had :1: and :2: but no :3:  I suspected that file was git-rm in that
commit.  Will it be possible for git status or rebase to give hint
that unmerged file was actually removed?

-- 
regards,
====================================================
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
