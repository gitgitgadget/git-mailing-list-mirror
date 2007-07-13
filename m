From: "David Frech" <nimblemachines@gmail.com>
Subject: Re: sharing between local "work" and "nightly build" git repos
Date: Thu, 12 Jul 2007 17:33:19 -0700
Message-ID: <7154c5c60707121733r6584a407r8d60d5890b9c89e2@mail.gmail.com>
References: <7154c5c60707121636l585b42d4l931b08f1468ddfc@mail.gmail.com>
	 <7vmyy1rwza.fsf@assigned-by-dhcp.cox.net>
	 <7154c5c60707121727k36854891u82afc4a8be822861@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 13 02:33:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I996C-0001jP-9g
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 02:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758324AbXGMAdU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 20:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757975AbXGMAdU
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 20:33:20 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:51933 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756440AbXGMAdT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 20:33:19 -0400
Received: by wa-out-1112.google.com with SMTP id v27so391566wah
        for <git@vger.kernel.org>; Thu, 12 Jul 2007 17:33:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qbsFt28zaHIbANdnnKUVenuBoRIQnEbIoEQstrKMAHEEfK/J1xNbSNKr5IUWsXEDQeLbcXUWGuu105CpB5Nq69I8fCXYzZfFbUUqutukfnwh0pb3YEawcnu+7hiOeD2JYzKER8MO8SX3Ze5DHk/zG6L+kj77kHmW2zuYoh+G37E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tdNS04oKN8W3ey1JmdSZgkaNX/kd8SNR2lILx6RiSp9ULQu/uolTtwTNQx4n2BYzEVTEHizIBMjqE9HD72PftO9faOmhx/66Du/EzEImOv42AbOnoedC9JRkWyjeREV0UFI+4oHM9gu2pxZhnYIH6ZrnE336Daxd8ts0zYS2iSs=
Received: by 10.114.169.2 with SMTP id r2mr1123010wae.1184286799247;
        Thu, 12 Jul 2007 17:33:19 -0700 (PDT)
Received: by 10.115.59.9 with HTTP; Thu, 12 Jul 2007 17:33:19 -0700 (PDT)
In-Reply-To: <7154c5c60707121727k36854891u82afc4a8be822861@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52350>

On 7/12/07, David Frech <nimblemachines@gmail.com> wrote:
> On 7/12/07, Junio C Hamano <gitster@pobox.com> wrote:
> > Then a nightly update would go like this:
> >
> >  $ cd ~/nightly-git
> >  $ git pull origin next
> >  $ make clean
> >  $ make test || barf

One more thing: would it make sense to do "make -k test" so that *all*
failures (if >1) show up?

Cheers,
- David
-- 
If I have not seen farther, it is because I have stood in the
footsteps of giants.
