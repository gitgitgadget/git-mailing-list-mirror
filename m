From: Dan Zwell <dzwell@zwell.net>
Subject: Re: [PATCH] Limited git-gui to displaying 5000 new files
Date: Mon, 10 Aug 2009 10:15:55 -0500
Message-ID: <4A8039AB.5020301@zwell.net>
References: <4A4A77A6.1020905@lawrence.edu> <20090810153859.GT1033@spearce.org> <81b0412b0908101006n66672cabi865a980d978c2865@mail.gmail.com> <20090810170842.GX1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Aug 10 19:16:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaYTw-0002bL-MJ
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 19:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbZHJRQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 13:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbZHJRQP
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 13:16:15 -0400
Received: from mail-pz0-f196.google.com ([209.85.222.196]:41074 "EHLO
	mail-pz0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932129AbZHJRQP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 13:16:15 -0400
Received: by pzk34 with SMTP id 34so2970663pzk.4
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 10:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=Ssibzsaa3Y47lrMAld38vudeDo9ckrQf295jp7wc0bE=;
        b=rWr1b9vsaGe3GHZjzlb4FenKieU1XAAGIPLcn9im7uj8uWdaswLW6H5Z7Cjgpha0Qm
         tYEKwludYEHklV4MSIdwC1kbXhuwYzCFnTD0Af+C+beR7skhX0APSXuj7LmHjN1IOseL
         3707F7iYBug16U/58TKJNFXenWrrtlAqODVLs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=gvUmtIyaYR9TR5Jdh0kmArHC2qDo5khsFQ6Ur+RASJBP15HZjpGJn4L0src1v7SsPq
         ZUkdzW+xeORRm6JoNSMmAPi0qNAvLkhv/AHqGpJzb218KmxXUJXQz9yvdW9wzaUg8oak
         OWGDDKSFRZK8JLFz1+GYD6ZcwN9GTyQcVMx8Q=
Received: by 10.115.95.14 with SMTP id x14mr6522936wal.223.1249924575845;
        Mon, 10 Aug 2009 10:16:15 -0700 (PDT)
Received: from ?192.168.1.105? (c-76-21-120-57.hsd1.ca.comcast.net [76.21.120.57])
        by mx.google.com with ESMTPS id g25sm7462985wag.43.2009.08.10.10.16.11
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 10 Aug 2009 10:16:14 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090719)
In-Reply-To: <20090810170842.GX1033@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125492>

Shawn O. Pearce wrote:
> Alex Riesen <raa.lkml@gmail.com> wrote:
>> On Mon, Aug 10, 2009 at 17:38, Shawn O. Pearce<spearce@spearce.org> wrote:
>>>> + ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? set warning "Displaying only $display_limit of "
>>>> + ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? append warning "[llength $to_display] files."
>>>> + ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? info_popup [mc $warning]
>>> This needs to be in the translated strings.
>> Will do, as soon as this hits git://repo.or.cz/git-gui.git.
>> Or should I have looked at the internationalization repo
>> git://repo.or.cz/git-gui/git-gui-i18n.git?
> 
> No, I meant that the patch needs to use [mc] or whatever it is
> to enable the string to be localized.  After its marked with the
> necessary code change, I can apply the patch, regenerate the .pot,
> and let translators update their .po when they have time.
> 

I will change it to use [mc] (and make the other changes that Shawn 
mentioned) and resubmit the patch.

-Dan
