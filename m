From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: RE: GIT for Microsoft Access projects
Date: Mon, 8 Jun 2015 18:02:05 -0400
Message-ID: <002c01d0a236$c2504ac0$46f0e040$@nexbridge.com>
References: <20150608094517.GY06Y.31914.root@txifep02> <20150608191458.9f6a93b0259a8ca0324c8dc0@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Konstantin Khomoutov'" <kostix+git@007spb.ru>,
	<hackerp@suddenlink.net>
X-From: git-owner@vger.kernel.org Tue Jun 09 00:02:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2584-0006DZ-BC
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 00:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbbFHWCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 18:02:44 -0400
Received: from elephants.elehost.com ([216.66.27.132]:53285 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753080AbbFHWCn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 18:02:43 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE0023eb577e25-CM602ad06c91a7.cpe.net.cable.rogers.com [99.237.128.150])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id t58M262q034479
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 8 Jun 2015 18:02:06 -0400 (EDT)
	(envelope-from rsbecker@nexbridge.com)
In-Reply-To: <20150608191458.9f6a93b0259a8ca0324c8dc0@domain007.com>
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJ1O8TIRXsxkof8bOQehMb8HIcVxgDDgJp9nFPZMDA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271138>

> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of Konstantin Khomoutov
> Sent: June 8, 2015 12:15 PM
> To: hackerp@suddenlink.net
> Cc: git@vger.kernel.org
> Subject: Re: GIT for Microsoft Access projects
> 
> On Mon, 8 Jun 2015 9:45:17 -0500
> <hackerp@suddenlink.net> wrote:
> 
> [...]
> > My question is, will GIT work with MS access forms, queries, tables,
> > modules, etc?
> [...]
> 
> Git works with files.  So in principle it will work with *files*
> containing your MS access stuff.
> 
> But Git will consider and treat those files as opaque blobs of data.
> That is, you will get no "fancy diffing" like asking Git to graphically
> (or otherwise) show you what exact changes have been made to a
> particular form or query between versions X and Y of a given MS access
> document -- all it will be able to show you is commit messages
> describing those changes.
> 
> So... If you're fine with this setting, Git will work for you,
> but if not, it won't.
> 
> One last note: are you really sure you want an SCM/VCS tool to manage
> your files and not a document management system (DMS) instead?
> I mean stuff like Alfresco (free software by the way) and the like.

Consider also what you are specifically managing in MS Access. Are you
looking for management of configuration data, like settings, properties, and
such, or is this transactional or user-related. If managing
environment-specific content, it may be worth storing raw SQL INSERT
statements, with appropriate variable references, or export to XML/CSV, and
having those in git so that the purpose for configuration-like data can be
explained and diff'ed.
