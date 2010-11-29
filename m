From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/6] web--browse: use (x-)www-browser if available
Date: Mon, 29 Nov 2010 10:48:37 -0600
Message-ID: <20101129164837.GJ8037@burratino>
References: <1291042075-19983-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1291042075-19983-6-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 29 17:48:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PN6uK-0006FR-HO
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 17:48:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754974Ab0K2Qsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 11:48:47 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:62882 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754978Ab0K2Qsq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 11:48:46 -0500
Received: by ywl5 with SMTP id 5so2133680ywl.19
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 08:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=LwuNQ+D8t+p+P8cOtoS7yRgQBNoStfkLLUYRQKwyGTg=;
        b=xNpWwme/4C/y3CgNEiVPGsMDxLsAUWrkxHuvOvyqtEav/2gBRp9tjmPo+lxq4NqF4B
         oZm7bEN8tqqGmm5vCrCwePxwcIYTtuQe1WXmXKs2jXzAa1dJIZhL1Q8KVccNvZ9GTc4p
         Ly6CeR4LWnzztM0wm3JBG3Th8Yob5b9xiKt2w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=VmLXcow9LQ0rGUePjBIDmkS58Uyllz30vYi6ooFEvDfRIpElRNQJKAV0RqVppKr1nt
         4RWbh2WHP61sBLGWBfgGElpEtHUjE3DwzP1gudJIhu17Pj2JZlHWiLD3oQ1zdkQuEfzP
         cwN0sP23z1TWBhuLJkKJTm+971gGKx7YgVQ40=
Received: by 10.223.100.15 with SMTP id w15mr462160fan.121.1291049325467;
        Mon, 29 Nov 2010 08:48:45 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id n15sm1275837fam.12.2010.11.29.08.48.43
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 29 Nov 2010 08:48:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1291042075-19983-6-git-send-email-giuseppe.bilotta@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162400>

Giuseppe Bilotta wrote:

> Debian and derivatives have an alternatives-based default browser
> configuration that uses the /usr/bin/x-www-browser and
> /usr/bin/www-browser symlinks.

Mm, maybe it will be time to look into adding xdg-open support
soon, too.
