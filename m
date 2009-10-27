From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Autodiscovery of git repositories from HTML
Date: Tue, 27 Oct 2009 06:28:27 -0700 (PDT)
Message-ID: <m3vdi1c6fw.fsf@localhost.localdomain>
References: <20091027130000.GX30085@Dorothy.plexq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Thurman <tthurman@gnome.org>
X-From: git-owner@vger.kernel.org Tue Oct 27 14:32:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2m6G-0000rT-Ty
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 14:28:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754777AbZJ0N20 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 09:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754604AbZJ0N20
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 09:28:26 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:54948 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753802AbZJ0N2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 09:28:25 -0400
Received: by bwz19 with SMTP id 19so184379bwz.28
        for <git@vger.kernel.org>; Tue, 27 Oct 2009 06:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=ZGYBIKpOKbP87T9xr/PYNJYGT6X8YMM+CsW+V1H/qhU=;
        b=pFVTPB618qpe+9P7NWs9DPKraQm/LIHndB9VET1KpepOCJGbRieDkJ8BcFl5GYdJx0
         GlYAopBBxeJheIApNeOOoqaOxQcy1Ol9mIxPjXwETfcVBEucJY1DQFgu1DiwJiY4orJH
         5RJgTSqYTeVE5fK2HpnaeOh/pf2lbNQN1ncxg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Uwui5cn10BGHiSZL6uzvN9mOxTAp9IGOsBAX2hSCXMeYKZa6f3sW9zR3W36/UMXIUQ
         sQZm/s+Lfi7uBpSdw36ESdOsW3YRDlV7vZgeFdUpd6cEpdHqdsI8lRYGCwDZmWHkgbfi
         NsVKXuG9dG12CUGAgKVh6yxWgF2wglF5gyc9g=
Received: by 10.204.155.65 with SMTP id r1mr5702894bkw.143.1256650109047;
        Tue, 27 Oct 2009 06:28:29 -0700 (PDT)
Received: from localhost.localdomain (abwd120.neoplus.adsl.tpnet.pl [83.8.227.120])
        by mx.google.com with ESMTPS id 13sm6294bwz.14.2009.10.27.06.28.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Oct 2009 06:28:27 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n9RDSEAl003477;
	Tue, 27 Oct 2009 14:28:15 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n9RDS3af003473;
	Tue, 27 Oct 2009 14:28:03 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20091027130000.GX30085@Dorothy.plexq.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131331>

Thomas Thurman <tthurman@gnome.org> writes:

> I have a web page which lives in a git repository so that it can be 
> easily mirrored.  I would like to use a "rel" link to the URL of the git 
> repository so that it can be automatically discovered, like an RSS feed:
> 
> <link rel="alternate" type="???" href="http://example.com/.git"/>
> 
> Is there any existing convention as to what the type should be?
> Note that this isn't necessarily the same question as what a git 
> repository should be served as over HTTP: the Universal Edit Button uses 
> a dummy MIME type of "application/x-wiki".

See proposal at http://joey.kitenet.net/rfc/rel-vcs/
(which use 'rel' microformat, rather than 'type' microformat).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
