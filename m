From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Creating objects manually and repack
Date: Sat, 5 Aug 2006 16:15:00 +1200
Message-ID: <46a038f90608042115m71adc8ffo77de7940efa847a8@mail.gmail.com>
References: <9e4733910608032043u689f431rc5408c6d89398142@mail.gmail.com>
	 <9e4733910608032124o5b5b69b5hda2eb8cb1e0ac959@mail.gmail.com>
	 <Pine.LNX.4.64.0608032138330.4168@g5.osdl.org>
	 <Pine.LNX.4.64.0608032150510.4168@g5.osdl.org>
	 <9e4733910608040740x23a8b0cs3bc276ef9e6fb8f7@mail.gmail.com>
	 <9e4733910608040750g3f72c07ct43f54347e47f25b4@mail.gmail.com>
	 <Pine.LNX.4.64.0608040818270.5167@g5.osdl.org>
	 <9e4733910608040841v7f4f27efra63e5ead2656e07@mail.gmail.com>
	 <Pine.LNX.4.64.0608040945070.5167@g5.osdl.org>
	 <9e4733910608041017v235da03ocd3eeeb0ba0e259b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@osdl.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 05 06:15:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9DZD-0007RV-28
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 06:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422724AbWHEEPE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 00:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422729AbWHEEPE
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 00:15:04 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:51380 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422724AbWHEEPC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 00:15:02 -0400
Received: by nf-out-0910.google.com with SMTP id k26so104994nfc
        for <git@vger.kernel.org>; Fri, 04 Aug 2006 21:15:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n13oOkhGXQUy5ng/B35Rek/Scn7kMRpsyqvrQ2pYekBEInY6nCF0VM1nRUR6K4xVQUKM5iXyJdKvJYdA2GhLizmVIa1QNw969iIFqpK5WgEMRY0YZ1FWx9nUmJdCGRa0lJmbpmQR4E62sguObiYlnygJ1kJtON9762OIaU91K9M=
Received: by 10.78.183.8 with SMTP id g8mr1810247huf;
        Fri, 04 Aug 2006 21:15:01 -0700 (PDT)
Received: by 10.78.97.17 with HTTP; Fri, 4 Aug 2006 21:15:00 -0700 (PDT)
To: "Jon Smirl" <jonsmirl@gmail.com>
In-Reply-To: <9e4733910608041017v235da03ocd3eeeb0ba0e259b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24880>

On 8/5/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 8/4/06, Linus Torvalds <torvalds@osdl.org> wrote:
> > and you're basically all done. The above would turn each *,v file into a
> > *-<sha>.pack/*-<sha>.idx file pair, so you'd have exactly as many
> > pack-files as you have *,v files.
>
> I'll end up with 110,000 pack files.

Then just do it every 100 files, and you'll only have 1,100 pack
files, and it'll be fine.

> I suspect when I run repack over
> that it is going to take 24hrs or more,

Probably, but only the initial import has to incur that huge cost.

cheers,



martin
