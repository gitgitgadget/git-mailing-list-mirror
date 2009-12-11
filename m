From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/6] GITWEB - Missmatching git w/ gitweb
Date: Fri, 11 Dec 2009 13:49:39 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0912111346070.4985@pacific.mpi-cbg.de>
References: <1260488743-25855-1-git-send-email-warthog9@kernel.org> <1260488743-25855-2-git-send-email-warthog9@kernel.org> <1260488743-25855-3-git-send-email-warthog9@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>
To: John 'Warthog9' Hawley <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 11 13:45:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJ4s4-0008Oy-EE
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 13:45:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753007AbZLKMpD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2009 07:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752683AbZLKMpD
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 07:45:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:58309 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751543AbZLKMpB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 07:45:01 -0500
Received: (qmail invoked by alias); 11 Dec 2009 12:45:07 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp068) with SMTP; 11 Dec 2009 13:45:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19k4bhuDodkGa0cgHbWemoN1V/RoD0gwTQBgRHgTi
	lEN6oghGT1BRzx
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1260488743-25855-3-git-send-email-warthog9@kernel.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135083>

Hi,

On Thu, 10 Dec 2009, John 'Warthog9' Hawley wrote:

> This adds $missmatch_git so that gitweb can run with a miss-matched
> git install.

I'm not a native English speaker and all, but I thought it was spelt 
'mismatch', i.e. with only one 's'.  Maybe even name it 
'allow_different_git_version' or 'no_strict_git_version'.

A few comments on the patch: the style of the if() statement disagrees 
with the other ones; please use the same style.

Also, as with 1/6, turning off the feature might be better done by setting 
it to undef.

Finally, would it not be nicer if the warning really was only a warning, 
i.e. that the script would try to continue after giving the users a pretty 
warning header?

Ciao,
Dscho
