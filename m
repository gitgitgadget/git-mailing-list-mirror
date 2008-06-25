From: "Erez Zilber" <erezzi.list@gmail.com>
Subject: Re: git-clone works with ssh but not with http/https/git
Date: Wed, 25 Jun 2008 09:56:04 +0300
Message-ID: <ce513bcc0806242356x5fd5ec85tfaa1b1b1996feac5@mail.gmail.com>
References: <ce513bcc0806240415h669d1725uf7b6e495995ab459@mail.gmail.com>
	 <1214306517.6441.10.camel@localhost>
	 <ce513bcc0806240445x6d00323g303f218504d2df53@mail.gmail.com>
	 <A3460448-8007-4E02-AC20-85C1A8C85786@manchester.ac.uk>
	 <ce513bcc0806240653i45044297t3b963940c5b3daf0@mail.gmail.com>
	 <BC8F2A2A-9817-401B-BAC3-F36ED42976E5@manchester.ac.uk>
	 <ce513bcc0806240745l365b2d22ga007deb01a93e4b6@mail.gmail.com>
	 <alpine.LNX.1.00.0806241305150.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Robert Haines" <rhaines@manchester.ac.uk>,
	"Matthias Kestenholz" <mk@spinlock.ch>, git@vger.kernel.org
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jun 25 08:57:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBOwE-0008CK-IS
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 08:57:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754AbYFYG4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 02:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751744AbYFYG4G
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 02:56:06 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:53120 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692AbYFYG4F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 02:56:05 -0400
Received: by rv-out-0506.google.com with SMTP id k40so8049939rvb.1
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 23:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Hf/tv/EwOR3SLcIcxf0D8YdxNA5VhhOTAtdEssinAI4=;
        b=K2w1zdB1AiOmEpXph6m3MVsuR6ZIzuCCfR0vWH++7heJfWScX819y/jkULu7E4hLgM
         VSlbGJO/z6peViX6kDYRB8lifYcypjVC1d7deThoMvRkEPokpzq1v/bqMyzQI1e31tzM
         1d0ydjoVpk66wD+mDoahpJMDNHdP8KSB+Wr6g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=c+ixBb48YbtXHvVGTVHywJWg06zutsIHI5Dj9lZACZXiOMmPk+ERkBqyxIazNvindn
         D7BHDj64n3Uov99s8F9BQJOaEId20FUYVTCL2sXyo2rdfuxuJl5m3SsAHozE0KjpdUjM
         FtoeGaN7QgS0D6YHja3tjbCLkn2zbX+2YTRTI=
Received: by 10.140.131.7 with SMTP id e7mr15940888rvd.261.1214376964956;
        Tue, 24 Jun 2008 23:56:04 -0700 (PDT)
Received: by 10.141.195.7 with HTTP; Tue, 24 Jun 2008 23:56:04 -0700 (PDT)
In-Reply-To: <alpine.LNX.1.00.0806241305150.19665@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86246>

On Tue, Jun 24, 2008 at 8:10 PM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Tue, 24 Jun 2008, Erez Zilber wrote:
>
>> BTW - I'm currently running git-daemon in the following way:
>>
>> sudo git-daemon --base-path=/pub/git/ --export-all
>>
>> Is there any advantage to run it through xinetd? How do you run it?
>
> You probably want to run it from something that init runs, or you'll have
> to figure it out again when you reboot the server in a while. So you
> either want a suitable init script (Gentoo, for example, has one in their
> git package), or to run it through xinetd (which you almost certainly have
> an init script for).
>
>        -Daniel
> *This .sig left intentionally blank*
>

Thanks. I was able to config xinetd, and everything seems to work now.
I would like to thank everyone here for the quick and very useful
help.

Erez
