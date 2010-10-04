From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Move tags to branch
Date: Mon, 4 Oct 2010 14:21:25 -0500
Message-ID: <20101004192125.GE6466@burratino>
References: <AANLkTinzGy62ETZdry5y1qTi0djkt9d72_3soCP6K_Qn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mathieu Malaterre <mathieu.malaterre@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 21:24:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2qeZ-00082T-I9
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 21:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458Ab0JDTYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 15:24:45 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:38130 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755768Ab0JDTYp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 15:24:45 -0400
Received: by eyb6 with SMTP id 6so2142056eyb.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 12:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=uhKEC8yXQPEzWuM/rHKU6QtNeWRQ8fgUpmQh5DHX33s=;
        b=uXVmo7EwFMbFehqD3OxMu8/WFYW7+nuMszLec8SCRTtQNgQtougRIBsn51By9Pkf34
         MFrMiiXpREBpOamA7Au/QVv6+wluiv3qln3/3Y75ASIARVxjxwluEJjyfqhz8dD+Xreb
         oycWZmWfn6nGN6rnrH5TyqrUGuF6adEaluwys=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PJR7H02iPE+C3iuTpE5H/8dU8EjkdCP1Kz+7+1mV7AO+IG4U0Mr9Z1qYPhbNHylKpp
         oyiizn/oe1eVgVrDJgZvKvMawuYyDkwhLsT8IY9WmaksScdhCe62hp5B3jPqeIeZoBTq
         a3FBSRvb/9dE0SEMLh8seLshlhlgNCAGpKSsQ=
Received: by 10.223.103.84 with SMTP id j20mr9631725fao.35.1286220283616;
        Mon, 04 Oct 2010 12:24:43 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id a6sm2430049faa.20.2010.10.04.12.24.41
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 12:24:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinzGy62ETZdry5y1qTi0djkt9d72_3soCP6K_Qn@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158103>

Mathieu Malaterre wrote:

> | * commit 5fd43e4a662b1a7d43d2e10de3dec40c58dcb6a4
> |/  Author:
> |   Date:   Wed Aug 18 10:23:12 2010 +0000
> |
> |       ENH: Tagging the  release
> |
> | * commit 8d16cdc21ea84158eba57d0bc8d9ae96427fd24a
> |/  Author:
> |   Date:   Mon Jul 12 09:42:49 2010 +0000
> |
> |       obfuscate niels emails
> |
> 
> I would like:
> 
> | * commit 5fd43e4a662b1a7d43d2e10de3dec40c58dcb6a4
> | | Author:
> | | Date:   Wed Aug 18 10:23:12 2010 +0000
> | |
> | |     ENH: Tagging the  release
> | |
> | * commit 8d16cdc21ea84158eba57d0bc8d9ae96427fd24a
> | | Author:
> | | Date:   Mon Jul 12 09:42:49 2010 +0000
> | |
> | |     obfuscate niels emails
> | |

How would that work?  Would Niels's emails be obfuscated on
the release branch?
