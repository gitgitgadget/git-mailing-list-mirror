From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Google Summer of Code 2009: GIT
Date: Thu, 19 Mar 2009 11:24:18 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903191119340.10279@pacific.mpi-cbg.de>
References: <49B74373.3090609@gmail.com>  <7veix33f5e.fsf@gitster.siamese.dyndns.org>  <ab9fa62a0903120545o7e5bc359g7df233b00858869c@mail.gmail.com>  <alpine.DEB.1.10.0903121052310.16753@asgard.lang.hm>  <ab9fa62a0903121119j6c2a1d43kd9cda99db47b5e7c@mail.gmail.com>
  <alpine.DEB.1.10.0903121148540.16753@asgard.lang.hm>  <ab9fa62a0903121200v73ec3522gcdebcd34122efc72@mail.gmail.com>  <alpine.DEB.1.10.0903121214390.16753@asgard.lang.hm>  <ab9fa62a0903121245m621643bfq3c58557ccc9b266f@mail.gmail.com> 
 <alpine.DEB.1.10.0903121255040.16753@asgard.lang.hm> <ab9fa62a0903121303v5a6cbf0ax413cc440b9c32e77@mail.gmail.com> <alpine.DEB.1.00.0903190003100.10279@pacific.mpi-cbg.de> <alpine.DEB.1.10.0903181645440.16753@asgard.lang.hm> <alpine.DEB.1.00.0903190141300.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.10.0903190129110.4560@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: saurabh gupta <saurabhgupta1403@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Thu Mar 19 11:24:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkFPy-0006u6-5i
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 11:24:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756246AbZCSKW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 06:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755979AbZCSKW0
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 06:22:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:46167 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756498AbZCSKWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 06:22:25 -0400
Received: (qmail invoked by alias); 19 Mar 2009 10:22:22 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp062) with SMTP; 19 Mar 2009 11:22:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/bTmli1Zjbctr10jC+U4y1ZcaiKu/wws4oVPgBbG
	hnM03ozJCrqcP/
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.10.0903190129110.4560@asgard.lang.hm>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113746>

Hi,

On Thu, 19 Mar 2009, david@lang.hm wrote:

> all three formats mentioned here (OOXML, ODF, SVG) are XML-based formats 
> and a single flexible XML merge driver could potentially handle all 
> three (as well as other formats). for that matter, the ODF specs cover 
> multiple types of data, and I suspect that appropriate conflict markers 
> for text could well end up being different than the ones for 
> spreadsheets.

You are misunderstanding me.

The fact that all three are XML based has nothing to do with the _real_ 
goal of the project.

IOW a user trying to 3-way-merge ODF files could not care less if the 
underlying technical details involve having an extra merge driver for XML 
files or not.

The user cares about the ease of use, about the user interface.  That is 
what I want to focus on.

And if we end up with a beautiful XML merge driver at the end of the 
summer that nobody uses, I will be not only a little disappointed.

So let's look at the _nature_ of the data at hand, i.e. text, marked-up 
text, images (we could include UML, which is also XML-based, and where the 
XML merge driver is as relevant for the user experience as for the 
others), and how to make it _easy_ to resolve merge conflicts there.

Ciao,
Dscho
