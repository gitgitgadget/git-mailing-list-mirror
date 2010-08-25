From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: Does anyone use git-notes?
Date: Wed, 25 Aug 2010 12:40:21 -0600
Message-ID: <4C756395.6020103@workspacewhiz.com>
References: <AANLkTin=VXp2BU0vhTLUy6MpJ7spXRs1dZC1wygoN6T-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 20:40:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoKti-00072y-9y
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 20:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660Ab0HYSkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 14:40:25 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:35124 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392Ab0HYSkX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 14:40:23 -0400
Received: (qmail 14446 invoked by uid 399); 25 Aug 2010 12:40:23 -0600
Received: from unknown (HELO ?192.168.1.2?) (jjensen@workspacewhiz.com@75.196.155.152)
  by hsmail.qwknetllc.com with ESMTPAM; 25 Aug 2010 12:40:23 -0600
X-Originating-IP: 75.196.155.152
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.8) Gecko/20100802 Lightning/1.0b2 Thunderbird/3.1.2
In-Reply-To: <AANLkTin=VXp2BU0vhTLUy6MpJ7spXRs1dZC1wygoN6T-@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154459>

  ----- Original Message -----
From: Scott Chacon
Date: 8/25/2010 12:15 PM
> I would like to write a post on how to use them, but I'm a bit
> confused as to how people actually use them on a day to day basis.  I
> appears to me in trying to work out a flow for them that the lack of
> an ability to merge them makes them very difficult to use for anything
> practical.  Can someone share with me how they use them and what the
> cycle is?
I do.  I use them to automatically store a matching Perforce revision 
number for a given Git commit.  Only the server assigns them due to the 
merging issues.  I also change the ref, so they read as p4notes.

It irks me, though, that they show in the gitk --all view.  ARGH!

Josh
