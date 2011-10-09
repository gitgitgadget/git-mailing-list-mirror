From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH da/difftool-mergtool-refactor] Makefile: fix permissions of mergetools/ checked out with permissive umask
Date: Sun, 9 Oct 2011 11:26:30 -0700
Message-ID: <1C9F1683-4C6E-4D49-86D3-3A47B2843F23@gmail.com>
References: <1313652227-48545-1-git-send-email-davvid@gmail.com> <1313652227-48545-4-git-send-email-davvid@gmail.com> <20111009091617.GA29150@elie.hsd1.il.comcast.net> <20111009114333.GA29829@elie.hsd1.il.comcast.net>
Mime-Version: 1.0 (iPhone Mail 8C148a)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Tanguy Ortolo <tanguy+debian@ortolo.eu>,
	Charles Bailey <charles@hashpling.org>,
	SebastianSchuberth <sschuberth@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 09 20:27:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCy5T-0004Ab-Ex
	for gcvg-git-2@lo.gmane.org; Sun, 09 Oct 2011 20:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306Ab1JIS0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Oct 2011 14:26:44 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60948 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112Ab1JIS0n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Oct 2011 14:26:43 -0400
Received: by yxl31 with SMTP id 31so4807021yxl.19
        for <git@vger.kernel.org>; Sun, 09 Oct 2011 11:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=references:in-reply-to:mime-version:content-transfer-encoding
         :content-type:message-id:cc:x-mailer:from:subject:date:to;
        bh=dGoeq3I6u+kDWlT8JbyxXPqj2PqAIaSViAThcR4Y5nQ=;
        b=IIkT7ezgIOzvy9J0JGNEazbDdwNpwCIhpNb/QKMHtIm/coQ4hBK2ESiFVzBhE2wx6N
         D2Ew0B2RZZ28uawR0jBOliB4bIc9HYL/XYoF50CPMu++qHOP2krIdmtLs/mj9lOIAaWa
         LecXHnJkel6c2AUsj2rI3cBLu2RsVad0/PWF4=
Received: by 10.68.31.129 with SMTP id a1mr31668643pbi.5.1318184802571;
        Sun, 09 Oct 2011 11:26:42 -0700 (PDT)
Received: from [192.168.1.13] (208-106-56-2.static.dsltransport.net. [208.106.56.2])
        by mx.google.com with ESMTPS id ki1sm58244107pbb.3.2011.10.09.11.26.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 09 Oct 2011 11:26:41 -0700 (PDT)
In-Reply-To: <20111009114333.GA29829@elie.hsd1.il.comcast.net>
X-Mailer: iPhone Mail (8C148a)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183208>

On Oct 9, 2011, at 4:43 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:

> Jonathan Nieder wrote:
> 
>> ---
> [...]
>> Since debian/rules install is run as root, the default is for tar to
>> act as thought --preserve-permissions were passed
> 
> I should have said: "when 'make install' is run as root, ...".
> 
> Typically people building git for private use would run "make install"
> as root when installing to /usr/local, but as an unprivileged user
> when installing to $HOME.  The RPM packaging runs "make install"
> without special privileges and the Debian packaging runs it as (fake)
> root, iirc.
> 
> Sorry for the lack of clarity.

thanks. I agree that the tar is overkill. I think I copied that snippet from templates/makefile. does that have the same bug?
-- 
    David (mobile)