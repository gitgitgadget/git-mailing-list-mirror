From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Clarification for the command "git checkout <branch>"
Date: Wed, 31 Mar 2010 09:28:20 +0530
Message-ID: <p2nf3271551003302058ve6b54731h1bea42b5c6605928@mail.gmail.com>
References: <4B67227A.7030908@web.de> <4BA104C7.5020207@web.de> 
	<32541b131003170944w7a0215frcace205f32d313bf@mail.gmail.com> 
	<7vaau6q18q.fsf@alter.siamese.dyndns.org> <4BA1FC39.10300@web.de> 
	<32541b131003180936x746dad06k386788d3cb6fcdeb@mail.gmail.com> 
	<b4087cc51003181019r4408953bxcd5049c9521b8173@mail.gmail.com> 
	<4BA3329E.6050304@web.de> <4BB21F6D.7070804@web.de> <7vd3ylv4oq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Markus Elfring <Markus.Elfring@web.de>,
	Michael Witten <mfwitten@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 31 05:59:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwp51-0007s6-6D
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 05:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755958Ab0CaD6n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Mar 2010 23:58:43 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52237 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755570Ab0CaD6m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Mar 2010 23:58:42 -0400
Received: by pwi5 with SMTP id 5so8429883pwi.19
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 20:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=NLu36LzUQe/UV58PolThij49aaR5LbiYxNetbJ0hsCM=;
        b=Zdrkjn225MPF1mSHELlz7rZuRzm1fliTjsSYVNZzwt77M3nLTRspYq457HFxSeTQYH
         FJ6xNyjtff5xMxGcQuAt53TpJpPPMU8Y3Ea+9adG5V/yIk1eoIoEADM3FcNnLXaulrQq
         3Jw6I/XAK2pevshdL0hS23Q8LVgZxflFzVN68=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=KznCDwpiOZJ57h6xyw1WawfWLNegLzCyBiU2rrSywXKxlSVlIANjSFMuLkQ1BYqp+Y
         260+Nhl4moQrsSZMWsGSmIATuIiLpv5J12BpOEZXC9cSuSDIiQT7Top8a9rQrm9JZAcy
         +xUDQ1KpqOAjk/SNf5zb8q7g+mWpTbb3hXi3A=
Received: by 10.142.109.19 with HTTP; Tue, 30 Mar 2010 20:58:20 -0700 (PDT)
In-Reply-To: <7vd3ylv4oq.fsf@alter.siamese.dyndns.org>
Received: by 10.142.208.2 with SMTP id f2mr2236409wfg.208.1270007920670; Tue, 
	30 Mar 2010 20:58:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143644>

Hi,

On Wed, Mar 31, 2010 at 3:43 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> +such a case, you may want retry the command after recording the loca=
l
> +changes (1) in a temporary commit on the current branch, or (2) by u=
sing
> +"git stash". =A0Alternatively, use "-m" option to force a merge.

Couple of things: Is (1) really an option? The user will have to go
through documentation on rewriting history, which I find completely
unnecessary to just switch branches. Second, you might want to mention
a "git stash apply" and include a reference to git-stash
documentation.

-- Ram
