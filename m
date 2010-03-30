From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v7 1/2] Documentation/remote-helpers: Rewrite description
Date: Tue, 30 Mar 2010 08:53:57 +0530
Message-ID: <f3271551003292023v296f8d7q32ccc151ee246207@mail.gmail.com>
References: <f3271551003281103x68812b3cj806d6235965f0a32@mail.gmail.com> 
	<4BAFFFAB.4080808@gmail.com> <alpine.LNX.2.00.1003290055000.14365@iabervon.org> 
	<f3271551003282318vc256d20j90bb83170b0a983@mail.gmail.com> 
	<alpine.LNX.2.00.1003291124211.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Gabriel Filion <lelutin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Mar 30 05:24:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwS3z-0002Fu-KS
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 05:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755301Ab0C3DYT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Mar 2010 23:24:19 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:51060 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754974Ab0C3DYS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Mar 2010 23:24:18 -0400
Received: by ywh2 with SMTP id 2so5473152ywh.33
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 20:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=pIFVvk0pxy/eR34P/I4Xf72DSJIJQDHjYAyzYbnOk6M=;
        b=cDQI9DC6I/LjysgFi0VjzorGTpW3ZtwsB659ZrvAXNWip3zNt6Wf+LETp73FvIuIQ3
         KP/ikFUYVx++gw34zWvbHB/I3Sc+dOds5PA4HdWMKaoWmBdT62icDyq5tMEEwSTx+uKN
         lJKPC0kz8TInNxG5BEOrDRj5dBRqx4/21dvT8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=HyIU9aMiikc6WC89PEEnmvaMUFRlEDFdvdjDnXJfm6VC8TDMzIarO0++PLjWBiPZur
         vUT2ssapBeXNkVnjPX8IG14KOQ1lWUoEPU5KS4s8smiNIPUmNtJSoZhI+lMg7mgJ5Rmw
         wjdRUWuHrOxYBoYx5pqNBxb8CxzQmYcWRlMeA=
Received: by 10.90.69.14 with HTTP; Mon, 29 Mar 2010 20:23:57 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1003291124211.14365@iabervon.org>
Received: by 10.90.57.15 with SMTP id f15mr4839992aga.107.1269919457145; Mon, 
	29 Mar 2010 20:24:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143540>

On Mon, Mar 29, 2010 at 9:09 PM, Daniel Barkalow <barkalow@iabervon.org=
> wrote:
> The current answer is this:
> =A0argv[1] is the name of a remote, which may be a nickname or some m=
ore
> =A0direct name; in any case, remote_get() will produce the available =
data
> =A0for it.
> =A0argv[2] is the URL, if there is one. Since a remote could have mor=
e than
> =A0one URL, the helper gets the URL it should be handling. Some syste=
ms
> =A0don't use URLs, and these will just look at the remote or somethin=
g like
> =A0that.

Got it. I'll prepare a patch in the evening.

-- Ram
