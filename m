From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/4] fmt-merge-msg: Update fmt-merge-msg and
 merge-config documentation
Date: Fri, 20 Aug 2010 18:42:21 +0530
Message-ID: <20100820131218.GC9448@kytes>
References: <1282307041-19681-1-git-send-email-artagnon@gmail.com>
 <1282307041-19681-4-git-send-email-artagnon@gmail.com>
 <20100820123935.GB9448@kytes>
 <4C6E78CB.1090907@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Yaroslav Halchenko <debian@onerussian.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Aug 20 15:14:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmRQX-0003wI-GQ
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 15:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045Ab0HTNOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 09:14:15 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42150 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035Ab0HTNON (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 09:14:13 -0400
Received: by pwi7 with SMTP id 7so1011646pwi.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 06:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Pe8WQkTzftAWntqnZTDpX554zYTBiPU3qfG4P0q1TzI=;
        b=s08VLwXkdwf10snbDZ4chuZVoBu7g7a5Mc0HDyJkLOhTihRE883n558KiNcSeuY5gj
         +I/EA3LOZuZ2V3EtYnSUJDun8PpuzftOWCwncNIxjcqd3Ex4ceAtFp6vRGLAmXtmHUdW
         9VCGFIcHDzTKm/nGP1fJ4K99ly8a1RS1vTBFM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=OVIEnnWXKSlwociqjavlzwTaPIBqos3H/hZ4l7aV4MgnKzmVBCk3N1F1gLcnRq3q6Y
         LSAJ1HJE1oPlK2772Vd1Bu7Vfz+zALNM1FMtuzwMKpmbf+OK+tGuNxL2J8amxTPo2WDv
         27MJp+deG8lG8AGTcc9TgiJfvhkeHHdMnLd4s=
Received: by 10.142.134.15 with SMTP id h15mr1099201wfd.69.1282310053372;
        Fri, 20 Aug 2010 06:14:13 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id n2sm3236554wfl.1.2010.08.20.06.14.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 06:14:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C6E78CB.1090907@viscovery.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154032>

Hi,

Johannes Sixt writes:
> Am 8/20/2010 14:39, schrieb Ramkumar Ramachandra:
> > Minor mistake: This patch removes the --summary option from the
> > documentation before removing it from the code.
> 
> Not only that: It also removes --no-log, and makes the argument to --log
> mandatory, doesn't it?

Yeah, that was sort of intended- Is this undesired?

I noticed that the command-line parsing framework has only OPT_BOOLEAN
and OPT_INTEGER, but no OPT_BOOLEAN_OR_INTEGER.

-- Ram
