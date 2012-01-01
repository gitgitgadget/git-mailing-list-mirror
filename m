From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: How to deal with historic tar-balls
Date: Sun, 1 Jan 2012 20:54:35 -0000
Organization: OPDS
Message-ID: <70916F7E9F934AD3A0DB00C8D6DB6751@PhilipOakley>
References: <4EFF5CDA.5050809@gmail.com> <4EFFA868.50605@dbservice.com> <B375E525C4704EA8807B5A59257B690B@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>
To: "Tomas Carnecky" <tom@dbservice.com>,
	"nn6eumtr" <nn6eumtr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 01 21:54:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RhSQU-0004jr-VY
	for gcvg-git-2@lo.gmane.org; Sun, 01 Jan 2012 21:54:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753009Ab2AAUyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jan 2012 15:54:38 -0500
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:29709 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752969Ab2AAUyh (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Jan 2012 15:54:37 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AjQQAJnHAE9cHIpO/2dsb2JhbABDggWDCoVNoXqBBoFtBQEBBAEIAQEZFR4BASEFBgIDBQIBAw4HAQICAgUhAgIUAQQaBgcXBgESCAIBAgMBh2kCowiQXoEviUozYwSNMZoF
X-IronPort-AV: E=Sophos;i="4.71,441,1320624000"; 
   d="scan'208";a="19934436"
Received: from host-92-28-138-78.as13285.net (HELO PhilipOakley) ([92.28.138.78])
  by out1.ip07ir2.opaltelecom.net with SMTP; 01 Jan 2012 20:54:35 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187831>

From: "Philip Oakley" <philipoakley@iee.org> Sent: Sunday, January 01, 2012 
6:30 PM
> From: "Tomas Carnecky" <tom@dbservice.com> Sent: Sunday, January 01, 2012
> 12:27 AM
>>On 12/31/11 8:04 PM, nn6eumtr wrote:
>>> I have a number of older projects that I want to bring into a git
>>> repository. They predate a lot of the popular scm systems, so they are
>>> primarily a collection of tarballs today.
> I'm doing a similar thing with a set of zip files. I grouped mine into
> batches for easier checking and putting on to separate branches. Planning
> your branch requirements is probably the biggest task, and will depend on
> how you hope to use the new repo.
>
<snip>
>> There is a script which will import sources from multiple tarballs,
>> creating a commit with the contents of each tarball. It's in the git
>> repository under contrib/fast-import/import-tars.perl.
> I wasn't aware of those scripts. I'll be having a look at the zip import
> script for my needs.

Is there a mechanism for either having fast-import respect a .gitignore,
or determining if a given file/path should be ignored?
My zips contain a lot of compile by-products that should be excluded from 
the repo.

> My extra problem is that almost all my zips have an extra top level
> directory that changes its name for every zip (but some don't..). The TLD
> changes confuses the git rename detection if I don't remove them before
> committing. Fortunately it's an internal development project with no 
> formal
> releases so creating the history is a bit of a personal project which
> doesn't affect ongoing development (which is the crunch question for
> fidelity of the repo you create).
>
>> tom
> Philip
