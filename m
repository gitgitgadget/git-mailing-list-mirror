From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Google Summer of Code 2009: GIT
Date: Wed, 11 Mar 2009 01:56:30 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0903110147270.19665@iabervon.org>
References: <49B74373.3090609@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Saurabh Gupta <saurabhgupta1403@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 06:58:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhHS6-00008c-Sh
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 06:58:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbZCKF4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 01:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbZCKF4d
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 01:56:33 -0400
Received: from iabervon.org ([66.92.72.58]:34331 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751515AbZCKF4d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 01:56:33 -0400
Received: (qmail 1432 invoked by uid 1000); 11 Mar 2009 05:56:30 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Mar 2009 05:56:30 -0000
In-Reply-To: <49B74373.3090609@gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112886>

On Wed, 11 Mar 2009, Saurabh Gupta wrote:

> hello everyone,
> 
> /*First, a brief introduction about me: */
> I am Saurabh Gupta from India. I am a senior engineering student. I
> have been working for open source projects for a long time and I was a
> *GSoC student in 2008* where I successfully completed my project under
> the organization Openmoko (www.openmoko.org
> <http://www.openmoko.org/>). In 2008 winters, I had my internship at
> *Adobe Inc.* where I worked on the package  management system using
> C++ and sqlite library. I have a long experience in programming in C,
> C++,  Python and other languages. Currently, my final year project at
> university is about the automatic data logging system in which I am
> working upon socket programming in C, C++,   MYSQL and setting up an
> intra-college website using LAMP. I am a user of svn extensively and
> use git sometimes.
> 
> 
> /*About GSoC GIT ideas;
> */Here are the ideas which I found to be interested in. Although, I
> would like to discuss any other idea than these in GIT organization.
> 
> *1) Domain specific merge helpers*
> Intelligence in the merger can be put which modifies the source file
> according the format. Different file formats can be put in the merger
> to support.

This is something I've thought would be really handy for making git more 
widely useful. The hard part, of course, is coming up with useful 
alternative merge algorithms which work for formats that the usual merge 
doesn't handle. The infrastructure is mostly there (git supports declaring 
the types of files), but there's no point in support for running a 
type-specific merger until there are actually type-specific mergers to 
run.

Do you have ideas on what formats you'd try to merge, and how?

	-Daniel
*This .sig left intentionally blank*
