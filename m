From: Schuyler Duveen <sduveen@nypublicradio.org>
Subject: Re: git cascade and git forward-merge
Date: Tue, 29 Apr 2014 23:01:14 +0000
Message-ID: <3C0A37210D5D044AB99EEAE13ADA186B08DAB8@NYPRMBX03.WNYC.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "ram@rachum.com" <ram@rachum.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 30 01:06:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfH6t-0008Q6-H1
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 01:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756090AbaD2XGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 19:06:42 -0400
Received: from smtp.nypublicradio.org ([209.201.52.210]:48916 "EHLO
	smtp.wnyc.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755874AbaD2XGk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Apr 2014 19:06:40 -0400
X-Greylist: delayed 324 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Apr 2014 19:06:40 EDT
Received: from NYPRMBX03.WNYC.ORG ([fe80::8d1f:3116:9c8f:4c8]) by
 NYPRCAS02.WNYC.ORG ([::1]) with mapi id 14.03.0181.006; Tue, 29 Apr 2014
 19:01:15 -0400
Thread-Topic: git cascade and git forward-merge
Thread-Index: Ac9j/WnRub6WYcETTJqLoGaqY684YQ==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.100.132]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247663>

This was a feature that I've really wanted for a while.  I took a bit of time to morph the most conservative version of forward-merge into pure-shell script:

https://github.com/schuyler1d/git-forward-merge/

Without strong objections, I'm going to try to make this into a patch for core.

cheers,
Schuyler Duveen

> Hi guys!
>
> I just made two Git scripts of mine open-source:
> 
>https://github.com/cool-RR/git-cascade 
> <https://github.com/cool-RR/git-cascade>
>
> This project contains two scripts:
>
>  - git cascade - Cascade changes from each branch to its dependents.
>  - git forward-merge - Merge branches without checking them out.
>
> Click the GitHub link above to read all about them.
>
>
> Thanks,
> Ram.