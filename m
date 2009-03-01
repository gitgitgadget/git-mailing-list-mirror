From: =?ISO-8859-1?Q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>
Subject: Re: jgit and ignore
Date: Sun, 01 Mar 2009 18:51:54 +0100
Message-ID: <49AACB3A.8070809@gmail.com>
References: <9e4733910902280831j70448ce9h7239f14e13b92b76@mail.gmail.com> <20090228172622.GC26689@spearce.org> <49AA5F64.6070207@pelagic.nl> <9e4733910903010454u662eb5afob45f608321660500@mail.gmail.com> <49AA884D.1050806@pelagic.nl> <49AA8ECD.4090302@gmail.com> <49AA91F0.7050008@pelagic.nl> <49AAA2B3.40808@gmail.com> <20090301171648.GB14365@spearce.org> <49AAC91E.1000401@gmail.com> <20090301174941.GD14365@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Mar 01 18:53:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ldpr7-0003CQ-Jh
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 18:53:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756798AbZCARwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 12:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756632AbZCARwI
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 12:52:08 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:54356 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753634AbZCARwG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 12:52:06 -0500
Received: by fg-out-1718.google.com with SMTP id 16so851999fgg.17
        for <git@vger.kernel.org>; Sun, 01 Mar 2009 09:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=lr0TSZv5I1AJ3p9TyptR6TfLdSdKhNRAKG6K033AWjM=;
        b=BB30Zuh1exphrBYpXzAGzG69P/epOd+CjUPGdRaWN8SDpl2hNr0iq1tHqkSdzVtfJr
         RrXgbPmcz2vgJBfl8o7+9uM8lDBZxVnMFJ9jalDJzVzk1/R2MODQHM6y0XGHi0IOoZnR
         vl/R19Tofg1BwjPjy/OaEhXOHjXt9HveJ/E7E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=cwMGlLZXZVY4Ks168k+NVTndaZcDO3ME/CTVgvT8bai9GC2S/QhaWzDXt49if8P4uA
         XBI3UMKXrJvO1NfQL9fFejjtb3T7gHI4edNnYuB0u8LW70h5O7YCn2ZJh2P/9S4Ri2oO
         FSvwDrNTTdhDd/eIT9Q3tbEjDloUTZLGEYKvo=
Received: by 10.86.95.20 with SMTP id s20mr5834142fgb.4.1235929921495;
        Sun, 01 Mar 2009 09:52:01 -0800 (PST)
Received: from ?192.168.1.226? (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id 4sm5610760fge.34.2009.03.01.09.52.00
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 01 Mar 2009 09:52:01 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <20090301174941.GD14365@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111864>

Shawn O. Pearce wrote:
>> Just to be clear, I noticed you left out the global core.excludesfile
>> (from ~/.gitconfig) here. I guess this intentional?
> 
> No, I didn't.  core.excludesfile is read from the config, the config
> is a union of /etc/gitconfig, ~/.gitconfig, and GIT_DIR/config.  The
> last setting wins.

Ah, I see, I thought each config was read in a separate steps. Thanks
for clearing that up.

>> Either way, I full agree that we should honor all repository ignores
>> (whether they are in directory .gitignores, info/exclude, or given by
>> repository-specific core.excludesfile).
> 
> Right.  See my reply to Ferry, we union all of them together, but in
> the case of core.excludesfile we have to honor what the repository
> is telling us is the correct setting for that one repository,
> which may differ from other repositories if it has been overridden.

Yepp, full ack.


Tor Arne
