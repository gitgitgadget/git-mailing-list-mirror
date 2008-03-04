From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: add a setting to control the tabstop width
Date: Tue, 4 Mar 2008 09:19:43 +0100
Message-ID: <200803040919.44925.jnareb@gmail.com>
References: <20080303221159.GA6875@hashpling.org> <7vhcfnfljw.fsf@gitster.siamese.dyndns.org> <46a038f90803031935s7957a700nb5d3ba09b6575423@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Charles Bailey" <charles@hashpling.org>, git@vger.kernel.org
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 09:20:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWSNt-0003Ei-Ud
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 09:20:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbYCDITt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 03:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbYCDITt
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 03:19:49 -0500
Received: from mu-out-0910.google.com ([209.85.134.189]:15078 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366AbYCDITs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 03:19:48 -0500
Received: by mu-out-0910.google.com with SMTP id i10so2221750mue.5
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 00:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=HHje/+0DJhbSGV+bATh85/xbT47IT+eVvBLioLaLM0E=;
        b=AoWxypeFiBqG5CN4vhFBYi/xj9xI4MEdd2rYtDzZN2jwNOr6VOrUzTzo89OQ8qRRIWmyeK0dAUoMqC96vbKEPdVjtMdxZgx0U6kf1nwAJ/auk1C1jsfRBet0CkORZERNp249p7fVBywiRa+AZDWDGrNTpRcTG6udUgeItLvXM2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tM3EEVzthRipPjCvIzherwpVWX74A1CHkCqbCDlI4/F5+lzk5NulH5T/nDwdgzjmgR1vC/YQHzflhd8AuR5jf2AYz8whUxWrYCPaq6lx2ntVvn8jvLNv11ouL4dHvnamrLtRgdiOv0MoTI8ARz/GfhBthZ8g1usQ3VaUUmRwB28=
Received: by 10.82.149.8 with SMTP id w8mr3082329bud.29.1204618786371;
        Tue, 04 Mar 2008 00:19:46 -0800 (PST)
Received: from ?192.168.1.15? ( [83.8.251.156])
        by mx.google.com with ESMTPS id b30sm1396564ika.11.2008.03.04.00.19.38
        (version=SSLv3 cipher=OTHER);
        Tue, 04 Mar 2008 00:19:43 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <46a038f90803031935s7957a700nb5d3ba09b6575423@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76046>

On Tue, 4 Mar 2008, Martin Langhoff wrote:
> On Tue, Mar 4, 2008 at 12:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>  Some people say "Tabs are 8 characters, and thus indentations are also 8
>>  characters.  There are heretic movements that try to make indentations 4
>>  (or even 2!)  characters deep, and that is akin to trying to define the
>>  value of PI to be 3."  Some people disagree.
> 
> And on the web, people use CSS to sort these disagreements amicably...
> As a web apps guy, adding a setting for something like this, and then
> changing the output feels _very_ weird, as it breaks with a lot of
> stuff that Just Works in the HTTP+HTML world even for users that view
> it differently... like caching :-)

The problem with using CSS to select tabstop width is twofold. First,
it has to work correctly also in text browsers like lynx, elinks, w3m.
Second, it is tabstop size, not the width of tab character; I'm not
sure if it is possible to implement it in CSS.

-- 
Jakub Narebski
Poland
