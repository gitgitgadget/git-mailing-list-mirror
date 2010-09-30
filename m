From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] rev-list-options: clarify --parents and --children
Date: Thu, 30 Sep 2010 10:53:52 -0500
Message-ID: <20100930155352.GJ4850@burratino>
References: <e7f6a7b7bdd9b0c4b425b04cf536d64c7ed8265f.1285860651.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Sep 30 17:57:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1LVL-0003G7-4I
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 17:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083Ab0I3P5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 11:57:01 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41037 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250Ab0I3P5A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 11:57:00 -0400
Received: by ywh1 with SMTP id 1so709540ywh.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 08:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=64erSj2bqXknUcW3+ncEa7Y7P0umIkouDsvzT09ordk=;
        b=x7Fh0ubjfHw7w4SIOorBEFNxEXyWISWSy+Z7vmb5kSwvH00HgtY2w1FTpR2Tb7yXVV
         fJgmZ7g1nwfs2alidad3vhYQ4BGd/S+5MrjHONFkJ+QNA3+tF+XhcooEWFvWMW+ncXJf
         uq6Fvz6iWUW/fYUqCRK1zDHGewm/Fb2Auysz0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PKIKIG3Dh3VlHLX9Hh5xxBmDNZvA89Fg5QLtb7oxmemO9jDp5ykc+AXM424Eou6GbY
         m04wGQIFeFuzGknwuWHBNzbkiNnPZ2SgoWJa3aeS5756RPKeuqxG0nrKPjGej8+4uCJA
         CEhsgbxjW5WOAZCu3HjNJ07fEs+bRoUuWsrE0=
Received: by 10.101.176.29 with SMTP id d29mr4398809anp.163.1285862217460;
        Thu, 30 Sep 2010 08:56:57 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id k11sm739ani.30.2010.09.30.08.56.54
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 08:56:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <e7f6a7b7bdd9b0c4b425b04cf536d64c7ed8265f.1285860651.git.git@drmicha.warpmail.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157684>

Michael J Gruber wrote:

> Make it clearer that --parents resp. --children list the parent resp.
> child commits next to each commit, so that I understand next time.

Nice, thanks.
