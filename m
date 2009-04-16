From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: add -e, was Re: What's cooking in git.git (Apr 2009, #02; Sun,
 12)
Date: Thu, 16 Apr 2009 15:12:04 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904161510080.6798@intel-tinevez-2-302>
References: <7vvdp9w9l1.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0904141943060.10279@pacific.mpi-cbg.de> <7vhc0r3wpq.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0904142224030.10279@pacific.mpi-cbg.de>
 <7v7i1m3m1m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 16 15:13:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuRPR-0005rB-Hy
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 15:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755750AbZDPNMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 09:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755549AbZDPNMJ
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 09:12:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:44718 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755569AbZDPNMG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 09:12:06 -0400
Received: (qmail invoked by alias); 16 Apr 2009 13:12:04 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp020) with SMTP; 16 Apr 2009 15:12:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ME9Zn05HMc7wDqq4TDimHlQvrzEij3zHDXHM81P
	qAFxRsn3cJFEoB
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7v7i1m3m1m.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116698>

Hi,

On Tue, 14 Apr 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Actually, I am beginning to hate the idea of having this in add -e, 
> > but would prefer it to be in apply ("git apply $PATCH" could -- and 
> > should -- complain when not being called with --unidiff-zero and 
> > encountering a patch that should (but does not) have common context 
> > lines).
> 
> I think it already complains by rejecting.  The thing is, only "add -e" 
> knows that the patch being fed to apply is potentially manually corrupt 
> by the end user.

I think that this extra-check for missing context lines is a substantial 
amount of work for little use, as the most common mistakes are other 
things, and _they_ will be hard to catch, as I illustrated.

So, how about adding a warning before the beginning of the patch instead?

Ciao,
Dscho
