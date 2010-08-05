From: David Michael Barr <david.barr@cordelta.com>
Subject: Re: [GSoC update extra!] git-remote-svn: Week 13
Date: Fri, 6 Aug 2010 08:15:26 +1000
Message-ID: <70D9930D-DDB6-493D-9936-21E9CD4426A2@cordelta.com>
References: <20100730190124.GA2995@kytes> <0C6B8C5E-15BA-43AD-B2F2-914F39EA6046@cordelta.com> <AANLkTi==fm8kxoB9aPYJNqBO=O9ALq-1qTzQj9RSXYBN@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 00:15:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh8ix-00042k-2Q
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 00:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758537Ab0HEWPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 18:15:34 -0400
Received: from ironport1-mx.cbr1.mail-filtering.com.au ([203.88.115.241]:61223
	"EHLO ironport1-mx.cbr1.mail-filtering.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756150Ab0HEWPd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Aug 2010 18:15:33 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEADrVWkzLWHsF/2dsb2JhbACgQHG+RYhNhToE
X-IronPort-AV: E=Sophos;i="4.55,324,1278252000"; 
   d="scan'208";a="216831462"
Received: from node2.alpha.aussiehq.net.au ([203.88.123.5])
  by ironport1-mta.cbr1.mail-filtering.com.au with ESMTP; 06 Aug 2010 08:15:29 +1000
Received: (qmail 25432 invoked from network); 6 Aug 2010 08:15:28 +1000
Received: from d110-33-90-139.mit3.act.optusnet.com.au (HELO ?192.168.1.2?) (110.33.90.139)
  by node2.alpha.aussiehq.net.au with SMTP; 6 Aug 2010 08:15:27 +1000
In-Reply-To: <AANLkTi==fm8kxoB9aPYJNqBO=O9ALq-1qTzQj9RSXYBN@mail.gmail.com>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152728>

Hi,

>> The reason being that going from git to subversion there is a
>> general increase in redundant data.
> 
> I don't understand?

The primary issue is a blob may be repeated in a non-copy operation,
requiring its content to be described again. This sort of operation only
happens 20% of the time with the ASF repository. We would have to
either write out the content again or compute a new delta depending
on the target version of the svn dump stream.

>> On the other hand, to produce an svn dump stream we may need
>> to repeat elements encountered earlier in the fast-export stream.
> 
> What do you mean with this?

See above, there was some redundancy in my post.

--
David Barr.
