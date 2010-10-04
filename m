From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: remote-bzr status
Date: Mon, 4 Oct 2010 01:11:05 -0500
Message-ID: <20101004061104.GH24884@burratino>
References: <4CA8F2F1.5090407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Sverre Rabbelier <srabbelier@gmail.com>
To: Gabriel Filion <lelutin@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 08:16:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2eLP-0007WJ-HZ
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 08:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180Ab0JDGOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 02:14:21 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50661 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107Ab0JDGOU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 02:14:20 -0400
Received: by gye5 with SMTP id 5so1467283gye.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 23:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=2SFMrcxD/QXS3OcibG3otBKrHtypy2EzVlzvNrovsQ0=;
        b=pGS1YBRcOZSpJhPQbLsCu+EyEOjPJdqUCS6XHQt/47jeYfEvCXa+J1PIkiV8bP6w5t
         ifX/oPJCpb+qv5WPX3LZ/0SvcBEkGVvvHh/CbyTa/s5HZA8I440844iaxy8vDN0TR68k
         ieD4PQYhhX6b7gFBJuz/U466wHMHoukfZJ4c8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=c953iiDHiNXWKHUCCAvj3uhPbIIOfyfIsFlzwuInwbsjEAR/BsyfHl8e2XSLcVbmF8
         Gtlv49MjvZJfflhiYRMJm2uV9U9ePMFs6/liT+C1Yms6opfKga1kU5H4k1vmWC131+O2
         ajcdsoBhsjBRpk4GTmPRyKu94vkJoQsPAQiQg=
Received: by 10.101.125.19 with SMTP id c19mr5064057ann.221.1286172859549;
        Sun, 03 Oct 2010 23:14:19 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id c7sm8591922ana.18.2010.10.03.23.14.18
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 23:14:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4CA8F2F1.5090407@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157980>

Hi,

Gabriel Filion wrote:

> git://github.com/lelutin/git-remote-bzr.git

>From README.rst:

| What may work:
| 
| - small repositories
| - cloning local branches
| - using differential import (although pushing is currently broken --
| see below)

Nice.

| What's being stopped by bugs in dependencies
| 
| - pushing (I've fixed a bug on Ian's branch -- see below -- but I've
| hit another one with using mark_files)

I notice that you are already maintaining a patches/ directory with
fast-import patches that are needed.  Seems like a sane approach.

> Any help and/or support would be appreciated.

Also good to hear. :)

What is the license on your code (if any)?  Would you be interested
in including it in contrib/ or core git?
