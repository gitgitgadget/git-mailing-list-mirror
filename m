From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/v2] git-basis, a script to manage bases for git-bundle
Date: Wed, 2 Jul 2008 11:44:45 +0200
Message-ID: <200807021144.46423.jnareb@gmail.com>
References: <1214272713-7808-1-git-send-email-adambrewster@gmail.com> <c376da900807011836i76363d74n7f1b87d66ba34cd6@mail.gmail.com> <20080702032155.GA13581@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Adam Brewster <adambrewster@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 02 11:46:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDyuU-00038M-Hu
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 11:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077AbYGBJpB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 05:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753353AbYGBJpB
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 05:45:01 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:27702 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752943AbYGBJpA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 05:45:00 -0400
Received: by nf-out-0910.google.com with SMTP id d3so88795nfc.21
        for <git@vger.kernel.org>; Wed, 02 Jul 2008 02:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ZND2pMlk4iIMbxkWltJXS8D8F7I6jLyizZLf95fQ+kU=;
        b=Ie1oEjQh/fIyvMHOSObsYllgQg8ZDtwes7HkO3/748uQQ7elsmQmjLJFTx2yRiCWFS
         qQ8ejc1UQm08nkN/jJTMndiH8MkkYRh1Qr4Xo0CbOaUQxcvVI5hHEexO9HWmD6+rk9Hv
         AAo/YhA/x7DUoL2thhODVxT2ujuNQEmI3jk4c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=cob9YSyQKqw0X+haIiwioGa8cbdxl+x7rtNIr50d1CDhuz0aza8N+gjBqvK4GAfRIN
         /pEzgaW5R3FNX8bOfo8qlh6O2C9Le4P3C7HPfI4nUUiw7IL2KoAr8XePgNZsK4XE/rg7
         SY9CQ6mzGFvHx+tWRNHHiiH40FGDPXGFvJeQY=
Received: by 10.210.67.4 with SMTP id p4mr6380168eba.77.1214991898739;
        Wed, 02 Jul 2008 02:44:58 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.250.156])
        by mx.google.com with ESMTPS id d24sm13961038nfh.2.2008.07.02.02.44.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Jul 2008 02:44:57 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080702032155.GA13581@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87126>

On Wed, 2 July 2008, Jeff King wrote:
>
> Glancing over Junio's comments, though, it might make sense to
> integrate this more tightly with git-bundle, in which case the perl
> stuff would go away. So I'll let you work out with him which is the
> best route.

Well, there is one situation where either separate git-bases program
(which is a good start; it can be named git-bundle--bases; there are
some precedents for that ;-)), or allowing to create 'bases' file
without creating bundle would be good to have.  Namely situation
where two computers are _sometimes off-line (disconnected)_.  If you
want to transfer new commits from machine B to machine A, you would
generate 'bases' file on machine A, then transfer this file using some
off-line medium, then generate bundle on machine B using those bases,
etc.

-- 
Jakub Narebski
Poland
