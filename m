From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t7606: Avoid using head as a file name
Date: Mon, 23 Aug 2010 15:27:37 -0500
Message-ID: <20100823202737.GC2120@burratino>
References: <1282594547-78944-1-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Mon Aug 23 22:32:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ondgp-0001zA-OC
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 22:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754693Ab0HWU3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 16:29:22 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45590 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754120Ab0HWU3S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 16:29:18 -0400
Received: by iwn5 with SMTP id 5so3814252iwn.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 13:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=28BNBcH+Ms5IHqljq0oqMvJMHZw8esbsDLGPvP4h+7E=;
        b=Fhe/iqTf+lxVUA5W3CqTXYcF2IB7853m5FS4doqcqdotjLCHCyXh/ltzEoIhxYbv6H
         w6E68P7L8wh8gE8iQ7mGj5fp77VvzM0Ghn8kJ0L6Tswetgkox2kpAP6RueqhjE6MEC1c
         ag6tt3/u0eizMZOGMLZ2SJjr80a2U/XmPGGJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ATucOMSLB/g5x5BuTtHwfd92Vhy+HFe3z1+2z57WwhT+3BW82tB3QKX2wn2CQ6tbF+
         YEG3DdwLtwRGnEGmrOqoDp2LS4q79oe11W/Y9OFwal40nzpckg3jCqCXVp8eZYv0SPLH
         wRbzWezXsnIqzf7CmUVtb3zHyFuVbHJhClzpI=
Received: by 10.231.31.7 with SMTP id w7mr7183124ibc.83.1282595357248;
        Mon, 23 Aug 2010 13:29:17 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id e8sm6508389ibb.8.2010.08.23.13.29.16
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 23 Aug 2010 13:29:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1282594547-78944-1-git-send-email-brian@gernhardtsoftware.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154254>

Brian Gernhardt wrote:

> A file named 'head' gets confused with the HEAD ref on
> case-insensitive file systems.  Replace '>head' with '>head.new' to
> match the '>head.old' files they are compared to.

Ok.  (Thanks for the catch.)

Acked-by: Jonathan Nieder <jrnieder@gmail.com>
