From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] fixup! fast-import: let importers retrieve blobs
Date: Mon, 29 Nov 2010 19:22:14 -0600
Message-ID: <20101130012214.GA12515@burratino>
References: <20101128194501.GD19998@burratino>
 <1291074508-18926-1-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Tue Nov 30 02:22:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNEvT-0008FH-Rj
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 02:22:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756071Ab0K3BWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 20:22:30 -0500
Received: from mail-qw0-f66.google.com ([209.85.216.66]:62717 "EHLO
	mail-qw0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756065Ab0K3BW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 20:22:29 -0500
Received: by qwd6 with SMTP id 6so1721916qwd.1
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 17:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Dc8GykuWHm5Nr09nNUARddhOQYWxPV81pjjwnZ07AQs=;
        b=QMxfV65pvFE4CCMM41nf4DFxvtisLE1QogsdoIGUhED/jhxtQazscAp4vqePxBJHI0
         psfsTwxEKIuJAaaQnGtPxBdz79pGtbUNfodySW62WolLCNdZeRvoBrbaLsWT22whaoiO
         ffodR3eoMLOjHgPJsBQl0yxBhprf+9D5VyboA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Us8v36mqt4FPhSvW8Mn6nh0g4J6iLmERVvLIfeFjcOU3q/K/4KFu6JtA+0EbJY/HCJ
         ehPcoWaADnZQGH94MlI5x1MPICTkRk1VSodELHKs2fG37EBC1vYFvKp1goRN98M0JvrO
         E/KnmsUO4AVqUmUAfa08a8KDsFCph3uEJvD4k=
Received: by 10.224.64.75 with SMTP id d11mr5882295qai.214.1291080149007;
        Mon, 29 Nov 2010 17:22:29 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id t17sm3637387qcp.2.2010.11.29.17.22.25
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 29 Nov 2010 17:22:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1291074508-18926-1-git-send-email-david.barr@cordelta.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162459>

David Barr wrote:

[plug two memory leaks in "[PATCH 3/4] fast-import: let importers retr..."]
>
> Signed-off-by: David Barr <david.barr@cordelta.com>

Good eyes, thanks!

Acked-by: Jonathan Nieder <jrnieder@gmail.com>
