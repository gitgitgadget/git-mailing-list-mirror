From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [JGIT PATCH 1/1] jgit: create a tag command
Date: Fri, 11 Jul 2008 09:45:16 +0100
Message-ID: <e2b179460807110145n4182978awd3aa3f97c3caac95@mail.gmail.com>
References: <200807070041.35873.robin.rosenberg.lists@dewire.com>
	 <200807070116.39892.robin.rosenberg.lists@dewire.com>
	 <e2b179460807100831g5d62a0a8nc7e7bf2715f0b9f1@mail.gmail.com>
	 <20080711020507.GD31862@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>,
	"Marek Zawirski" <marek.zawirski@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 10:46:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHEGh-0002dR-A9
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 10:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754913AbYGKIpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 04:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754734AbYGKIpT
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 04:45:19 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:24008 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754704AbYGKIpR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 04:45:17 -0400
Received: by rv-out-0506.google.com with SMTP id k40so4350643rvb.1
        for <git@vger.kernel.org>; Fri, 11 Jul 2008 01:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=aCufMWtBUj2yP2gw203z1d2VJR1+fKOsudVUUPRXbJ8=;
        b=rJYn2HnPKBBaGdCerxfdxHuEVspztREuS5DkWVDSDK1o3ZL1kvi+QdaxCGomXJN+cr
         j74Xav6GcqbtWeZ4hunYXCt2toZYwR9N1FiGZd6q+gYh+KGfzjzj/BoOUfQL73zdbVuo
         3oqDDtwvA7Vdi4y625GrzZulQ1Y0+ZSiBInpU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Peh3GH7sITRRiVdMBFn2TLhZpB4uowug9dYWmaN4EnMm3N+j1h/ZmsjynGvDLVICz9
         7t+zWzMwvl5+eBUnF4hlPm+h6GVSQoBbBse7aE7l3V/5IYeJp/wjiWKxkyjd//RHb1Kq
         Bp1cDXjf0RWCoSwzKws3ThzxC9wV/Rg6tDVm8=
Received: by 10.114.36.1 with SMTP id j1mr12668232waj.7.1215765916840;
        Fri, 11 Jul 2008 01:45:16 -0700 (PDT)
Received: by 10.141.19.11 with HTTP; Fri, 11 Jul 2008 01:45:16 -0700 (PDT)
In-Reply-To: <20080711020507.GD31862@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88098>

2008/7/11 Shawn O. Pearce <spearce@spearce.org>:
> Mike Ralphson <mike.ralphson@gmail.com> wrote:
>>
>> Loving the make_jgit stuff.
>
> So making jgit a single stand-alone, portable shell script for
> command line usage was a good idea?  ;-)

It certainly seems so to me. It's a nice quick way of seeing what's
implemented (I was toying with adding a jgit help command which would
reflect over the TextBuiltins).

I'm not sure which if any platforms would eventually be better off
with a commandline jgit than trying to port c-git though.

> I think we are at the point where we need to either write a
> #@!*(!@(! command line option parser, import one, or stop writing
> command line programs.  I would certainly appreciate any opinion
> you might have on the matter.

a) is a distraction, c) is a backwards step, so maybe b) wins.

I don't know what the state of the art of Java option parsers is but
there is a port of GNU getopt [1] which might drop in quite easily.

Mike

PS apologies for the patch format, I'm stuck with Outlook or gmail,
and a recalcitrant firewall for the moment.

[1] http://www.urbanophile.com/arenn/hacking/download.html
