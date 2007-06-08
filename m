From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: [PATCH] Port git-tag.sh to C.
Date: Sat, 9 Jun 2007 00:36:38 +0200
Message-ID: <1b46aba20706081536p6511e561x9a3134b1af1cb0a@mail.gmail.com>
References: <1181338730800-git-send-email-krh@redhat.com>
	 <Pine.LNX.4.64.0706082249040.4059@racer.site>
	 <1181340320.30683.30.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "=?ISO-8859-1?Q?Kristian_H=F8gsberg?=" <krh@redhat.com>
X-From: git-owner@vger.kernel.org Sat Jun 09 00:37:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwn4l-00061j-SH
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 00:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030771AbXFHWgk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 8 Jun 2007 18:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968710AbXFHWgk
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 18:36:40 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:12198 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S969549AbXFHWgi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2007 18:36:38 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1240737wah
        for <git@vger.kernel.org>; Fri, 08 Jun 2007 15:36:38 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f/7AbtnfjqCG6yLHPjBnnK2x9lMfb8r7nHhJzbp/DKHbiZeMIV+12lcavUdcJhrhMaaFwLNY9J56+I8sS3qvy8fYoxIK+aMdf/S5rkCpkT9c7R4+p2mkLX/Q2nWjKTmumH/Xvdy33g5pgUCeav1gj4BUEC/XuGlImXbKBcti/5k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i9igOqEJvl+h/bwv26csCDyn9wPG4znPrzcvYkLp58WtlHLER00bhxf0jTMa5zDifgVOOQ6dhB6FgCA8FO0gm0cwRKbInC3YKKvFT0iOvdnDGWfBOxE+pCFE6lEuUe6AqHJR3V56vfqjQGnmmZm4K8qCkvyf+gxLSGpXlSnbQpE=
Received: by 10.115.61.1 with SMTP id o1mr2998564wak.1181342198212;
        Fri, 08 Jun 2007 15:36:38 -0700 (PDT)
Received: by 10.114.57.10 with HTTP; Fri, 8 Jun 2007 15:36:38 -0700 (PDT)
In-Reply-To: <1181340320.30683.30.camel@hinata.boston.redhat.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49515>

2007/6/9, Kristian H=F8gsberg <krh@redhat.com>:
> Ugh, yeah... wasted effort...  I didn't see anything about the SoC
> project on the list and I didn't pre-announce my work because I only
> spent little more than half a day...

Sorry, it should have been announced before this could happen.

> > As it happens, I am working with jasam on exactly the same script.

We were doing a conservative work to get exactly the same options
and behaviour that git-tag.sh does. The work is now almost finished,
so you could help us comparing the two versions to see how could
end with a better git-tag. It would be fantastic if we could point what
parts of my code can be enhanced with those of yours.

My test suite can also be run against the git-tag.sh code now, you
can check check your code with it. Feel free to say everything you want
about it!

Carlos
