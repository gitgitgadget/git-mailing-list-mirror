From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] filter-branch.sh: support nearly proper tag name
 filtering
Date: Thu, 20 Mar 2008 18:14:45 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803201812560.4124@racer.site>
References: <1206031893-29599-1-git-send-email-casey@nrlssc.navy.mil> <47E298A5.6050508@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Mar 20 18:15:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcOMR-0005jT-2R
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 18:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757252AbYCTROr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 13:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757149AbYCTROr
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 13:14:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:46601 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755958AbYCTROq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 13:14:46 -0400
Received: (qmail invoked by alias); 20 Mar 2008 17:14:44 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 20 Mar 2008 18:14:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/lj2svMwzl0zBTKHcBZ3ubHaMabeAtz+/2uWW5/U
	9WA/bbiv8V5PWS
X-X-Sender: gene099@racer.site
In-Reply-To: <47E298A5.6050508@nrlssc.navy.mil>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77677>

Hi,

On Thu, 20 Mar 2008, Brandon Casey wrote:

> Add support for creating a new tag object and retaining the tag message, 
> author, and date when rewriting tags. The gpg signature, if one exists, 
> will be stripped.
> 
> This adds nearly proper tag name filtering to filter-branch. Proper tag 
> name filtering would include the ability to change the tagger, tag date, 
> tag message, and _not_ strip a gpg signature if the tag did not change.

I think such a change in semantics merits a new option.  Maybe 
even something like

	"--rewrite-tags=(strip-signatures|redo-signatures|no-signed)"

or some such.  But maybe not; to rewrite a tag, you have to specify it 
explicitely (or implicitely with --all).

Ciao,
Dscho
