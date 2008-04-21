From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git branch diagram
Date: Mon, 21 Apr 2008 15:06:52 +0200
Message-ID: <200804211506.53251.jnareb@gmail.com>
References: <911589C97062424796D53B625CEC0025E460C3@USCOBRMFA-SE-70.northamerica.cexp.com> <m3fxtgqcbr.fsf@localhost.localdomain> <1c5969370804210548q4b6aa30h8a8c0323b3fc51d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Patrick.Higgins@cexp.com, git@vger.kernel.org
To: "Matt Graham" <mdg149@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 15:07:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnvkJ-0000Dk-Da
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 15:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755700AbYDUNHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2008 09:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755972AbYDUNHA
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 09:07:00 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:15425 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754450AbYDUNG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2008 09:06:59 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1318007wxd.4
        for <git@vger.kernel.org>; Mon, 21 Apr 2008 06:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=dhAKL73QYVY9FUZMhyLtTEbNcp7rpEZKPl3qoDcHm8c=;
        b=GJx+IhMA0JZPIR14gNJ1hx3hkbNgq5leAaDvx3nMa4xSjC6map+FbIq+xAbRM2FslItmgT5ucNDOhMcLt7E+QTx3gz1vvlR8wcBWya+EVQgaj0wFWYROGMFa4MuEX/6OwFzezv/zemFiVil1OEJHgOMiG3jjwDveypl5wgD/UtE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FuQ7njVk9xPRpl0t2nso9RiXku+WLfaFFUTT9o8w65i12MHf+o+x9xRwEqrNxzTn46Fqo1QG4pPa9TRe/wCEDF6d7pEDWeXnZpXfU2Ix63kB5WMDOabRshhhsBXX7ZvfmK7pe7wZBlGKiXHarbP0yocSK5z8Bm3U3RjpYsFH66c=
Received: by 10.100.201.16 with SMTP id y16mr12296714anf.26.1208783218287;
        Mon, 21 Apr 2008 06:06:58 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.231.29])
        by mx.google.com with ESMTPS id 8sm4179268agd.30.2008.04.21.06.06.55
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Apr 2008 06:06:56 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1c5969370804210548q4b6aa30h8a8c0323b3fc51d4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80023>

On Monday, 21 April 2008, Matt Graham wrote:
> On Sun, Apr 20, 2008 at 8:30 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>> <Patrick.Higgins@cexp.com> writes:
>>
>>> In my diagram, I am assuming that most developers work in master,
>>> and make branches for their own long-lived projects and experimental
>>> things.
>>
>> For example git itself, as a project, uses three long-lived branches:
>> 'maint', 'master' and 'next', uses 'pu' (proposed updates) branch as
>> propagation / review mechanism for short-lived tipic branches.
> 
> Jakub, could you explain the difference between maint and master?  And
> the difference between master and next?  Maint and next are clear, but
> how does master relate to those 2?

The posts titled "A note from the maintainer", posted around major git
release, should explain it. You can find them also at:
  http://git.or.cz/gitwiki/MaintNotes
  http://repo.or.cz/w/git.git?a=blob_plain;f=MaintNotes;hb=todo

In short, the minor releases like 1.5.3.8 are cut out of 'maint' branch,
the major releases like latest 1.5.5 are cut out of 'master' branch, and
'next' is where major part of development happens.

-- 
Jakub Narebski
Poland
