From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Support caching projects list
Date: Fri, 14 Mar 2008 05:17:17 -0700 (PDT)
Message-ID: <m3d4pxxzyp.fsf@localhost.localdomain>
References: <20080313231413.27966.3383.stgit@rover>
	<76718490803131707g34fd40d4q21c69391c2597bc@mail.gmail.com>
	<20080314002205.GL10335@machine.or.cz>
	<76718490803131727p451967hee96ff26206c97b7@mail.gmail.com>
	<1205454601.2758.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Fri Mar 14 13:18:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja8rG-0007A4-9R
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 13:17:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753012AbYCNMRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 08:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752972AbYCNMRT
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 08:17:19 -0400
Received: from rv-out-0910.google.com ([209.85.198.190]:20372 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbYCNMRS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 08:17:18 -0400
Received: by rv-out-0910.google.com with SMTP id k20so2368927rvb.1
        for <git@vger.kernel.org>; Fri, 14 Mar 2008 05:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=2duNyDp5Wz6IBIqdLmExtHwAqYbVTfOdezE1q72gF28=;
        b=iF9UWGd4fh6fQXuxB2IKHE4xfrADx7rIxDFbYDfHZOC59aA8mvYZoDaI4VMOV+O4whpB688ZOWu4IqMBHVaNfXvEuKhYx/upnDxuxQbUpi+u7Gcqy8v9kcm3nsHeBnwN5ujeLaBbcbbUWVfoK1mpPybLMXfgu7dNNgAlJXuiE9I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=eOC8OZWq6K0NLmQxo+xSWUTaHketzd4kZqvyDGwn7Qv+G6Jh9EIJcep54LApY2Z8Q4Vb1KMjqvNATN4bZxGrTlUwbpKZ9piSmSEDkCfClJ1PkifnDohEC8VU8rEf6Lv7dG4dEYdtpgOQEgKDLEWoLJzWKwFvOdUFR/zIWnc4zP8=
Received: by 10.140.192.9 with SMTP id p9mr1533089rvf.193.1205497038126;
        Fri, 14 Mar 2008 05:17:18 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.191.199])
        by mx.google.com with ESMTPS id 5sm404385ugc.25.2008.03.14.05.17.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Mar 2008 05:17:17 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m2ECHDVv025623;
	Fri, 14 Mar 2008 13:17:13 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m2ECGkP8025617;
	Fri, 14 Mar 2008 13:16:47 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1205454601.2758.10.camel@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77213>

"J.H." <warthog19@eaglescrag.net> writes:

> You would be better off using some of the logic I've got in the caching
> version of gitweb to prevent the race condition.

Or use Cache::FileCache the CGI::Cache uses...


By the way, J.H., would you have time and be interested in becoming
"Gitweb caching" project mentor for Google Summer of Code 2008:

  http://git.or.cz/gitwiki/SoC2008Ideas

-- 
Jakub Narebski
Poland
ShadeHawk on #git
