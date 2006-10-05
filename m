From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH 1/2] gitweb: blame: Print just a single new line char per table row
Date: Wed, 4 Oct 2006 23:48:17 -0700 (PDT)
Message-ID: <20061005064817.21552.qmail@web31804.mail.mud.yahoo.com>
References: <7vejtnij5n.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 05 08:48:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVN1p-00045j-Dt
	for gcvg-git@gmane.org; Thu, 05 Oct 2006 08:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbWJEGsS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Oct 2006 02:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbWJEGsS
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Oct 2006 02:48:18 -0400
Received: from web31804.mail.mud.yahoo.com ([68.142.207.67]:39044 "HELO
	web31804.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751514AbWJEGsS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Oct 2006 02:48:18 -0400
Received: (qmail 21554 invoked by uid 60001); 5 Oct 2006 06:48:17 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Cs0HfPRJDfNiTiMarQMAj+YNbV3A8OxkHHDl0D3Py+rLH9H/G/tgTn7ywUUs16Z8tQuUmf7XG8akRBM/jpLO+iUB9lWDJeJPdAPpQSBfDYNj3HLK7RkzHZUdaPFxctjOn7ni08fMf0BwXyonCXfedB182Kb+T7P6SAoVZYxu1wQ=  ;
Received: from [71.80.233.118] by web31804.mail.mud.yahoo.com via HTTP; Wed, 04 Oct 2006 23:48:17 PDT
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vejtnij5n.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28346>

--- Junio C Hamano <junkio@cox.net> wrote:
> I have to say the browser is seriously broken if whitespaces
> between <tr> and <td>, </td> and next <td>, </td> and </tr>
> makes a difference to its behaviour.  Aren't there a way to tell
> the browser to cut "visually"?  E.g. "The area I want to cut is

I'm not sure, I'm using latest Firefox.

> from this data column, and lines from here to there.  I do not
> want the leftmost two columns (commit-8 and lineno)".
> 
> I do not mind applying this, but that is only because it does
> not make its source any less readable.  It does make things
> harder to debug if somebody is debugging its output by reading
> the generated raw HTML, so it is not like there is no downside.

If you think that this could be a problem or affects negatively,
please don't apply.  cut-paste-edit is a small price to pay
as opposed to messing up the code and output.

> You might want to run links (or lynx) in screen ;-).  Screen
> supports left- (or right-, or both-sides) bounded cut which I
> find extremely useful.

Ok, I'll try that.

    Luben
