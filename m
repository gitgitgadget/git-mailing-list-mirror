From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: revert top most commit
Date: Wed, 27 Aug 2014 17:22:43 -0700
Message-ID: <20140828002243.GA20185@google.com>
References: <1409174048.2715.12.camel@jekeller-desk1.amr.corp.intel.com>
 <1409177738.15185.5.camel@leckie>
 <1409179401.2715.17.camel@jekeller-desk1.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "dturner@twopensource.com" <dturner@twopensource.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 02:22:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMnUJ-00062A-8g
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 02:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936038AbaH1AWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 20:22:47 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:57420 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932305AbaH1AWq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 20:22:46 -0400
Received: by mail-pa0-f43.google.com with SMTP id et14so163823pad.2
        for <git@vger.kernel.org>; Wed, 27 Aug 2014 17:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=N+/91vsqj5tdIhcvC6v9Vz4+mOvNV2Q9WaiCzwUSFVY=;
        b=ct1uV6SduxHBRQKBvhgHdlMTdb4+wnTwwDxUvFxvUMKgme/6b+TSos0F8nRamaHW+K
         58IepqF3HGVKhrxYsObXcbED8AOf4cciA1Qu2/MOuqQA12GCzKcsnIFeO/pFe5s96Yjy
         m+ZYAD+xNkPIiEaRDB43ZgBZw2lFPQv62t11gIaMm7ZPtogt2qV+8bvOrq5l7mqcfKnE
         AAzRc80vuXuec76c1rqlBsTp7dni6ePcxPqET6Ylr4CAwiSvBuzxlrkQbMZQxmFECGzc
         xy/uA5icQxQzZthBjV9/bcaeepQ3bhaV797QEr4mdYIpu1I6t2m/Tc5m7fv+5AFd2K93
         FrGg==
X-Received: by 10.68.115.48 with SMTP id jl16mr686006pbb.78.1409185366071;
        Wed, 27 Aug 2014 17:22:46 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id dg5sm6474734pac.12.2014.08.27.17.22.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 Aug 2014 17:22:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1409179401.2715.17.camel@jekeller-desk1.amr.corp.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256058>

Keller, Jacob E wrote:
>> On Wed, 2014-08-27 at 21:14 +0000, Keller, Jacob E wrote:

>>> I am having trouble using revert. If I attempt to
>>>
>>> $ git revert <sha1id>
>>>
>>> where sha1id is the same as the HEAD commit, I instead get the output of
>>> what looks like git status.
[...]
> It's actually not my repository, I was helping a co-worker, and thought
> I'd ask if anyone here knew if it was expected behavior or not.

More details about the output would help --- otherwise people have to
guess[*].  I'm guessing your co-worker's working tree is not clean.
Commiting or stashing their changes first might get things working.

Hope that helps,
Jonathan

[*] Another nice thing about quoting output is that it becomes more
obvious what about it wasn't helpful, which sometimes leads to patches
from kind people on the list to fix it.
