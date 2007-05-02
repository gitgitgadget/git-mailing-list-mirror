From: "Jakub Narebski" <jnareb@gmail.com>
Subject: Re: Git benchmarks at OpenOffice.org wiki
Date: Wed, 2 May 2007 13:33:55 +0200
Message-ID: <8fe92b430705020433v7ae5c117qdefccc791cd07fff@mail.gmail.com>
References: <200705012346.14997.jnareb@gmail.com>
	 <Pine.LNX.4.64.0705020143460.4010@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, dev@tools.openoffice.org,
	"Jan Holesovsky" <kendy@suse.cz>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 02 13:34:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjD5x-0003y9-GG
	for gcvg-git@gmane.org; Wed, 02 May 2007 13:34:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755037AbXEBLeB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 07:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755054AbXEBLeA
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 07:34:00 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:3258 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755037AbXEBLeA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 07:34:00 -0400
Received: by wr-out-0506.google.com with SMTP id 76so100169wra
        for <git@vger.kernel.org>; Wed, 02 May 2007 04:33:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CxbP2ct+XVKfQLoTM8ePm86cbZl4QAyoGOxCkavvO993agIzCpV57X3Cj8OYM01LCA6NZAZO8EQvOMhDDiTn5KywIhZVvZBKw2wDDUM9MFyVcoCemtSMy7IavYL4BBuwr+kxlgFlhOlj9Fi8Mx5B+cPy/EMvPGB6IPfv1TLjSnk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MkFtZtZsJCTzd/6JfzEK52Ev0W1Y3o0Xm5MwUq9x0cWN9y1nS3Ve1Id9DUpqovXDd2wlJUGGmEpmh4NIl+gKMpSlSBLVvSRgHxm7B5mMPS6MIb3YvSV+l8SDI/rYM6p6NWTeQxzp8Ur/3yfgIRhsgZfnkFSxw0vdP0MXbIGEScM=
Received: by 10.114.75.1 with SMTP id x1mr188849waa.1178105635744;
        Wed, 02 May 2007 04:33:55 -0700 (PDT)
Received: by 10.114.201.14 with HTTP; Wed, 2 May 2007 04:33:55 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0705020143460.4010@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46014>

Hi!

On 5/2/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Tue, 1 May 2007, Jakub Narebski wrote:
>
> > 'Checkout time' (which should be renamed to 'Initial checkout time'),
> > in which git also loses with 130 minutes (Linux, 2MBit DSL) [from
> > go-oo.org], 100min (Linux, 2MBit DSL, Wireless, no proxy) [from
> > go-oo.org] versus 117 minutes (Linux, 2MBit DSL), 26 minutes (Linux,
> > 2MBit DSL, with compression (-z 6)) for CVS, and  60 Minutes (Windows,
> > 34Mbit Line) for Subversion, would also be helped by the above.
>
> FWIW I can confirm the number "100min".
>
> Something I realized with pain is that the refs/ directory is 24MB big.
> Yep. Really. They have 3464 heads and 2639 tags. I suspect that this is
> the reason why.

Then packed refs would certainly help with speed and a bit with size.

-- 
Jakub Narebski
