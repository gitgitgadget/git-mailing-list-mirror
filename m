From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: thoughts on setting core.logAllRefUpdates default true for bare 
	repos
Date: Thu, 5 Nov 2009 00:59:32 +0100
Message-ID: <fabb9a1e0911041559m18a50d50r1b31aa99a1ce76aa@mail.gmail.com>
References: <slrnhf2uep.7d3.sitaramc@sitaramc.homelinux.net> 
	<alpine.DEB.1.00.0911041422170.2788@felix-maschine> <2e24e5b90911040841l7741787et48fabb8c8066e946@mail.gmail.com> 
	<20091104235241.GA12984@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Thu Nov 05 01:00:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5plf-0000sL-Kz
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 00:59:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932811AbZKDX7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 18:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932692AbZKDX7s
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 18:59:48 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:40553 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932703AbZKDX7r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 18:59:47 -0500
Received: by ewy3 with SMTP id 3so3750342ewy.37
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 15:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=KdUpI4KhMPgdXuY+HmmO13aIIvxhPUmrvSFQ93Du7f8=;
        b=F7hxopbhW/gh1re+DqRrAti0TOr8RTUoMjOk5AlWvrJ7saoIut2wnFFouKVwODmcPP
         kR1bX24TTTCPfw/VvZwQeHdiV6qwMP/enAlh858YXhML5lCteJ6f7yrBG3Zr6cYpFTNW
         T5SoBen6rs7eBqAzDfTCm3Y+6ekNYS7zHC5KU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=JYgnW9LISW0Yg/fwarvHybm9d5rAcrlU0W2MqScDoWWyqjXmZMS38Zwbyvvz4kSXKk
         Bb1kjx6i5msrV2UkexPlsvoC3Nrd1UuiViBaO2fsOiAvjzz6ImEDtqxDG9m61Gw+iH59
         cB+79cOh7UCyC+ADoI40GFQ2jpUG4PFgH+nJY=
Received: by 10.216.88.75 with SMTP id z53mr713112wee.46.1257379192151; Wed, 
	04 Nov 2009 15:59:52 -0800 (PST)
In-Reply-To: <20091104235241.GA12984@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132177>

Heya,

On Thu, Nov 5, 2009 at 00:52, Nicolas Sebrecht <nicolas.s.dev@gmx.fr> wrote:
> Or did you mean if "non-admin users could" ?

We're talking about the case wherein a confidential object is pruned,
regardless of whether it is a non-admin or admin user doing the
pruning, they should be able to 'reflog expire' if they can 'git gc'.

-- 
Cheers,

Sverre Rabbelier
