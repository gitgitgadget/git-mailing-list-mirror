From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Questions about branches in git
Date: Thu, 28 Jan 2010 17:01:34 -0600
Message-ID: <b4087cc51001281501y67a35f22k732c412ce2b46fb1@mail.gmail.com>
References: <69b754db1001281044y39e52f77hcc8f83144776c78f@mail.gmail.com> 
	<b4087cc51001281203q1f467480sdf848c9d3ced323b@mail.gmail.com> 
	<69b754db1001281317o69f8c3f9y412a8524407bacbf@mail.gmail.com> 
	<b4087cc51001281418m3f19d765rd9aab03a339f15a4@mail.gmail.com> 
	<69b754db1001281456k7c275550r5ffde67b254b510e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Mike Linck <mgl@absolute-performance.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 00:02:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NadNB-0005Kx-LE
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 00:02:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523Ab0A1XB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 18:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755468Ab0A1XB4
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 18:01:56 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:55519 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754814Ab0A1XBz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 18:01:55 -0500
Received: by ewy19 with SMTP id 19so1333009ewy.21
        for <git@vger.kernel.org>; Thu, 28 Jan 2010 15:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=gjyu/3r31CukPh06Nem0HvY4r0klUMv5Z7brbu0IhTw=;
        b=Eh3c77dG9VFgDlbT3xZA6sQgvGK0tepPUSOPvmiocJuLh1akxSoXumQxHvFfEcVpf8
         0KYuT9lKqmuh3mpQ9q8aPoFpjifi3fPmhX+3Ez/0kTmsz48+68XLR6iizvrw10Oiq++d
         NGd+R4MagKB3I6eSuUWWUqmtooNZE3Li+lEF4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Tq8pD/P3tDB67oQW/pBsPvEi/Kdr1jX4YWqw6+zky1YgqDdVlhPSPOuxVDmm7r+NRt
         N977u3N3cGh6UprP9jUHHyw+rv2oPelCfvm1HmgjvT6KCMmzaLcDjDgZBHndPSTdBeqm
         WD/CFwRgUBxOFgNb7Aie2MWR3P6FukHCu2c2A=
Received: by 10.213.26.199 with SMTP id f7mr1876442ebc.72.1264719714212; Thu, 
	28 Jan 2010 15:01:54 -0800 (PST)
In-Reply-To: <69b754db1001281456k7c275550r5ffde67b254b510e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138283>

On Thu, Jan 28, 2010 at 4:56 PM, Mike Linck
<mgl@absolute-performance.com> wrote:
> Your example will work on non-FF branches if you make the second
> merge-base use master~1 (else it just gives you the same commit sha
> twice)

That's the point of the '^' character that I used in my example; it
wasn't a mistake.
