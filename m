From: David Barr <david.barr@cordelta.com>
Subject: Re: Status of the svn remote helper project (Nov, 2010)
Date: Mon, 8 Nov 2010 14:56:26 +1100
Organization: Cordelta Pty Ltd
Message-ID: <201011081456.26618.david.barr@cordelta.com>
References: <20101107112129.GA30042@burratino> <6A74D35D-A065-44B7-8DA4-6CA78DE067CF@cordelta.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 04:56:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFIqW-00069l-Sj
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 04:56:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754107Ab0KHD4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Nov 2010 22:56:34 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:48218 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754092Ab0KHD4d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Nov 2010 22:56:33 -0500
Received: by gyh4 with SMTP id 4so3108704gyh.19
        for <git@vger.kernel.org>; Sun, 07 Nov 2010 19:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:organization:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=Sh5PyZqL/iUQLX2VP+soVb6+ZF/TMHzeVdsdm7GfQ6w=;
        b=hC/USp4QOLW0L5+O/S98rcJzQ/uzXydpluiYv65Msmk2s1TOE+fJXkUoP5tfZbesKZ
         CIdrPHwhwb7CzFIAsp4wAmQ9YVn59douYoQ4ahgRXhviVKlqD7PLxhqmM3gfjS898ouS
         uyNk+JzDAHTw2YcBLQ7w9ufqlin8TKUhePsUI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=V49Vx7ZKCpRh/Kwv75iNBDstzbYaKZl6rErhOkCpEO7DFHS7F7vM/n3tqR4PcetT1X
         4XZytVhCkuH9UU9qUsWgd/xSj9gyoas0KkuKRkKVpBvYCphVNUGzaT/OPBfhyt80W9tJ
         ChAOM/BtswgjsftMBjzsH8d3tOX9iOutR2g4M=
Received: by 10.151.9.18 with SMTP id m18mr118199ybi.172.1289188592890;
        Sun, 07 Nov 2010 19:56:32 -0800 (PST)
Received: from dba.localnet (mailhost.cordelta.com [119.15.97.146])
        by mx.google.com with ESMTPS id r18sm3314491yba.3.2010.11.07.19.56.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Nov 2010 19:56:31 -0800 (PST)
User-Agent: KMail/1.13.5 (Linux/2.6.35-22-generic; KDE/4.5.1; x86_64; ; )
In-Reply-To: <6A74D35D-A065-44B7-8DA4-6CA78DE067CF@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160908>

Hi all,

> > [Cooking]
> > * jn/svndiff0 (2010-11-06) 24 commits
> 
> [...]
> 
> > An SVN-format delta applier.  Seems okay, but it has not been heavily
> > exercised with real-world deltas.
> 
> I'm testing this version against the original ASF dump that I used 
previously.
> Maybe one day we can try against the KDE repo - which is epic in 
proportions.

I've successfully tested this series against the ASF repository
(940,166 revisions) and 5,636,613 blobs were faithfully reproduced.

--
David Barr.
