From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: is there an easier way to do this ?
Date: Tue, 30 Dec 2008 15:03:34 -0800 (PST)
Message-ID: <m3k59hb6xr.fsf@localhost.localdomain>
References: <gjc52u$ehc$4@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Zorba" <cr@altmore.co.uk>
X-From: git-owner@vger.kernel.org Wed Dec 31 00:05:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHne0-0001U0-RF
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 00:05:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262AbYL3XDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 18:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752066AbYL3XDi
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 18:03:38 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:37849 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551AbYL3XDh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 18:03:37 -0500
Received: by ewy10 with SMTP id 10so5744486ewy.13
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 15:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=3jHYyTbR/D3tSwgm0xaZUtUGuFReyOsP/Ovlk08j6/Q=;
        b=EDuuxDWfgvJWeegFYEmT1lyNF+mR145ZAKFHhhE0Rkx5p+ebWsWAXnM23sFoKCNu62
         VQ9DeehBPAJJffM0iocTSgSoyWNdliMk+pR86yfBlL/JF0w3n/JkGU8yoZ17DWvrV5PE
         iMcOQKpIlONXKW+sv+NbYRlYLbXKqepnuf/sc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=qF5jiasL436GiUudkvj6/AZFTmsBgkx3fkP6YhMjJNy6f7pxwTwUxDn6obRCbIrwA4
         0TbWexPZoahitQunC/XbjJaxVd9++1j2dWWzztkr9WixkwaR0Loe0VGeZsBXEPferkXw
         +66MGO8zhH6T/g/DEV+SvF7xKwrSJue6WoJuo=
Received: by 10.210.113.16 with SMTP id l16mr11769603ebc.120.1230678215430;
        Tue, 30 Dec 2008 15:03:35 -0800 (PST)
Received: from localhost.localdomain (abwv44.neoplus.adsl.tpnet.pl [83.8.245.44])
        by mx.google.com with ESMTPS id c22sm39081108ika.20.2008.12.30.15.03.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Dec 2008 15:03:34 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mBUN57fC028520;
	Wed, 31 Dec 2008 00:05:08 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mBUN552I028517;
	Wed, 31 Dec 2008 00:05:05 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <gjc52u$ehc$4@ger.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104222>

"Zorba" <cr@altmore.co.uk> writes:

> ok, now I'm in this for real, archiving versions of our website project (5k 
> files approx)
> 
> so here is the workflow:
> 
> - copy version 1 files into GIT dir
> 
> - open git bash
> 
> $ git init
> 
> $ git add .
> 
> $ git commit -m "version1"
> 
> all vanilla ? cool
> next job = store version 2 [...]

Check out contrib/fast-import/import-tars.perl

-- 
Jakub Narebski
Poland
ShadeHawk on #git
