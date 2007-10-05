From: "Medve Emilian-EMMEDVE1" <Emilian.Medve@freescale.com>
Subject: RE: [ALTERNATE PATCH] Add a simple option parser.
Date: Fri, 5 Oct 2007 09:41:48 -0700
Message-ID: <598D5675D34BE349929AF5EDE9B03E270162501A@az33exm24.fsl.freescale.net>
References: <1191447902-27326-1-git-send-email-krh@redhat.com> <20071005142140.GK19879@artemis.corp> <20071005142507.GL19879@artemis.corp> <20071005143014.GA18176@glandium.org> <20071005144540.GM19879@artemis.corp> <598D5675D34BE349929AF5EDE9B03E2701624FD6@az33exm24.fsl.freescale.net> <20071005155647.GC20305@artemis.corp> <598D5675D34BE349929AF5EDE9B03E2701624FF2@az33exm24.fsl.freescale.net> <alpine.LFD.0.999.0710050924530.23684@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Pierre Habouzit" <madcoder@debian.org>,
	"Mike Hommey" <mh@glandium.org>,
	"Kristian H?gsberg" <krh@redhat.com>, <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Oct 05 18:42:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdqFY-00047V-Id
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 18:42:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756576AbXJEQl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 12:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756558AbXJEQl5
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 12:41:57 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:40918 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756615AbXJEQl4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Oct 2007 12:41:56 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id l95GfnUr024531
	for <git@vger.kernel.org>; Fri, 5 Oct 2007 09:41:49 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net [10.64.32.14])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l95Gfm87003977
	for <git@vger.kernel.org>; Fri, 5 Oct 2007 11:41:48 -0500 (CDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <alpine.LFD.0.999.0710050924530.23684@woody.linux-foundation.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ALTERNATE PATCH] Add a simple option parser.
Thread-Index: AcgHbN6I5hSTyr6CQ46dMv9HMa4LqQAAXe8g
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60110>

Hello Linus,


> On Fri, 5 Oct 2007, Medve Emilian-EMMEDVE1 wrote:
> > > 
> > >   Because it's GNU and that it's a heavy dependency to begin with.
> > 
> > So it's more of a political decision then a technical one?
> 
> I'd *strongly* argue against new dependencies unless they buy us 
> something major.
> 
> We've been good at cutting them down, including any required 
> libraries 
> internally. We shouldn't add new ones.
> 
> So we'd have to include GNU getopt sources with the git tree, 
> at which 
> point any advantage would be gone. Might as well include a 
> private and 
> simpler version of our own.


>From what I understand argp is part of glibc.


Cheers,
Emil.
