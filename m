From: Jared Hance <jaredhance@gmail.com>
Subject: Re: [PATCH/RFC v4 0/2] Add -e/--exclude to git clean.
Date: Tue, 20 Jul 2010 15:11:31 -0400
Message-ID: <20100720191131.GA2688@localhost.localdomain>
References: <e257dd98b7493dcd72de9cf62d5847116e030ed0.1279564639.git.jaredhance@gmail.com>
 <cover.1279643093.git.jaredhance@gmail.com>
 <AANLkTinzavHKSVs4BYGtc-T1IKAS21yk-yzybn7G7IaZ@mail.gmail.com>
 <7vaapmm3ow.fsf@alter.siamese.dyndns.org>
 <7v630am2qt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 20 21:11:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObIED-00050j-LA
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 21:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512Ab0GTTLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 15:11:40 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:59816 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755201Ab0GTTLj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 15:11:39 -0400
Received: by gwj18 with SMTP id 18so2899267gwj.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 12:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=fONjidpTfNp4Uls+FLT2j3G5UK9Xbn5KpY3W8w1toew=;
        b=uILfjwosG/0bNeR+YJeyjp1BloC33f+lsJHdRIkWKyf8+zGmIEpnJHbgHhlM5M5z5Q
         GMuLeg/gxS3LZeIxigCWjwo+cIdU/Gsm1EhiorM5OCDlVIx2KIuXLAC5bdBIvno3sXga
         SzMb3/EUybLdsO9nY/S5Aosos9tMDz6nuWtds=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FuMGxeyrqJ07PB+sCwLYdZcu5WKCzltNywCrr0BH/UzGl1l4ws0758mrc5F4HDtVoI
         UrK0kRBYpVALXo+u5bm/3NjxcedObGyytASl8mkjeBrYqpMMuTuUBCbd5K5HjfN8pfG0
         VHEuj43SfSP6x+5rPxADZDqVuzRc+nClC1p5o=
Received: by 10.224.60.133 with SMTP id p5mr6249390qah.323.1279653096555;
        Tue, 20 Jul 2010 12:11:36 -0700 (PDT)
Received: from localhost.localdomain (cpe-75-186-1-50.cinci.res.rr.com [75.186.1.50])
        by mx.google.com with ESMTPS id h34sm28320893qcm.2.2010.07.20.12.11.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 20 Jul 2010 12:11:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v630am2qt.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151352>

On Tue, Jul 20, 2010 at 11:23:22AM -0700, Junio C Hamano wrote:
> The fix-up should look something like this, on top of your patch.
> 
> Note that I did this on top of applying your patch to 'maint', and you may
> need to adjust the parameter order of string-list functions if you want to
> forward port it to 'master'.
> 
> Untested, of course ;-)

Okay. Do you want to me to create a rebased version to combine this
and my first patch?
