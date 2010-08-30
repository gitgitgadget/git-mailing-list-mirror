From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 12/13] git-remote-testgit: only push for non-local
 repositories
Date: Sun, 29 Aug 2010 21:09:40 -0500
Message-ID: <20100830020940.GI2305@burratino>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
 <1283053540-27042-13-git-send-email-srabbelier@gmail.com>
 <20100830014821.GF2305@burratino>
 <AANLkTimf1S_1Y=E+3bCv6CgoChrxY3gT32crwDGdhbeN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 04:11:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OptqL-00036P-9O
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 04:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754566Ab0H3CLZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Aug 2010 22:11:25 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38926 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754203Ab0H3CLY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Aug 2010 22:11:24 -0400
Received: by ywh1 with SMTP id 1so1490531ywh.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 19:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Y8X1q0m4tZJmLTI8ERoLI03Q7ORl+u87SONHEmREr3M=;
        b=VhupyaYbnDJ/bl7PSGTFM6EJK99I08HF2qydOqW8aQP0fc5cUu/OkTTQ2rsD55xpZ3
         ggLV7IQyGNtjPbIpOSMVq3ZDKK5Kg89TkvOiJZnU4KsH4Zm6jEk0RMLYZqYi8ha/O/r1
         h3x9SCEGtTzt9zD5SHe4H7Wv08BwNOCvZyHNY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=st0nkQYX99uOQs3VXtVtLIunsOV13dqOujS+T8IOARlcy96tZS2Bz6nJXLt4X2PbNW
         IBhAWnbpVlr8LsKTuxK79jKAaFvYw9+YVqg3e8XWD8EaNzz45uPKRewJE97Y0RyXFiIm
         +pdGZ6L2SDahdYU74FKfcUFcCe62F4O6zg/nY=
Received: by 10.100.196.19 with SMTP id t19mr3739266anf.209.1283134283552;
        Sun, 29 Aug 2010 19:11:23 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id t30sm11688886ann.7.2010.08.29.19.11.22
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 29 Aug 2010 19:11:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimf1S_1Y=E+3bCv6CgoChrxY3gT32crwDGdhbeN@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154750>

Sverre Rabbelier wrote:
> On Sun, Aug 29, 2010 at 20:48, Jonathan Nieder <jrnieder@gmail.com> w=
rote:

>> or why we would
>> not want to do the equivalent of
>>
>> =C2=A0git push . refs/testgit/origin/refs/heads/master:refs/heads/ma=
ster
>
> That isn't needed since the importer has already done that.

Got it.  Thanks for the explanation.
