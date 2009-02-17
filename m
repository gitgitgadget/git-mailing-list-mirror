From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 3/8] config: Use parseopt.
Date: Tue, 17 Feb 2009 12:55:38 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902171255220.6185@intel-tinevez-2-302>
References: <1234832094-15541-1-git-send-email-felipe.contreras@gmail.com>  <1234832094-15541-2-git-send-email-felipe.contreras@gmail.com>  <1234832094-15541-3-git-send-email-felipe.contreras@gmail.com>  <7vab8laa7p.fsf@gitster.siamese.dyndns.org>
 <94a0d4530902170235g4e481e07t39a6157894dff9aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 12:57:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZOZa-0000tB-Sj
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 12:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754040AbZBQLzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 06:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753675AbZBQLzm
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 06:55:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:50275 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753501AbZBQLzl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 06:55:41 -0500
Received: (qmail invoked by alias); 17 Feb 2009 11:55:39 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp057) with SMTP; 17 Feb 2009 12:55:39 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19fS5lvFqlfrx9eHpzoSHkwQoP2POiDY4V/Jywg7t
	H+UHovRbacLmYK
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <94a0d4530902170235g4e481e07t39a6157894dff9aa@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110361>

Hi,

On Tue, 17 Feb 2009, Felipe Contreras wrote:

> On Tue, Feb 17, 2009 at 7:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > I've queued the entire series on top of fc/config-editor topic and even
> > merged the result in 'pu' once, but I had to reintegrate 'pu' without the
> > series.
> >
> > Before this commit, t/t1300-repo-config.sh passes, but this one breaks
> > the test.
> 
> Ah, I didn't know there was a test for that.
> 
> I've fixed most the issues but unfortunately parseopt barfs when -1 is
> used as an argument. That should be fixed somehow, otherwise this
> patch will never pass the test.

Have you seen PARSE_OPT_STOP_AT_NON_OPTION?

Ciao,
Dscho
