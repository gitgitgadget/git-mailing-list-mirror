From: Nick Triantos <nick@perceptivepixel.com>
Subject: Re: Roadmap to better handle big files?
Date: Wed, 24 Feb 2010 19:02:16 -0500
Message-ID: <2009C5FE-F0B7-4D64-BF5C-04087E17EDF1@perceptivepixel.com>
References: <B85968F5-E7C2-499D-A8BE-0160BA575F10@perceptivepixel.com>
 <m3fx4qmbwr.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 25 01:02:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkRBS-0006vm-8H
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 01:02:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758634Ab0BYACV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 19:02:21 -0500
Received: from relay.ihostexchange.net ([66.46.182.52]:44832 "EHLO
	relay.ihostexchange.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758523Ab0BYACU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Feb 2010 19:02:20 -0500
Received: from VMBX125.ihostexchange.net ([192.168.40.5]) by
 HUB102.ihostexchange.net ([66.46.182.52]) with mapi; Wed, 24 Feb 2010
 19:02:18 -0500
Thread-Topic: Roadmap to better handle big files?
Thread-Index: Acq1rcso6W3nUogORBKfr/PGidCTnA==
In-Reply-To: <m3fx4qmbwr.fsf@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141013>

Thanks.  I had looked at that project, but the logo being a piece of poop sort of scared me away from it (and it looked to be very early on in their design work so far)...

thanks!
-Nick

On Feb 24, 2010, at 3:51 PM, Jakub Narebski wrote:

> Nick Triantos <nick@perceptivepixel.com> writes:
> 
>> Is there any planned functionality to better support large files in
>> git?  (> 100MB / file)
>> 
>> We've been happily using git but we now have some files which we'd
>> very much like to have under the same version control as our source
>> code, and some of those files have been as large as 450MB/file.  We
>> are looking at chunking the file up before commiting it to git, but
>> is there any plan to better support chunking of these files during
>> repacks or other operations?  Right now, it appears either the whole
>> file, or the whole collection of files in a commit (not sure which)
>> can need to be resident in memory up to twice, from reading various
>> places on the web.  Our poor 32-bit server is barfing on this.  We
>> are going to put more RAM and a 64bit OS on the machine, but this
>> still seems like an unnecessary design decision.
> 
> Git has a roadmap???
> 
> More seriously, take a look at git-bigfiles project (fork):
> http://caca.zoy.org/wiki/git-bigfiles
> 
> HTH
> --
> Jakub Narebski
> Poland
> ShadeHawk on #git
