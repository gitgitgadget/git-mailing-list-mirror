From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH] cvsps/cvsimport: fix branch point calculation and broken branch imports
Date: Sun, 27 Apr 2008 15:43:16 +0800
Message-ID: <46dff0320804270043k7e978abcoe44f192cd49e5df4@mail.gmail.com>
References: <1207100091.10532.64.camel@gandalf.cobite.com>
	 <0C7AA499-56AD-4D20-AED0-9E7DDD0C77DF@zib.de>
	 <1207230582.17329.39.camel@gandalf.cobite.com>
	 <47F5FA79.8010604@alum.mit.edu>
	 <1207590845.17329.98.camel@gandalf.cobite.com>
	 <47FC2190.3070303@alum.mit.edu>
	 <46dff0320804262206p76941ee8la6a784ed0b6f8294@mail.gmail.com>
	 <48141379.9030306@alum.mit.edu>
	 <46dff0320804262251g3a0f12b2rb9197fc07ea57c51@mail.gmail.com>
	 <46dff0320804270038t651d94d4t3c63fe0cb5240e0d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "David Mansfield" <david@cobite.com>,
	"Steffen Prohaska" <prohaska@zib.de>, git@vger.kernel.org
To: "Michael Haggerty" <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Apr 27 09:44:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jq1YM-0003WE-Tc
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 09:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554AbYD0HnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 03:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752052AbYD0HnS
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 03:43:18 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:61767 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbYD0HnR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 03:43:17 -0400
Received: by an-out-0708.google.com with SMTP id d31so1101927and.103
        for <git@vger.kernel.org>; Sun, 27 Apr 2008 00:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=+ty7NF/+V2Cfyt0k99uExPTR93nax3KKRtm/xPl4xg0=;
        b=BDJ5H0ZDxLEjm5BJQYEAVium+EAR7Zbxb56dtp6gX4F4cLjuPc439HBescJlOmOEL/rlRKEkY2tys5P/CTQ8ZLOw4zDxvfRBxcYVhUgBg/k/wdWzjyVSo/nGfQ0ACvn0Hh0LiMGEI+s76SFLTOoEPzD4e7Pr0t5IS+F7RpqwdiA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o+ngAC/dHwuDhbYnozSHgbl5mdI58R1wnutE0nLhadAabc0G5Fz2LNHTRFZ6u8/w6CP9rtNkXVtrtCMGCQ1kF5k5i2R4b2Rw+zPWkRZ8mqz5iVC4aWMj5T8t8/mGhuOjZ4S9BCzUfzf8nCcHGbenuyI+4xwFoRLgkYT9UOiEMtE=
Received: by 10.100.41.9 with SMTP id o9mr10145579ano.42.1209282196687;
        Sun, 27 Apr 2008 00:43:16 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Sun, 27 Apr 2008 00:43:16 -0700 (PDT)
In-Reply-To: <46dff0320804270038t651d94d4t3c63fe0cb5240e0d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80431>

On Sun, Apr 27, 2008 at 3:38 PM, Ping Yin <pkufranky@gmail.com> wrote:

>  <1> very slow, about 30 minutes for a very small module.

More accurate, about 500 commits and 300 files


-- 
Ping Yin
