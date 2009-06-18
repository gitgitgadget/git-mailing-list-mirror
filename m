From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH] Re: rebase -i: auto-squash commits
Date: Thu, 18 Jun 2009 02:11:11 +0200
Message-ID: <20090618001111.GB12954@vidovic>
References: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com> <43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com> <7vvdmurfao.fsf@alter.siamese.dyndns.org> <20090618063348.6117@nanako3.lavabit.com> <alpine.DEB.1.00.0906180007370.26154@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Tapsell <johnflux@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 18 02:11:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MH5Dy-0003yZ-NZ
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 02:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416AbZFRALR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 20:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752067AbZFRALQ
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 20:11:16 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:58966 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbZFRALP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 20:11:15 -0400
Received: by ewy6 with SMTP id 6so1023241ewy.37
        for <git@vger.kernel.org>; Wed, 17 Jun 2009 17:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=yhlu8UnqRE83qwj3tAPWivR8XqtyT6wJ1q17ex3teS8=;
        b=PQgkRbLh4cXCq79L7eq89U21I6ULbtgPG+3DZsFkco/4StYo3RCdUz7qEoqX+3Tjee
         Te4ExvVi3cqNYnYQrZOM3ZHWVFZ7ayGRdyWV+xDVHl+sYK3SHR/fzb7i1AJexgY2mIsB
         GVKPwQ+luzpbyVkSmhYrEIIAxcWDXgNRbfCjw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ap4+ozHircYeiVNZH6TGJ1R0uLwFGhd19Dq22bVyhvWIci99lGDQ6bd/F0oqPaf+I6
         NRO9HoYNFxNbrB91z1ayQf0CfIMSuLKuN/uJT8hChXCxhyq8wTee4LyUJgNvl5B/4U+D
         GXt5iLe6YNB/NbsE34bvpQZoklEqiMuEeWOBc=
Received: by 10.210.28.18 with SMTP id b18mr3565894ebb.95.1245283877131;
        Wed, 17 Jun 2009 17:11:17 -0700 (PDT)
Received: from @ (mac33-4-88-163-66-33.fbx.proxad.net [88.163.66.33])
        by mx.google.com with ESMTPS id 28sm344282eyg.44.2009.06.17.17.11.14
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Jun 2009 17:11:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0906180007370.26154@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121787>

The 18/06/09, Johannes Schindelin wrote:

> > When the commit log message begins with "squash to ...", and there
> 
> I do not like this at all.  It assumes that you never have valid commit 
> messages starting with "squash to".

Plus, a commit message should not be anything else that a message about
a commit. Please, don't make the Git's behavior depends on the commit
message itself.

If we need a program to have various behaviours, we have:
- the compilation options;
- the command line options;
- the configuration files.


-- 
Nicolas Sebrecht
