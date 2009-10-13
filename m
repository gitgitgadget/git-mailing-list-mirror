From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: linkify author/committer names with search
Date: Tue, 13 Oct 2009 12:26:55 +0200
Message-ID: <1255429615-4402-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <1255328340-28449-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 12:39:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxeiL-0001Yw-Lf
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 12:34:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933664AbZJMK1z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 06:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759380AbZJMK1z
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 06:27:55 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:35558 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759289AbZJMK1y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 06:27:54 -0400
Received: by fxm27 with SMTP id 27so9989516fxm.17
        for <git@vger.kernel.org>; Tue, 13 Oct 2009 03:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:references:user-agent:mime-version:content-type
         :content-transfer-encoding:x-face;
        bh=aEt+ZUIC/Lq/5hGIvXbkmhS1Osh8eC6wZ48Y3FXGDvE=;
        b=dQxmGz9CB0cxhMmRRKsdaMfA2mc/yH2YlgvV8FjAGEo4UeN73vNgNJilRjfeu61VYF
         S4+NLkNGd8GnzsTjl4BGUyyMd6Gb7uIw9fRPFKelfXl/0bLDyHxlKbHmQ4GnhZbRMl+v
         AnF67HwBywES1fAgIYTLNnw2xZadASgS4cvUM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:references:user-agent
         :mime-version:content-type:content-transfer-encoding:x-face;
        b=wL0BYbqdd55VPrbu1rCuMf07PTT0Cyn9QNz0SMQnUGNAqyu7AsPpFJX6/fpzAYAy9e
         a9sZTxw79pVTbZQVM1gvAkC6N/hM/ymo3FA3iltHDaxvq6dIESyKYftBqTAnPvPhhzFz
         X8GTDLjZPxkcOJU+mW+Svo8/jM5DkiLhwSbwI=
Received: by 10.102.249.18 with SMTP id w18mr2909611muh.51.1255429636517;
        Tue, 13 Oct 2009 03:27:16 -0700 (PDT)
Received: from localhost (host-78-13-55-37.cust-adsl.tiscali.it [78.13.55.37])
        by mx.google.com with ESMTPS id y2sm2059058mug.19.2009.10.13.03.27.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Oct 2009 03:27:15 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.rc2.209.g8cdfd
User-Agent: KNode/4.3.2
X-Face: ::w9}R^l{WGM\{y)C0QF@4^U,',W3Mk^X0HP)=:bKM^Z]A9+6bY6fe3}O*]fH{l<j1/9RTp  `KR0idy]Im#9^%}P5Dga'>AViT_'?&>&ufo2_X5Vs3C^tPO@drZRuu&6iK}x}~9`F\-dNZ>(p|V7`4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130154>

On Monday 12 October 2009 08:19, Stephen Boyd wrote:

> The problem is I can't get it to work with UTF-8 characters. I'm not sure
> if it's my system or not, so I'm just posting here to see if others
> experience the same problem and if there's interest.

Does it work if you use CGI::escape() on the author names when filling
the searchtext?

-- 
Giuseppe "Oblomov" Bilotta
