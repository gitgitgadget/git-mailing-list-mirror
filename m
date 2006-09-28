From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: gitweb: using quotemeta
Date: Thu, 28 Sep 2006 16:27:52 -0700 (PDT)
Message-ID: <20060928232752.99373.qmail@web31804.mail.mud.yahoo.com>
References: <7vodszshq3.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 29 01:28:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT5IO-0000ml-FT
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 01:28:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWI1X15 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 19:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWI1X15
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 19:27:57 -0400
Received: from web31804.mail.mud.yahoo.com ([68.142.207.67]:30631 "HELO
	web31804.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751090AbWI1X14 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 19:27:56 -0400
Received: (qmail 99375 invoked by uid 60001); 28 Sep 2006 23:27:52 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=6JiAI7jpgNTMgQrWvs03lpkbMb5GCotyb5w5wG3hbUTLc/WmOSX0/omxwbN4kaBPK3zmwDdadAr5bkalmZjCE7ksnVIUkjTyLV/yoA0vOcW7AGQkhW3YLU4wIL9pDM0C1XY86vycJ8z7iP1W/BQX9d4ky8ZuazlL7az7ckMcmJA=  ;
Received: from [64.215.88.90] by web31804.mail.mud.yahoo.com via HTTP; Thu, 28 Sep 2006 16:27:52 PDT
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vodszshq3.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28066>

--- Junio C Hamano <junkio@cox.net> wrote:
> 
> Ouch, that was a sloppy planning and coding, and sloppier
> reviewing.  Sorry.
> 
> What is the right quoting there?  Just quoting double-quotes?

I'm not sure.  What undesired character could we have in $filename
of a snapshot?  The commit ab41dfbfd4f message gives this
justification: "Just in case filename contains end of line character."

It looks like $filename is constructed by well defined strings:
basename($project), $hash and $suffix all of which should be ok.

I'd say we don't need quotemeta for $filename of snapshot.

    Luben
