From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFD] Proposal for git-svn: storing SVN metadata (git-svn-id) in notes
Date: Tue, 31 May 2011 09:20:12 +0200
Message-ID: <201105310920.13323.jnareb@gmail.com>
References: <201105281154.25223.jnareb@gmail.com> <20110531045324.GA13661@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue May 31 09:20:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRJFf-0007Zp-6g
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 09:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667Ab1EaHUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 03:20:25 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62884 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767Ab1EaHUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 03:20:25 -0400
Received: by bwz15 with SMTP id 15so3388471bwz.19
        for <git@vger.kernel.org>; Tue, 31 May 2011 00:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=JmjGZ9Y+rknVvN1+/Qlu0q9BSZnJfKFUCtXxp15a6nM=;
        b=SPmyf7DX6xkcX5Zk7KeG33UM07hYevTRHJjECFHpjoKS9QazLTEY6EPJEwlLMLHGFc
         CV6RmA7OZ0q+1bBlSdkp004fxBeGrLmBSIzh1akVQeCi+lbS1hjjYsg7M6owyc1akC4H
         +Y6n6vhwLlxFq4A0oOQueXZ3mpiLq6WpNuf6k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=WuitFARYuchZTJZh3saipbK+H1ZG/lnbrhFN3WC34mondmmNzlyJV3uoo3iY6yGxMU
         NJI5jkxEBdxTDZVOBjWTJDH27hDr1CFNy73KSTfmazYBkUGfgMTqFfc7f0IRhV1P6gdx
         u8W0+cZpMEbyM8L0PeqmBA8QFCz7DS4+PuRRQ=
Received: by 10.204.127.1 with SMTP id e1mr5319387bks.77.1306826423901;
        Tue, 31 May 2011 00:20:23 -0700 (PDT)
Received: from [192.168.1.13] (abwc243.neoplus.adsl.tpnet.pl [83.8.226.243])
        by mx.google.com with ESMTPS id ag6sm3971922bkc.18.2011.05.31.00.20.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 31 May 2011 00:20:22 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20110531045324.GA13661@dcvr.yhbt.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174796>

On Tue, 31 May 2011, Eric Wong wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:

> > Eric, from what I remember you don't have time nor inclination for 
> > adding new features to git-svn, is it?
> 
> Yes, that's mostly the case.  I suggest anybody interested in working on
> git-svn further to split out the Perl modules into separate files before
> doing any more work on it.

Could you please at least review patches?  Would you have enough time
(and inclination) to do at least this?

TIA
-- 
Jakub Narebski
Poland
