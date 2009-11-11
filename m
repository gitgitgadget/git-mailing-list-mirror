From: Raman Gupta <rocketraman@fastmail.fm>
Subject: Re: [PATCHv2] Update gitworkflows man page to include release 	workflow
Date: Wed, 11 Nov 2009 10:23:26 -0500
Message-ID: <4AFAD6EE.3010205@fastmail.fm>
References: <1257869339-15999-1-git-send-email-rocketraman@fastmail.fm>	 <1257869339-15999-2-git-send-email-rocketraman@fastmail.fm> <a4c8a6d00911110505m2f21a787sfb3e0d6c130b0b4d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 16:30:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8F9f-0007kO-1t
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 16:30:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757337AbZKKPaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 10:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756217AbZKKPaJ
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 10:30:09 -0500
Received: from smtp102.rog.mail.re2.yahoo.com ([206.190.36.80]:46474 "HELO
	smtp102.rog.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757389AbZKKPaI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Nov 2009 10:30:08 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Nov 2009 10:30:07 EST
Received: (qmail 15366 invoked from network); 11 Nov 2009 15:23:33 -0000
Received: from CPE000db9166236-CM00186845d2ae.cpe.net.cable.rogers.com (rocketraman@99.224.155.40 with login)
        by smtp102.rog.mail.re2.yahoo.com with SMTP; 11 Nov 2009 07:23:33 -0800 PST
X-Yahoo-SMTP: 5CKRlKeswBAtrcX.EVB04BFKSgZiN0yKOK0iylIm064Zdzo-
X-YMail-OSG: uW18XQwVM1kwZx9xzOFBuO33ElhXjYshwKvpH.jVzToSQUKTAfBY0RRNj3GmEesBWQ--
X-Yahoo-Newman-Property: ymail-3
Received: from localhost (localhost.localdomain [127.0.0.1])
	by apollo.rocketraman.com (Postfix) with ESMTP id F153D21C05CC;
	Wed, 11 Nov 2009 10:23:32 -0500 (EST)
X-Virus-Scanned: amavisd-new at rocketraman.com
Received: from apollo.rocketraman.com ([127.0.0.1])
	by localhost (apollo.rocketraman.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bOI8kYGkEqmn; Wed, 11 Nov 2009 10:23:26 -0500 (EST)
Received: from [192.168.1.5] (zeus.rocketraman.com [192.168.1.5])
	by apollo.rocketraman.com (Postfix) with ESMTP id 5BEA921C058C;
	Wed, 11 Nov 2009 10:23:26 -0500 (EST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090825)
In-Reply-To: <a4c8a6d00911110505m2f21a787sfb3e0d6c130b0b4d@mail.gmail.com>
X-Enigmail-Version: 0.95.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132663>

Thiago Farina wrote:
> Hi,
> 
> On Tue, Nov 10, 2009 at 2:08 PM,  <rocketraman@fastmail.fm> wrote:
>> From: Raman Gupta <raman@rocketraman.com>
>>
>> The gitworkflows man page currently provides an overview of the workflows
>> used by git.git itself to serve as inspiration for people to use when
>> designing their own workflows. The current man page does a reasonable
>> job at describing the development process, but it does not contain any
>> guidance as to the workflow used for releases. Now add a basic
>> introduction to the branch management required for a release, so that a
>> reader may understand how the maint, master, next, and topic branches are
>> affected.
> Here
> http://git.kernel.org/?p=git/git.git;a=blob;f=Checklist.txt;h=37745f39487537117fb7f3a9a6f5b8e7d989a884;hb=refs/heads/todo
> there is a release checklist, maybe you could extend your patch to
> include more information from this?

Most of the checklist is specific to the git infrastructure rather
than git branch management. The latter is the focus of the
gitworkflows man page. The relevant items from checklist.txt (e.g.
merge 'maint' to 'master') are already included in the patch.

Cheers,
Raman
