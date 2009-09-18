From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: Add compiled date to git --version output?
Date: Fri, 18 Sep 2009 14:04:28 +0800
Message-ID: <544dda350909172304i2d603719ra44bef520389f024@mail.gmail.com>
References: <544dda350909172117r44761577m11e7d30a1a5d0c91@mail.gmail.com>
	 <7v8wgchmcc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 18 08:04:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoWaC-0002VU-GI
	for gcvg-git-2@lo.gmane.org; Fri, 18 Sep 2009 08:04:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbZIRGE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2009 02:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbZIRGE0
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Sep 2009 02:04:26 -0400
Received: from mail-px0-f194.google.com ([209.85.216.194]:46376 "EHLO
	mail-px0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbZIRGEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2009 02:04:25 -0400
Received: by pxi32 with SMTP id 32so557756pxi.4
        for <git@vger.kernel.org>; Thu, 17 Sep 2009 23:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type;
        bh=NqZQuCm7RyST/ij+4h5DWLybyrpFH4uVn63q7uMyPDQ=;
        b=RiSLcPBnXD07LN1cusqpH5K1HJp4U8YnvWmnUeZlwjlwDkiwBvbg0FKZfagXUsReOr
         7WSyvmFW73qgFSlqi57JyY/eHe+pB/Tcj7P7oW92isrlvLoRBAURg8iI/3zVlPd/cpvh
         JfjqbVqk0SiQqB/MaXbgQFNEZAKFmqcTJL7NU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=XbUXAf2Gdrbs6ZbZa3t54DvAmf1pLsrAVFIH6n47HuY0e/WH8A5zmIdWcNAJe2zOYi
         zGa5gEhqoxoWBAcmhstq3jXCoJ6omnGen0+imdsS3Dj7pkGy9zGXpTZxIq1V6tykkCr4
         dAesdgSf6NI9M4/fO7KCfYCbSiXjI1grFDshE=
Received: by 10.114.54.8 with SMTP id c8mr1738088waa.204.1253253868964; Thu, 
	17 Sep 2009 23:04:28 -0700 (PDT)
In-Reply-To: <7v8wgchmcc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128785>

Thanks for the input guys, I've come to the conclusion that the extra
effort needed to properly implement this is not worth the benefit of
the outcome.

As some of you mentioned, ls -l `which git` is better suited for the
purpose, and that can be done universally for all files where the
filesystem stores the create timestamp of each.

nazri.
