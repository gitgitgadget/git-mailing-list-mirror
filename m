From: Magnus =?iso-8859-1?Q?B=E4ck?= <magnus.back@sonyericsson.com>
Subject: Re: how can i read git repository information.
Date: Thu, 29 Dec 2011 09:21:00 +0100
Message-ID: <20111229082100.GB1624@jpl.local>
References: <1325139370841-7134908.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: sp <sonali.treewalker@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 29 09:21:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RgBEm-0004sD-QN
	for gcvg-git-2@lo.gmane.org; Thu, 29 Dec 2011 09:21:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836Ab1L2IVR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Dec 2011 03:21:17 -0500
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:35911 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761Ab1L2IVP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Dec 2011 03:21:15 -0500
Received: from ipb5.telenor.se (ipb5.telenor.se [195.54.127.168])
	by smtprelay-b12.telenor.se (Postfix) with ESMTP id CB0F9C418
	for <git@vger.kernel.org>; Thu, 29 Dec 2011 09:21:13 +0100 (CET)
X-SMTPAUTH-B2: [b627879]
X-SENDER-IP: [83.227.167.132]
X-LISTENER: [smtp.bredband.net]
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: An4LAEsi/E5T46eEPGdsb2JhbABDiVaSKJBlGQEBAQE3MoFyAQEEATIBIyMFCws0EhQNCwEMChoTh3oCtSKLLGMElQGKcIdG
X-IronPort-AV: E=Sophos;i="4.71,425,1320620400"; 
   d="scan'208";a="19430727"
Received: from ua-83-227-167-132.cust.bredbandsbolaget.se (HELO elwood.jpl.local) ([83.227.167.132])
  by ipb5.telenor.se with ESMTP; 29 Dec 2011 09:21:02 +0100
Received: by elwood.jpl.local (Postfix, from userid 1000)
	id 179B24242C; Thu, 29 Dec 2011 09:21:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1325139370841-7134908.post@n2.nabble.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187776>

On Thursday, December 29, 2011 at 07:16 CET,
     sp <sonali.treewalker@gmail.com> wrote:

> i new to git.i have git repository folder of one existing project.
> i want to read git repository files from that folder but when i
> open that file in notepad ++ it shows some encoded information,,

Which file are you attempting to open? What is it that you
want to do?

A non-bare git repository consists of the working tree files
(i.e. the files you keep under version control) and the files
in the .git directory. Most of the latter files aren't meant
for human consumption but are used internally by Git for
bookkeeping purposes. Opening them in a text editor won't be
useful.

--=20
Magnus B=E4ck                   Opinions are my own and do not necessar=
ily
SW Configuration Manager      represent the ones of my employer, etc.
Sony Ericsson
