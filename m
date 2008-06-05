From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH] Add subcommand "help" to the list of most commonly used subcommands
Date: Thu, 5 Jun 2008 13:21:04 +0200
Message-ID: <bd6139dc0806050421l3a242a98sdfa51248b380badc@mail.gmail.com>
References: <alpine.DEB.1.00.0806050747000.21190@racer>
	 <20080605081911.GA5946@mithlond.arda.local>
	 <alpine.DEB.1.00.0806051131310.21190@racer>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Teemu Likonen" <tlikonen@iki.fi>, git@vger.kernel.org,
	gitster@pobox.com
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 05 13:22:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4DXd-0008RH-JQ
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 13:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754314AbYFELVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 07:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753914AbYFELVI
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 07:21:08 -0400
Received: from el-out-1112.google.com ([209.85.162.176]:58975 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753890AbYFELVH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 07:21:07 -0400
Received: by el-out-1112.google.com with SMTP id v27so152096ele.23
        for <git@vger.kernel.org>; Thu, 05 Jun 2008 04:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=RW00lVBEV7E/kzqvHYz+LBX1S7Dr3G+yNSU21qsrPAw=;
        b=bqz96EWEI2pOimDdLnKDnMcQPGRod5TRHumoVrGwG/TbxmEbdQH3f7YSCF5nYdtu/1
         M6/3dwa/YSKaWR1xP6mzriq3miSzi5aMzB7ymBFIJApGsOBV6pxcMp0Y0B6+YPnueM9R
         uFE2fGgJTj2Q/SicTZn06MOCxeajctpVF3d9E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=s8qPtMhlFl2hS/MUTOAg5kSxjLnASmRUYhR4nRcADkiVCiaCdQwsrBIvBLJSFnZaEK
         2x4NHxxgF40o6ItcWZE3RMW/yano6E1NWN+T4FYFi00HLdaVTYLQwYqtW1aW+PGi+SuU
         XOqc1B28y0lHvK2Uz6kRB2VHwBXdir7WtK/T0=
Received: by 10.143.156.15 with SMTP id i15mr482791wfo.4.1212664864780;
        Thu, 05 Jun 2008 04:21:04 -0700 (PDT)
Received: by 10.143.41.7 with HTTP; Thu, 5 Jun 2008 04:21:04 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0806051131310.21190@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83905>

On Thu, Jun 5, 2008 at 12:32 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Thu, 5 Jun 2008, Teemu Likonen wrote:
>> Add subcommand "help" to the list of most commonly used subcommands
>
> Hrmpf.  IMO "help" is not really a _git_ command.  And I use it really,
> really rarely.

I agree with this, but not because I don't use it rarely, but because
there is no such command 'git-help'. I know that we are urging the
user away from the dash notation, but if we want to advertise 'git
help' as an actual command, at least make 'git' recognize it as an
actual command instead of displaying the default usage notice (type
'git help' and see what I mean).

-- 
Cheers,

Sverre Rabbelier
