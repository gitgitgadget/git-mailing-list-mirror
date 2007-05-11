From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to set git commit timestamp
Date: Fri, 11 May 2007 12:58:34 +0200
Message-ID: <200705111258.35050.jnareb@gmail.com>
References: <Pine.LNX.4.64.0705061759210.8165@bianca.dialin.t-online.de> <20070508015702.GE11311@spearce.org> <Pine.LNX.4.64.0705081328420.4167@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 11 13:26:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmTGG-0003oZ-M9
	for gcvg-git@gmane.org; Fri, 11 May 2007 13:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757041AbXEKL0G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 07:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757248AbXEKL0G
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 07:26:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:29297 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757041AbXEKL0F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 07:26:05 -0400
Received: by ug-out-1314.google.com with SMTP id 44so797637uga
        for <git@vger.kernel.org>; Fri, 11 May 2007 04:26:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=eYI3gTZUrC4RugO4Jh2byXmeVWrrd1f4R8IsXMSbtB+KfWkzLKAu5EpZKcN1EspEfNIOs14f5mjVBsEP3FT0fC/yFiJJGVK3EjsSTNWPygAtb0WwtNqn26TtUNt7hFxxQxL2A6A7nK1KjK9S2hX5LmyQ3/erKUtFm02morQzw5o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fckDNVmVmzjmM3ONuyVEQwMj5Ek2RD8XKqoU0mdoBMzUU39Qvq9EHPEJZaxVZZcSOYZvFu1PakEeHjDVmJjvc2VHFSIkgfKPf45arEE8Dxc4Dwv2S605M9yy3JsxJygHvcz7/Pup7CEwiBLJQOqDflkNkke+LIzeRyNnWmS6Hms=
Received: by 10.66.221.19 with SMTP id t19mr2812884ugg.1178882764192;
        Fri, 11 May 2007 04:26:04 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id p32sm5916251ugc.2007.05.11.04.26.02;
        Fri, 11 May 2007 04:26:03 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0705081328420.4167@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46952>

On Tue, 8 May 2007, Johannes Schindelin wrote: 
> On Mon, 7 May 2007, Shawn O. Pearce wrote:
>> Jakub Narebski <jnareb@gmail.com> wrote:

>>> By the way, is there fast-import version of git-quiltimport?
>> 
>> No, and I don't think its easy.  Isn't a quilt patchstack stored as a 
>> series of patch files?  So "importing" it into Git requires applying the 
>> patch to the base tree, then writing that base tree to the ODB.  
>> fast-import doesn't know how to run git-apply, though Junio and I did 
>> kick it around (generally) a few months ago on #git.
> 
> You'd have to pretend that all of these patches are branches. Well, in the 
> end they are...

Or rather that patch _series_ are branches. 

It would be also nice to have one of the patch management UI on top of git
like StGIT or Guilt (IIRC pg is no longer maintained) to import series
of patches as unapplied from Quilt (or from mbox/file).

-- 
Jakub Narebski
Poland
