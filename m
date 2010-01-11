From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: How to check new commit availability without full fetch?
Date: Mon, 11 Jan 2010 12:59:24 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001111257300.10143@xanadu.home>
References: <ee2a733e1001100312j786108fct1b4c8abd0acc5afc@mail.gmail.com>
 <201001110831.28278.robin.rosenberg@dewire.com>
 <7vljg5ukol.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_da9wRvCXFfkhGmDmsl4IFQ)"
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, SLONIK.AZ@gmail.com,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 18:59:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUOY7-0000an-2J
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 18:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493Ab0AKR70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 12:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753412Ab0AKR70
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 12:59:26 -0500
Received: from relais.videotron.ca ([24.201.245.36]:25532 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753411Ab0AKR7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 12:59:25 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KW3004N0GN08X30@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 11 Jan 2010 12:59:25 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vljg5ukol.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136648>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_da9wRvCXFfkhGmDmsl4IFQ)
Content-type: TEXT/PLAIN; charset=utf-8
Content-transfer-encoding: 8BIT

On Mon, 11 Jan 2010, Junio C Hamano wrote:

> Robin Rosenberg <robin.rosenberg@dewire.com> writes:
> 
> > söndagen den 10 januari 2010 12.12.09 skrev  Leo Razoumov:
> >> Hi List,
> >> I am trying to find a way to check availability of new commits
> >> *before* doing fetch or pull. Unfortunately, neither fetch nor pull
> >> take "--dry-run" option (unlike push)
> >
> > Fetch has --dry-run. It's a fairly new option. The drawback is that it
> > still does the fetch, but it does not update the refs. If you re.run it
> > again it'll be quicker.
> 
> Doesn't that worry us if it really is quicker?
> 
> If --dry-run doesn't update the refs, why do the objects that were
> transferred by them not get asked the next time?  There must be a bug
> somewhere, but it is getting late already, so I'll leave it to experts in
> the transfer area to figure it out...

What about builtin-fetch.c:quickfetch() ?


Nicolas

--Boundary_(ID_da9wRvCXFfkhGmDmsl4IFQ)--
