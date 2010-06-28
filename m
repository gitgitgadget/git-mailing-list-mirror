From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [OT?] Executing Git from bash script invoked by cron
Date: Mon, 28 Jun 2010 23:43:24 +0200
Message-ID: <20100628214324.GB30558@debian>
References: <4C290D88.80306@cedarsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schneider <mailings@cedarsoft.com>
X-From: git-owner@vger.kernel.org Mon Jun 28 23:41:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTM5R-0006t5-0e
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 23:41:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753341Ab0F1Vls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 17:41:48 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42968 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184Ab0F1Vlr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 17:41:47 -0400
Received: by wyb38 with SMTP id 38so2219813wyb.19
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 14:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=MeU8IAzAgng0o6boa7AclFu2Xn5kZR90E/C5btO6xMY=;
        b=mJrt9DUbZC0eVf6Vvl4o9pd+BqFEYouycfzbwhTQEHU3w8IGFJN9JLocbdJfdvbc3M
         BWEVRL4r4IXoeeC65MLUG/XekZKtB4Aulpel0NutYKclcP3ruDlyGEDyliOigDwrgbU1
         eCE49PPQsmJysaNT5TvpjGjns0krI3JEpuDTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=FuK8DIz/SV/FGSMa6K/JNoxQqtWOb2Jt7lg3HgQfXZUNcRwrJ/4UXJUE8Ogpi9jjCq
         lNG0ULJJeoEWFB436IiYyPelOzq68I6jV0yT8t2CiYtWwEWfh4ACWz3iVDxFPAOgXuMt
         yL3N+f1ChyucEBtxlXBBuBGZnmGatG4f0VseI=
Received: by 10.216.176.134 with SMTP id b6mr8691618wem.24.1277761305313;
        Mon, 28 Jun 2010 14:41:45 -0700 (PDT)
Received: from debian (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id 39sm2004783wet.19.2010.06.28.14.41.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Jun 2010 14:41:43 -0700 (PDT)
Mail-Followup-To: Johannes Schneider <mailings@cedarsoft.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <4C290D88.80306@cedarsoft.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149864>

Hi Johannes,

Johannes Schneider writes:
> I try to mirror my local git repository.
> Therefore I created a bash script. This script, executed form the
> command line, works fine.
> 
> But the same script executed by cron, does not work. Git push does
> simply nothing. No output, no push, nothing.
> But git log and git --version works...

Perhaps you're not executing that `git push` as the same user, and
therefore there's some problem reading the config files to determine
where to push to? I really can't tell much else without some output.

-- Ram
