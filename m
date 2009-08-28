From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Round-down years in "years+months" relative date view
Date: Fri, 28 Aug 2009 20:42:21 +0200
Message-ID: <81b0412b0908281142v7e1b73ddvb727abe915dace86@mail.gmail.com>
References: <4A97193A.8090502@facebook.com>
	 <20090828060538.GA22416@coredump.intra.peff.net>
	 <81b0412b0908280058i364bfb83nb04354d982abc053@mail.gmail.com>
	 <20090828150212.GA6013@coredump.intra.peff.net>
	 <alpine.LFD.2.00.0908281307510.6044@xanadu.home>
	 <20090828180158.GA6940@coredump.intra.peff.net>
	 <81b0412b0908281127h2c444770g411ceaf052952899@mail.gmail.com>
	 <20090828183958.GA11488@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nicolas Pitre <nico@cam.org>, David Reiss <dreiss@facebook.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 28 20:42:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh6P9-0002mK-1c
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 20:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072AbZH1SmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 14:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752032AbZH1SmV
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 14:42:21 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:48289 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020AbZH1SmU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 14:42:20 -0400
Received: by bwz19 with SMTP id 19so1767432bwz.37
        for <git@vger.kernel.org>; Fri, 28 Aug 2009 11:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=VRL9LG3bi7P/jvy1fMhm+clHER3TGNhyuW4gZuAigs4=;
        b=OfeMv/BgCrpNYajVbxv0lEMPIpxGebmO1huVVYY0y2DS+QKbQrBId4uMWXmVu9pw5k
         mzN19GRt+h+cUdzBMYqUO+Kk5pEW+WbdfKftG8/cznLOl+0NpgeU5tYe3RMwGSSE4OsU
         mivP0JBnPj544udTk1WPCV2LYN5WCvsG+yONc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=KJu6+CDWckv1Dw9QdKH3whYAvL2rEeE5BBuJSR5FWuwNzv8Juicx9oVzhaKbPjv9+b
         dW/5+LiKj0UGOUTMz5PVRPZzHS+1G5fZuHaOFNWUKRhzoK5k/eWJgZheUUaL6I9WXOsK
         Lmg0voQ7fTGZi7kuryiaQ558F46I/TmIaxzes=
Received: by 10.204.34.197 with SMTP id m5mr1211245bkd.106.1251484941213; Fri, 
	28 Aug 2009 11:42:21 -0700 (PDT)
In-Reply-To: <20090828183958.GA11488@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127325>

On Fri, Aug 28, 2009 at 20:39, Jeff King<peff@peff.net> wrote:
> On Fri, Aug 28, 2009 at 08:27:06PM +0200, Alex Riesen wrote:
>
>> > Thanks, that is a much better solution. And I don't know offhand of any
>> > portability problems in overriding the library at link time.
>>
>> Microsoft's compiler and libraries? MacOSX?
>
> Are you saying you know those to be platforms with problems, or are you
> asking whether those platforms will have problems?

Both: MS never had weak/vague linkage, but I don't know about MacOSX.
I suspect them to have the same deficiency, but I'd be glad to be wrong.
