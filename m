From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: RFH: is the current file available to a custom merge driver?
Date: Tue, 31 Aug 2010 13:57:08 -0500
Message-ID: <20100831185708.GS2315@burratino>
References: <4C7D4F63.2060307@nextest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Eric Raible <raible@nextest.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 20:59:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqW35-0006ws-7Q
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 20:59:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209Ab0HaS7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 14:59:05 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:34779 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720Ab0HaS7E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 14:59:04 -0400
Received: by wwb39 with SMTP id 39so37930wwb.1
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 11:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ftsh1KPk+BVgyPcto3rdnGzGQrGz3UjDkdRq+9/yZt8=;
        b=CdwyC7GfcJdIb9C/etDRHNCVxoRhjYN8WFM2QplrSQHTFKYn5GWQqdkLdGrukoHyex
         ujMgyggoi+UF9MFh/zwVP5HR6akJmaaJdbiw8pr2x+2VQGTPA42ODwngapwmPOcWg53R
         QK6EUdTXQerl39b8T8fbOAwUrjG43wKevSYR4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=XP3cDlhUCGjNmT2DoBr+nzo5Wn0MINzaAdOf8opU57XeWlqArs9eznEeosgmYnodkr
         +0TB4MeK5K6zoKoyqLUYo9Ob88ajR9nR+Q8zOWwyM1iLLgvsNMH+C+hH+8NLbwOLwDmb
         tl0Fq6p4W1OmkrBOCPNFGotKZFDlYIzK+IsUs=
Received: by 10.227.44.6 with SMTP id y6mr6003637wbe.17.1283281139168;
        Tue, 31 Aug 2010 11:58:59 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id n40sm5515867weq.29.2010.08.31.11.58.57
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 11:58:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C7D4F63.2060307@nextest.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154964>

Hi Eric,

Eric Raible wrote:

> In writing a custom merge driver to support $dayjob
> requirements I've failed to find a simple way of getting
> the current file name that the driver is supposed to
> be merging.
> 
> I of course have the "ancestor", "ours", and "theirs"
> temporary files, but for Ui purposes I'd like to know
> the filename as well.

It's not available.  You can try modifying ll-merge.c to
expose it if you have an idea about how that should work.
