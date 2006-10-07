From: Panagiotis Issaris <takis.issaris@uhasselt.be>
Subject: Re: [RFC PATCH] Add WEBDAV timeout to http-fetch.
Date: Sat, 7 Oct 2006 21:35:59 +0200
Message-ID: <20061007193559.GA27920@poseidon.issaris.org>
References: <20061006212616.GA5175@lumumba.uhasselt.be> <20061006220542.GA5890@lumumba.uhasselt.be> <BAYC1-PASMTP08A34A8FB0703E4D2ABAF9AE130@CEZ.ICE> <BAYC1-PASMTP11CF83A008B0B3BA5F6B15AE100@CEZ.ICE> <7viriwsa75.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org,
	Panagiotis Issaris <takis@lumumba.uhasselt.be>,
	Nick Hengeveld <nickh@reactrix.com>
X-From: git-owner@vger.kernel.org Sat Oct 07 21:36:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWHy5-0001LI-MY
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 21:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932787AbWJGTgP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 15:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932788AbWJGTgP
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 15:36:15 -0400
Received: from outmx005.isp.belgacom.be ([195.238.4.102]:42688 "EHLO
	outmx005.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S932787AbWJGTgO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Oct 2006 15:36:14 -0400
Received: from outmx005.isp.belgacom.be (localhost [127.0.0.1])
        by outmx005.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22) with ESMTP id k97Ja4YC016727
        for <git@vger.kernel.org>; Sat, 7 Oct 2006 21:36:05 +0200
        (envelope-from <takis.issaris@uhasselt.be>)
Received: from localhost ([87.67.7.243])
        by outmx005.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22) with ESMTP id k97JZv6G016663;
	Sat, 7 Oct 2006 21:35:57 +0200
        (envelope-from <takis.issaris@uhasselt.be>)
Received: by localhost (Postfix, from userid 1000)
	id 46E4D8C6A1; Sat,  7 Oct 2006 21:35:59 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7viriwsa75.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28502>

Hi,

On Sat, Oct 07, 2006 at 03:15:58AM -0700, Junio C Hamano wrote:
> > This patch sets the CURL timeout to two minutes so that things proceed
> > sooner.  Even with this patch it takes two extra minutes of "dead time"
> > to complete all operations; obivously this still sucks.
> >
> > However, I don't know if the two minute timeout is long enough for
> > all cases with a server where WEBDAV is functioning properly.
> > Hopefully someone who knows more about Curl can comment and perhaps
> > offer another solution.
> >
> > Maybe the real solution is just to figure out and fix whatever is
> > going on with the WEBDAV server and forget this patch.
> 
> I think it is prudent to protect the client from a broken server
> and it is independent from "fixing" the server side.  It would
>[...]
Wouldn't most users ctrl-c the program before the two minute timeout occurs?
Especially since their appears to be nothing happening?

With friendly regards,
Takis
 
