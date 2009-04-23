From: Jarek Poplawski <jarkao2@gmail.com>
Subject: Re: htb parallelism on multi-core platforms
Date: Thu, 23 Apr 2009 22:00:42 +0200
Message-ID: <20090423200042.GD2756@ami.dom.local>
References: <20090423184319.GB2756@ami.dom.local> <Pine.LNX.4.64.0904232103390.13488@ask.diku.dk> <20090423191455.GC2756@ami.dom.local> <Pine.LNX.4.64.0904232136040.13796@ask.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Radu Rendec <radu.rendec@ines.ro>,
	Denys Fedoryschenko <denys@visp.net.lb>,
	netdev <netdev@vger.kernel.org>, git@vger.kernel.org
To: Jesper Dangaard Brouer <hawk@diku.dk>
X-From: netdev-owner@vger.kernel.org Thu Apr 23 22:03:57 2009
Return-path: <netdev-owner@vger.kernel.org>
Envelope-to: linux-netdev-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx59I-0008OV-Qx
	for linux-netdev-2@gmane.org; Thu, 23 Apr 2009 22:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992AbZDWUCU (ORCPT <rfc822;linux-netdev-2@m.gmane.org>);
	Thu, 23 Apr 2009 16:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753311AbZDWUCS
	(ORCPT <rfc822;netdev-outgoing>); Thu, 23 Apr 2009 16:02:18 -0400
Received: from mail-bw0-f163.google.com ([209.85.218.163]:55544 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119AbZDWUCR (ORCPT
	<rfc822;netdev@vger.kernel.org>); Thu, 23 Apr 2009 16:02:17 -0400
Received: by bwz7 with SMTP id 7so744892bwz.37
        for <multiple recipients>; Thu, 23 Apr 2009 13:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=z+5ArMfToaQE0OYzfsEuQCtBMSsbjSwBYFtwYWL0gbs=;
        b=ktedZ1jJtgOtHa0pkBoAFWjC1/C3o5EyLD1NhGzM9c+tD8bNPNHC18cdnqESw/XG5J
         NIj0Or7wAlAuj+KPirfZMlzVIgWNTKjCbQtilNFkPoadbzRTiViZTAYBeMdjnGUappKc
         cbICCRP+60ESGOXh75AiO8jU5CTkA71O/9b44=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=LDniJyG2TCp43tRPD7LphXlW5FWmbdxgS18gaSt9k4fUxQd5BDi8LmR6ZB8pl4PkE8
         KG/2/SvBJUzs0MKVx4nDw1EEXCEHzCOKow2H7u5FKulyGRRNr5BkRmRejN/mf/dY4TVY
         SStMCvyaoXki9K78xfqMgY/ijpsAIi/svVGRE=
Received: by 10.204.53.141 with SMTP id m13mr1291368bkg.11.1240516935314;
        Thu, 23 Apr 2009 13:02:15 -0700 (PDT)
Received: from ami.dom.local ([79.162.149.9])
        by mx.google.com with ESMTPS id 12sm622785fks.27.2009.04.23.13.02.13
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 23 Apr 2009 13:02:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0904232136040.13796@ask.diku.dk>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: netdev-owner@vger.kernel.org
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117377>

On Thu, Apr 23, 2009 at 09:47:05PM +0200, Jesper Dangaard Brouer wrote:
> On Thu, 23 Apr 2009, Jarek Poplawski wrote:
...
>> I guess git-describe, but I prefer clicking at the "raw" (X-Git-Tag):
>> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=f4c1f3e0c59be0e6566d9c00b1d8b204ffb861a2
>
> I think I prefer the command line edition "git-describe".  But it seems  
> that the two approaches gives a different results.

Probably there is something more needed around this git-describe.
I prefer the command line too when I can remember this command line...

Jarek P.
