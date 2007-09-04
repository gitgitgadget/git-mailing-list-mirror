From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] git/gitweb.git repository
Date: Tue, 4 Sep 2007 11:38:07 +0200
Message-ID: <20070904093807.GW10749@pasky.or.cz>
References: <20070831000149.GK1219@pasky.or.cz> <7v8x7n7zqn.fsf@gitster.siamese.dyndns.org> <46DCF41D.2070905@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	jnareb@gmail.com, ltuikov@yahoo.com
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Sep 04 11:38:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISUrk-0000rc-HP
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 11:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752404AbXIDJiM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 05:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752002AbXIDJiL
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 05:38:11 -0400
Received: from w241.dkm.cz ([62.24.88.241]:47910 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750874AbXIDJiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 05:38:09 -0400
Received: (qmail 23111 invoked by uid 2001); 4 Sep 2007 11:38:07 +0200
Content-Disposition: inline
In-Reply-To: <46DCF41D.2070905@op5.se>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57544>

On Tue, Sep 04, 2007 at 07:58:53AM CEST, Andreas Ericsson wrote:
> Junio C Hamano wrote:
>> * Incremental blame
>>   It does not seem to break the blame, but at least from where I
>>   sit accessing repo.or.cz this does not look incremental to me.
>>   The entire browser session freezes until the blame page
>>   displays in full.  My local installation behaves the same way.
>
> This is most likely due to what browser you're using. Some don't
> start rendering until they've read the entire output of an URL.

The incremental blame uses AJAX, so this shouldn't be an issue. But for
some browsers it seems to take long time to actually render the new ids
or something; I was reluctant about moving this particular one from next
to master because I have also seen problems with it and wanted to do
more tests. The benefit is mostly on files with long history buried deep
in the past.

-- 
				Petr "Pasky" Baudis
Early to rise and early to bed makes a male healthy and wealthy and dead.
                -- James Thurber
