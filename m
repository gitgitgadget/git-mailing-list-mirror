From: Pieter de Bie <frimmirf@gmail.com>
Subject: Re: About -X<option>
Date: Sat, 5 Jul 2008 15:48:07 +0200
Message-ID: <AB745D70-D23A-4742-A5B3-DC1B6CAD9C30@ai.rug.nl>
References: <alpine.DEB.1.00.0807051454060.3334@eeepc-johanness> <20080705133245.GH4729@genesis.frugalware.org>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	gitster@pobox.com, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Jul 05 15:49:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KF88W-00061l-9m
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 15:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219AbYGENsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 09:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752102AbYGENsO
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 09:48:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:26938 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbYGENsN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 09:48:13 -0400
Received: by ug-out-1314.google.com with SMTP id h2so899340ugf.16
        for <git@vger.kernel.org>; Sat, 05 Jul 2008 06:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:to:in-reply-to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :references:x-mailer:from;
        bh=D4FUxzGDBYZUodVBVg/RP007qwllHhvhV0WwI6DzQtc=;
        b=HsDG7cMRwtliWH8pe3J7G1FORl3/ALB4oxMRjmeKsgXdVjCAGvmZthIUFx62nVD1aS
         cGIkP6T51JSzTEX9iyi3PDXtdgERORXNmjCD7xzI/YCP3WOwvaXcVWFmzGl6cUGzoJsj
         LAqy8ofGuAw+j5Vs+t7OT0vtdjLZfAeSotxbc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:to:in-reply-to:content-type:content-transfer-encoding
         :mime-version:subject:date:references:x-mailer:from;
        b=I4yij//h2WrtYLK5pBr1YDf0Qrzeew4n8DEX6FChEbNHYJg3WslN3HO0dfb6JwgNqL
         zrXR84uhgtvBS2FhjIKBLW/VHBG4fSE42qK6C1A65zcofOl6JRumcJxW7+yhltJg5ME0
         y7VTj7j54MwY+HR2OGY5SdAfvdnZG2RfM8fTM=
Received: by 10.66.221.6 with SMTP id t6mr3142598ugg.55.1215265691535;
        Sat, 05 Jul 2008 06:48:11 -0700 (PDT)
Received: from ?192.168.1.11? ( [85.145.147.28])
        by mx.google.com with ESMTPS id 29sm736452uga.42.2008.07.05.06.48.08
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 05 Jul 2008 06:48:09 -0700 (PDT)
In-Reply-To: <20080705133245.GH4729@genesis.frugalware.org>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87446>


On 5 jul 2008, at 15:32, Miklos Vajna wrote:

> As a user I would think that it tells git-merge to first try  
> 'recursive'
> then 'theirs'.
>

I agree with this. Perhaps there's an easy fix: how about a colon?

	git pull -s recursive:theirs

might be more intuitive?
