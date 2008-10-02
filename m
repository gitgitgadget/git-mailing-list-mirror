From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv4] gitweb: PATH_INFO support improvements
Date: Thu, 2 Oct 2008 12:16:10 +0200
Message-ID: <200810021216.10544.jnareb@gmail.com>
References: <1222906234-8182-1-git-send-email-giuseppe.bilotta@gmail.com> <200810021019.27383.jnareb@gmail.com> <cb7bb73a0810020149l4722be08p52be3b4703be0e41@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 12:17:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlLFS-0007VX-Bw
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 12:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343AbYJBKQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 06:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753316AbYJBKQR
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 06:16:17 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:13611 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753152AbYJBKQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 06:16:16 -0400
Received: by ey-out-2122.google.com with SMTP id 6so336964eyi.37
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 03:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=vD8KJjKMk7otQRq6LiZU/hr5lKYoxFtYdSWNnGJLznE=;
        b=YaO4bhDbo4AwBTN+7ncAjTxPCGoZvkJkGeAv8D2Ubc+0cQ0wV2qjzHRCKJtK5QIT5P
         2gVHQFWRH57FHXLkuH19tXWTe424Chpfy2VYXGgkWXTy+NjJ4q3X9jXweceEEiDrUfRK
         r1ml2hC2kZJi3I2yVUsL9G6zZ1BLmGakFwFXc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=UdaLPkaFs3mfVIymTreSK2A22TBzynVaoqxyHzcXgV6dpCcQdfWs4jO6YPFJinQs74
         /6042yLXs+rOLiiA+4zJzxkdaCQvAgmbF/9CW+/qbbUE3HKa0Oi4g4yc3X2EZ2p8bJz8
         UIqtdVDO3oqnDJjhIiGoiH/wiig4Yce2503AQ=
Received: by 10.210.121.8 with SMTP id t8mr11143865ebc.181.1222942574569;
        Thu, 02 Oct 2008 03:16:14 -0700 (PDT)
Received: from ?192.168.1.11? (abwk221.neoplus.adsl.tpnet.pl [83.8.234.221])
        by mx.google.com with ESMTPS id c22sm1639963ika.1.2008.10.02.03.16.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Oct 2008 03:16:13 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0810020149l4722be08p52be3b4703be0e41@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97309>

Giuseppe Bilotta wrote:
> On Thu, Oct 2, 2008 at 10:19 AM, Jakub Narebski wrote:

> >
> > A nit: when sending longer patch series you should use numbered
> > format in the form of [PATCH m/n] or [PATCH m/n vX] prefix.
> 
> W00t, I still manage to get this wrong. Kudos to me 8-/
> 
> I wonder why these options are not the default when there is more than
> one patch, btw?
> 
> (And yes, I tried looking into the builtin-log.c code but making it
> automatic is somewhat less trivial than I can dedicate time to.)

Hmmm... I thought that format.numbered config variable is 'auto' by
default; I guess it isn't (just so you know where to look to change
it ;-)).

I have the following in the .git/config / ~/.gitconfig:

  [format]
          numbered = auto
          suffix = .txt

-- 
Jakub Narebski
Poland
