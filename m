From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v3] Document pack v4 format
Date: Fri, 06 Sep 2013 09:25:45 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309060922020.20709@syhkavp.arg>
References: <1377917393-28460-1-git-send-email-pclouds@gmail.com>
 <1378433643-15638-1-git-send-email-pclouds@gmail.com>
 <alpine.LFD.2.03.1309052319310.20709@syhkavp.arg>
 <CACsJy8AWa0NFViO+3Cnp_0Gqzqidcbx9vPd1wxCuY1jjWhyFaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_ewn/ipplixMj6AcIRNnWsQ)"
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 15:25:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHw2u-00042l-Tp
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 15:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581Ab3IFNZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 09:25:53 -0400
Received: from relais.videotron.ca ([24.201.245.36]:61364 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707Ab3IFNZw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 09:25:52 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSP000FSHAYJH10@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 06 Sep 2013 09:25:46 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 223002DA0547; Fri, 06 Sep 2013 09:25:46 -0400 (EDT)
In-reply-to: <CACsJy8AWa0NFViO+3Cnp_0Gqzqidcbx9vPd1wxCuY1jjWhyFaQ@mail.gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234049>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_ewn/ipplixMj6AcIRNnWsQ)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Fri, 6 Sep 2013, Duy Nguyen wrote:

> On Fri, Sep 6, 2013 at 10:23 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Fri, 6 Sep 2013, Nguy­n Thái Ng÷c Duy wrote:
> >
> >>
> >> Signed-off-by: Nguy­n Thái Ng÷c Duy <pclouds@gmail.com>
> >> ---
> >>  Should be up to date with Nico's latest implementation and also cover
> >>  additions to the format that everybody seems to agree on:
> >>
> >>   - new types for canonical trees and commits
> >>   - sha-1 table covering missing objects in thin packs
> >
> > Great!  I've merged this into my branch with the following amendment:
> 
> I'd like to propose another change in the format to basically limit
> the use of sha1ref format "\0<SHA-1>" to tree entries only. All forms
> of deltas must have non-zero sha1 index (i.e. reference to SHA-1
> table). It will simplify handling code, and I think it makes sense too

Why?

This is still some artificial limitation and I tend not to like them.

"Simplifying handling code" is not a good enough reason on its own, 
especially if it reduce flexibility for possible future layout 
optimizations.

In what way is the code more difficult?


Nicolas

--Boundary_(ID_ewn/ipplixMj6AcIRNnWsQ)--
