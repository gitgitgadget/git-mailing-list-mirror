From: bill lam <cbill.lam@gmail.com>
Subject: Re: how to add an empty initial commit
Date: Mon, 31 Aug 2009 08:06:22 +0800
Message-ID: <20090831000622.GA3993@debian.b2j>
References: <20090830005224.GC10952@debian.b2j>
 <BLU0-SMTP13B5A682834BA2E926F610AEF30@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git <git@vger.kernel.org>
To: Sean Estabrooks <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Mon Aug 31 02:06:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhuPv-0000os-TU
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 02:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753965AbZHaAG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 20:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753784AbZHaAG1
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 20:06:27 -0400
Received: from mail-gx0-f205.google.com ([209.85.217.205]:52421 "EHLO
	mail-gx0-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753840AbZHaAG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 20:06:26 -0400
Received: by gxk1 with SMTP id 1so4613171gxk.17
        for <git@vger.kernel.org>; Sun, 30 Aug 2009 17:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=aiRtgdzXMTgzgqTRE3O173/diATJpyhPRqq97oc5CgM=;
        b=iVmlynXPe228Xhk4B4amipY9nU4qxJL4xMTmClsMHkND251BspTji61Hr8nXOUCB1J
         8EEGs0p+DHiEMwgaH8GSWvNQdc1Ty3qAH2BOlY6dtW59qw4DMuTq5wZXmKuFtsKndRo3
         glPPzsTABmf2f7T73jOOIXZhpn8iZs7e0coEo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=fFfczNz5FXwDB8rR6B8iwwknLOmCz7a3Yi2InOCXS3X/op/cwEDgQ9BhaEKoi9V33F
         BpqFkTJWGtZHQhkP2Y+bQ8TWlLTwMQSByokWH+cKGKvrcvRjCoNfYk7eL59GwN9oWc3V
         +jY/jdvIFNljTnRvS5Tow3rxwnnBmfig/zUdg=
Received: by 10.91.95.5 with SMTP id x5mr3501961agl.28.1251677188038;
        Sun, 30 Aug 2009 17:06:28 -0700 (PDT)
Received: from localhost (n219077026253.netvigator.com [219.77.26.253])
        by mx.google.com with ESMTPS id 36sm2399606agc.60.2009.08.30.17.06.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 30 Aug 2009 17:06:27 -0700 (PDT)
Mail-Followup-To: Sean Estabrooks <seanlkml@sympatico.ca>,
	git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BLU0-SMTP13B5A682834BA2E926F610AEF30@phx.gbl>
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127447>

On Sat, 29 Aug 2009, Sean Estabrooks wrote:
> This sounds like a hard way to go about things.  Instead, you can edit
> the files as you wish, "git add" the new edits, and then use
> "git commit --amend" to alter the initial commit.   Don't think rebase
> would help in the situation you describe.

Sean,

Yes, you are correct. git-rebase does not help much.  It has to initialise
another empty git repo and copy all commits to there.

-- 
regards,
====================================================
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
