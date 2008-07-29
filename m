From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2 v2] run-command (Windows): Run dashless "git <cmd>"
 (solves part of problem with system_path)
Date: Tue, 29 Jul 2008 13:13:08 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807291310390.4631@eeepc-johanness>
References: <BF5B7CBE-ACA8-4D81-8FC0-8A7901205854@zib.de> <1217308647-23673-1-git-send-email-prohaska@zib.de> <20080729052459.GC11947@spearce.org> <7v4p69meka.fsf@gitster.siamese.dyndns.org> <42EF8777-BABC-4757-AD49-627320F24D39@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Jul 29 13:13:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNn8a-0000Va-Gr
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 13:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755038AbYG2LME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 07:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755106AbYG2LMD
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 07:12:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:58809 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754984AbYG2LMB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 07:12:01 -0400
Received: (qmail invoked by alias); 29 Jul 2008 11:11:59 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp045) with SMTP; 29 Jul 2008 13:11:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/xckNZKuLxAvzN+RqOHCYNvaluWn5+FG8Bu1UDsS
	TREcuzweUE6H9l
X-X-Sender: user@eeepc-johanness
In-Reply-To: <42EF8777-BABC-4757-AD49-627320F24D39@zib.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90614>

Hi,

On Tue, 29 Jul 2008, Steffen Prohaska wrote:

> On Jul 29, 2008, at 7:42 AM, Junio C Hamano wrote:
> 
> >   We prefer running the dashless form, and POSIX side already does so; 
> >   we should use it in MinGW's start_command(), too.
> 
> Thanks for reading my mind ;-)  This was the alternative justification I 
> had in mind after reading my patch again.

Well, given that the justification you gave had the obvious flaw -- which 
you even pointed out -- that non-builtins are _still_ affected, i.e. that 
you leave that bug unfixed (but your description purports that you want to 
fix that bug), it would have been wiser to give the alternative 
justification, which makes the commit obviously correct.

Ciao,
Dscho
