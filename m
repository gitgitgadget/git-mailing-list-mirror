From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [RFC 0/2] Git-over-TLS (gits://) client side support
Date: Thu, 14 Jan 2010 15:46:56 -0500
Message-ID: <32541b131001141246o1f5ce816gc4a26b81343aaa2d@mail.gmail.com>
References: <20100113173610.GA7609@Knoppix> <20100113191802.GA8110@Knoppix> 
	<32541b131001131130i6afae1a1xd3a70e5de5daa5cf@mail.gmail.com> 
	<20100113200629.GA8383@Knoppix> <32541b131001131213m75b4baefsc70a4cbf3c8431c8@mail.gmail.com> 
	<20100113210414.GA8535@Knoppix> <32541b131001131403u162bc6ebpd551ed19aadde7fb@mail.gmail.com> 
	<20100113230023.GA9171@Knoppix> <32541b131001131551m38ff02acpdd08d9f0562ac84d@mail.gmail.com> 
	<20100114085124.GA10298@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andreas Krey <a.krey@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Thu Jan 14 21:48:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVWcX-0001fu-MN
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 21:48:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784Ab0ANUsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 15:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752043Ab0ANUsk
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 15:48:40 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:51585 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911Ab0ANUsj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 15:48:39 -0500
Received: by ywh6 with SMTP id 6so28683ywh.4
        for <git@vger.kernel.org>; Thu, 14 Jan 2010 12:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=RSqgFIxrOfNagQIPdAbURWodRDj2Dg0jAPDgvOJy9ok=;
        b=bt1St3DigHTRnwVVszYRMzJJCEQ19G1YbgW+7x0dt/TWw3Y6/3wdTAGsk28uIirHAZ
         L7lr80e1IPPC49JptDOnR7hecBnEOA1PNPDDoLiDGVHY09bt7dTAf2XC/Xo9s4fKNAma
         tEl2924OMM1AxJq+6IWQWXijaEyjiUz5bzqmA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ZWadHvn5RalAyL7Tt55hSVy/19MXjMuJ0PdpDg3zdKp6x48HZm6f2Vu8IUTyMyfMNT
         3ncHpRopIC3bCflsacEbNGvt31hGrHfGdkMuvJ6V6FJbAaPg8AhJeMbHWd1O1dCXEEjf
         C4w+GSKIBEbAE0yF4HZjqiQlY2PEqdnV7NaJM=
Received: by 10.101.133.13 with SMTP id k13mr2740043ann.14.1263502118430; Thu, 
	14 Jan 2010 12:48:38 -0800 (PST)
In-Reply-To: <20100114085124.GA10298@Knoppix>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137023>

On Thu, Jan 14, 2010 at 3:51 AM, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> The client tries only one auth method instead of potentially trying
> multiple. Witness the 'use verbose mode and check if it uses the key'
> type stuff.

I believe this is a limitation of the client, not of the protocol.  So
a patch to the ssh client could fix this.

> OpenSSH? With the level of paranoia in it, I'd say good luck. And
> it's not just client, its the server also (and especially the
> server).

But you could fork it if you wanted.  It's about as easy to convince
me to install a different version of ssh than to install
yet-another-security-server.  (In fact, it might be easier to get me
to put in a patched openssh; at least then I can trust that it's
mostly openssh, and examine just what's different in your version.)

> And if you host the repo system too, you would get second key anyway
> (and SSH is not too good at handling multiple keys).

I'm not really sure about this.  ssh-add seems pretty easy.

Have fun,

Avery
