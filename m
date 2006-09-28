From: Matthew L Foster <mfoster167@yahoo.com>
Subject: Re: git and time
Date: Thu, 28 Sep 2006 15:45:51 -0700 (PDT)
Message-ID: <20060928224551.8086.qmail@web51002.mail.yahoo.com>
References: <451C4BE6.20407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Rogan Dawes <discard@dawes.za.net>
X-From: git-owner@vger.kernel.org Fri Sep 29 00:46:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT4dv-0000mG-OZ
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 00:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbWI1Wpy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 18:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbWI1Wpx
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 18:45:53 -0400
Received: from web51002.mail.yahoo.com ([206.190.38.133]:2212 "HELO
	web51002.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932533AbWI1Wpw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 18:45:52 -0400
Received: (qmail 8088 invoked by uid 60001); 28 Sep 2006 22:45:51 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ezX3rpbcJAPhtywIZXHSdl5EAXAql92zQoLfy5U/KpRnhRB5h9m0/0N8ErOcd9rMCyvA4RuicC4zljC5AOAJHroalG1KSrEUm3vlznnl757l7iiKzbtslkYUjatzLrQUXa8noLbBKGxkjoVwqax8T7yP7FlTeEtPxlPydpo4Zfo=  ;
Received: from [207.172.80.85] by web51002.mail.yahoo.com via HTTP; Thu, 28 Sep 2006 15:45:51 PDT
To: git@vger.kernel.org
In-Reply-To: <451C4BE6.20407@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28063>

--- A Large Angry SCM <gitzilla@gmail.com> wrote:

> When I wrote "Sounds like you're suggesting that Git should not record 
> any timestamps at all", I meant _you_ don't think Git should record 
> _any_ timestamps since they can't be guaranteed to match the DAG.

Well, I mean since there is no time order matching commit order guarantee for distributed git the
only timestamp to use for anything locally is local time (if timestamps are used at all). The
current remote creation or merge time could stay as is (I don't care either way), but at least
gitweb.cgi should become local commit time/ref-log aware. Though if it's infeasible or requires
some rearchitecting it might not happen.

-Matt 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
