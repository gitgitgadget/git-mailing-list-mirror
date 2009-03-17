From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: push.default, was Re: What's cooking in git.git (Mar 2009, #04; Sat,
 14)
Date: Tue, 17 Mar 2009 11:28:31 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903171125420.6393@intel-tinevez-2-302>
References: <7vr60z8fkl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 11:30:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjWYh-0000FN-FR
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 11:30:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759005AbZCQK2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 06:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757349AbZCQK2i
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 06:28:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:45136 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754231AbZCQK2i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 06:28:38 -0400
Received: (qmail invoked by alias); 17 Mar 2009 10:28:35 -0000
Received: from unknown (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp070) with SMTP; 17 Mar 2009 11:28:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19+bcA0jk1+ISS61Vh7ndfSEv7Kn0WnF72Ka2C3fj
	mSa5Vu814HAIgo
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vr60z8fkl.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113452>

Hi,

On Sat, 14 Mar 2009, Junio C Hamano wrote:

> * fg/push-default (Wed Mar 11 23:01:45 2009 +0100) 1 commit
>  - New config push.default to decide default behavior for push
> 
> Replaced the old series with the first step to allow a smooth 
> transition. Some might argue that this should not give any warning but 
> just give users this new configuration to play with first, and after we 
> know we are going to switch default some day, start the warning.

IIRC Steffen posted a patch series earlier, where he initialized 
remote.origin.push upon clone (I am not sure if he provided a 
corresponding patch for checkout --track), but personally, I think that 
would be nicer than having a push.default.

Ciao,
Dscho
