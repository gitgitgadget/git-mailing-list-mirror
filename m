From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: Merge, rebase and whitespace fixes
Date: Tue, 30 Jun 2009 09:37:08 +0200
Message-ID: <cb7bb73a0906300037w6b61cae0jeecd2f97b1095b17@mail.gmail.com>
References: <cb7bb73a0906291218m3ba43109s35cad87efc5161a7@mail.gmail.com>
	 <4A493287.20106@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Robert Fitzsimons <robfitz@273k.net>
To: Rogan Dawes <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Tue Jun 30 09:37:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLXu1-00083Q-GI
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 09:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753003AbZF3HhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 03:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbZF3HhH
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 03:37:07 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:34780 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151AbZF3HhG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 03:37:06 -0400
Received: by bwz9 with SMTP id 9so3707555bwz.37
        for <git@vger.kernel.org>; Tue, 30 Jun 2009 00:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pwlJOm4MGaDpYfpzPoS4pOQfWwrhpbbKVD2vrfBpk1A=;
        b=u7KguL2voxBcwstnt6TrOwct4FMkVa6DrLokqCQysT30S9SLTrLGGDN5kiVHYv7Wxv
         LNvPHookxKGPJnS2Oz7k/TbZWN18kPJ1T52YhStdf09AH0YEP08J1lExwsNbH2BJJONp
         ivePKDqSlgoAbyJeC/eN/qxbu3bKsGw2bVJhw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=akUmE4zLA+Rgq2VSPHbI79GSODdgyD1OV/mdlemhuoxkwHKhAzskr93HlApRToZUkn
         6rsmNniDqw1bgk1u3mZ2AuBUTRV1HZk+7GzSPMWFdh4VDXnqpG1LQqJiZKnEgERVRCtJ
         yz+EdDxyA7MoleVyKVYA9WlA4AnP9NpUrqpfs=
Received: by 10.204.116.8 with SMTP id k8mr8037731bkq.110.1246347428189; Tue, 
	30 Jun 2009 00:37:08 -0700 (PDT)
In-Reply-To: <4A493287.20106@dawes.za.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122496>

On Mon, Jun 29, 2009 at 11:30 PM, Rogan Dawes<lists@dawes.za.net> wrote:
> Giuseppe Bilotta wrote:
>> Hello all,
>>
>> recently a tree I've been working on received some thorough whitespace
>> adjustments (changing indents from spaces to tabs). This results in
>> annoying conflicts when running merges or rebases with my local
>> branches. I tried googling around but I couldn't find any helpful
>> hints on how to make git cope with this. Any suggestions?
>>
>
> Do the same thing to your own tree?

I tried doing the whitespace cleanup on top of the last patch, but the
merge still conflicted.

The interesting thing is that there's patchset from Robert Fitzsimons
that goes back to August 2005 (!) that does a couple of git apply
cleanups and in particular adds the --ignore-whitespace option that I
would need ...

http://permalink.gmane.org/gmane.comp.version-control.git/7876

but the patch apparently never made it into mainline ...

-- 
Giuseppe "Oblomov" Bilotta
