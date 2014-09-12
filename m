From: "Edward Z. Yang" <ezyang@mit.edu>
Subject: Re: Diffs for submodule conflicts during rebase usually empty
Date: Fri, 12 Sep 2014 09:03:34 -0400
Message-ID: <1410526589-sup-2306@sabre>
References: <20140911135057.o7j9bwlnz4okgwsw@webmail.mit.edu> <5411F818.6030701@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Sep 12 15:08:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSQaj-00030B-NF
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 15:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754627AbaILNIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 09:08:41 -0400
Received: from dmz-mailsec-scanner-3.mit.edu ([18.9.25.14]:42770 "EHLO
	dmz-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753967AbaILNIk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Sep 2014 09:08:40 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Sep 2014 09:08:40 EDT
X-AuditID: 1209190e-f79d46d000003643-7a-5412ef2baa1b
Received: from mailhub-auth-1.mit.edu ( [18.9.21.35])
	(using TLS with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by dmz-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id E3.3E.13891.B2FE2145; Fri, 12 Sep 2014 09:03:39 -0400 (EDT)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id s8CD3cj9005281;
	Fri, 12 Sep 2014 09:03:39 -0400
Received: from localhost (ool-18b93804.dyn.optonline.net [24.185.56.4])
	(authenticated bits=0)
        (User authenticated as ezyang@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id s8CD3bsN017063;
	Fri, 12 Sep 2014 09:03:38 -0400
In-reply-to: <5411F818.6030701@web.de>
User-Agent: Sup/git
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsUixCmqrKv9XijE4O5TDYuuK91MFhOnLWZ2
	YPL4vEnO4/azbSwBTFFcNimpOZllqUX6dglcGV0HCwpmcVR0/JrC2MC4l62LkZNDQsBEYueG
	a0wQtpjEhXvrgeJcHEICs5kkNn44zgjhbGSUaP9wGKxDSOAvo8SPJ3FdjBwczALqEuvnCYGE
	2YDMSX83gg0SEVCTuLSlkwmiRFbi8VlVkLCwgJvEwo0rWUFsTqCS3uYZUBPDJZavXgYWZxFQ
	lbiwYxeYzQs0snv6AzBbVEBY4smRZmYQm1lAXqJ562zmCYwCsxCOmIUks4CRaRWjbEpulW5u
	YmZOcWqybnFyYl5eapGusV5uZoleakrpJkZwGEry7WD8elDpEKMAB6MSD28Fi2CIEGtiWXFl
	7iFGSQ4mJVHevHtCIUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeG+8AsrxpiRWVqUW5cOkpDlY
	lMR5N/3gCxESSE8sSc1OTS1ILYLJynBwKEnwSr8DahQsSk1PrUjLzClBSDNxcIIM5wEangpS
	w1tckJhbnJkOkT/FqMuxrvNbP5MQS15+XqqUOO+ft0BFAiBFGaV5cHNg6eMVozjQW8K8v0Gq
	eICpB27SK6AlTEBL3s0BW1KSiJCSamCcOqdj5ZGnmnY24UZB57deubkzVfrZH/09/czs93me
	391+Qa/fyfyw0r39a8ps78ir3Kp0EJt29OMJ/qYd1bHiRWLtR8/u+LL4y6T30UFfHzkppX2d
	uEgsceWpcLnTTEI9Yea7PGwivz+SVjAp9+p/s20Xc86kuhapgIsJR3LdStiXnVhg 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256919>

Hello Jens,

Excerpts from Jens Lehmann's message of 2014-09-11 15:29:28 -0400:
> Git does know what's going on, just fails to display it properly
> in the diff, as the output of ls-files shows:
> 
>     $git ls-files -u
>     160000 6a6e215138b7f343fba67ba1b6ffc152019c6085 1    b
>     160000 fc12d3455b120916ec508c3ccd04f23957c08ea5 2    b
>     160000 33d9fa9f9e25de2a85f84993d8f6c752f84c769a 3    b

Right. But I'd also add that even though Git knows what's going
on, even if we reported /that/ it wouldn't be user friendly:
namely, because submodules are not updated automatically so the
first line would always be what the submodule was pointed to
before we started rebasing.  That's not so useful either...

> I agree that this needs to be improved, but am currently lacking
> the time to do it myself. But I believe this will get important
> rather soonish when we recursively update submodules too ...

As I've said, I'm happy to contribute a patch, if we can agree
what the right resolution is...

Cheers,
Edward
