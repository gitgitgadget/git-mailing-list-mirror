From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/3] make --max-pack-size argument to 'git pack-object'
	count in bytes
Date: Thu, 4 Feb 2010 10:00:15 -0800
Message-ID: <20100204180015.GC18548@spearce.org>
References: <1265255308-20514-1-git-send-email-nico@fluxnic.net> <1265255308-20514-3-git-send-email-nico@fluxnic.net> <20100204040046.GR14799@spearce.org> <7v7hqtty38.fsf@alter.siamese.dyndns.org> <7vtytxexjl.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1002041243570.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Feb 04 19:01:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd60e-0006nM-Bl
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 19:00:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756653Ab0BDSA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 13:00:27 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:45133 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754892Ab0BDSAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 13:00:25 -0500
Received: by iwn39 with SMTP id 39so3236132iwn.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 10:00:24 -0800 (PST)
Received: by 10.231.145.5 with SMTP id b5mr534915ibv.70.1265306421730;
        Thu, 04 Feb 2010 10:00:21 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm272561iwn.6.2010.02.04.10.00.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Feb 2010 10:00:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1002041243570.1681@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138994>

Nicolas Pitre <nico@fluxnic.net> wrote:
> >  --max-pack-size=<n>::
> > -	Maximum size of each output packfile, expressed in MiB.
> > -	The default is 4096 (4 GiB) as that is the maximum allowed
> > +	Maximum size of each output packfile.
> > +	The default is 4 GiB as that is the maximum allowed
> >  	packfile size (due to file format limitations). Some
> >  	importers may wish to lower this, such as to ensure the
> >  	resulting packfiles fit on CDs.
> 
> What file format limitation is alluded to here?  It has been a while 
> since the 4GB limit on pack file format has been removed.

The pack index v1 32 bit offset thing.  Which you fixed.

> If this is a 
> limitation of fast-import only then maybe this should be explained more 
> explicitly.

Damn.  It is.  fast-import can't write a v2 index.  Ugh.

-- 
Shawn.
