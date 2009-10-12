From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Re: Git: "No you can't handle my root!" (?)
Date: Mon, 12 Oct 2009 23:37:39 +0200
Message-ID: <1255383459.15646.10.camel@localhost>
References: <20091012012826.7sffggwmm8sk0cc8@webmail.demarque.qc.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: sylvain@demarque.qc.ca
X-From: git-owner@vger.kernel.org Tue Oct 13 00:07:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxT3L-0004FJ-6I
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 00:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758395AbZJLVit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 17:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758367AbZJLVit
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 17:38:49 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:51225 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933213AbZJLVir (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 17:38:47 -0400
Received: by ey-out-2122.google.com with SMTP id 4so2008177eyf.19
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 14:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=w9K9ANY7v/ggPvvGlGMPXxO3U3uGw5pFCbOW/3TQZ1Y=;
        b=NinFPW2sB70w65ql1Qpds7lrdSn9CGSzEJxn09l2XycE6DVCnMWuuPCRjvAazk5jzA
         6dtJD8eYdcHL5OkC1qwcoe8KJ0WWWSsRCllSbepgisI1wZTJOSV44wKogLgQjAUYzulH
         dS7bbwCDWAWXV21aLcC1KjEeMztSkdKSjO6Ys=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=CDVIaLKmje/ftX33JPiE/qaf14zChy0iVYYvQ5aV2cS1qHSzv3+HMZo0jWGIpjHQwU
         2DAWzlsL1txo42EWclsNRbkVmU9Z9xlYyQiHDQRMGO/Qkc8Ne0pTY4Y/YAcwp2MGQdRD
         kW1KOifaZQ0n+aU/u2E0eR5dRyJw3fritAl3E=
Received: by 10.211.161.22 with SMTP id n22mr4656963ebo.83.1255383458731;
        Mon, 12 Oct 2009 14:37:38 -0700 (PDT)
Received: from ?192.168.1.2? (host185-1-dynamic.48-82-r.retail.telecomitalia.it [82.48.1.185])
        by mx.google.com with ESMTPS id 7sm1379751eyb.0.2009.10.12.14.37.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Oct 2009 14:37:37 -0700 (PDT)
In-Reply-To: <20091012012826.7sffggwmm8sk0cc8@webmail.demarque.qc.ca>
X-Mailer: Evolution 2.26.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130080>

Il giorno lun, 12/10/2009 alle 01.28 -0400, sylvain@demarque.qc.ca ha
scritto:
> localhost / # git init


I don't see the point of using git on the root directory :)

but that made me think that it could actually be a good idea
for /etc/ :)
I happen to modify some configuration and then I forgot which one... and
sometimes updates broke something


And that make me think of another question...

is there a way to have a git repo for a subset of directory that match a
pattern?

for instance...

can I have a git report of $HOME/.* (without . and ..)? (all user
setting)

Or better: provide a list of directory under $HOME I want to track 

Instead of providing the list of directory I want to ignore i would like
to provide the list of the directory and files I want to track :)

I probably am going out of topic here but I hope you forgive me :)
