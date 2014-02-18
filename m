From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] Git release notes man page
Date: Tue, 18 Feb 2014 22:54:15 -0000
Organization: OPDS
Message-ID: <1EC26D492ABB45FF8C399F84B1E30817@PhilipOakley>
References: <1392460179-776-1-git-send-email-philipoakley@iee.org> <xmqqha7wcbkz.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>,
	"Stefan Nwe" <stefan.naewe@atlas-elektronik.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 18 23:54:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFtYv-0000NG-O4
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 23:54:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbaBRWy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 17:54:28 -0500
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:53286 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751217AbaBRWy0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Feb 2014 17:54:26 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApVHAFvkA1MCYJCb/2dsb2JhbABZgwZIA4kEt3wBAgEBC4EVF3SCIAUBAQQBCAEBLh4BASEFBgIDBQIBAxUMJRQBBBoGBxcGEwgCAQIDAYdsDMV5hnGOZDWCdoEUBIkQhhqbKoMtPA
X-IPAS-Result: ApVHAFvkA1MCYJCb/2dsb2JhbABZgwZIA4kEt3wBAgEBC4EVF3SCIAUBAQQBCAEBLh4BASEFBgIDBQIBAxUMJRQBBBoGBxcGEwgCAQIDAYdsDMV5hnGOZDWCdoEUBIkQhhqbKoMtPA
X-IronPort-AV: E=Sophos;i="4.97,503,1389744000"; 
   d="scan'208";a="455538721"
Received: from host-2-96-144-155.as13285.net (HELO PhilipOakley) ([2.96.144.155])
  by out1.ip01ir2.opaltelecom.net with SMTP; 18 Feb 2014 22:54:12 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242366>

From: "Junio C Hamano" <gitster@pobox.com>
> Philip Oakley <philipoakley@iee.org> writes:
>
>> A few days too late for the 1.9.0 release cycle :(
>>
>> This responds to Stefan Nwe's request for a 'git help' command that 
>> would
>> access the release notes. ($gmane/240595 17 Jan 2014).
>>
>> I've used the full name "release-notes" for the help guide rather 
>> than
>> Stefan's original 'git help relnotes'.
>>
>> The release-notes man page lists just the notes for the current 
>> release.
>> The combined notes for all releases is nearing 15k lines.
>
> RelNotes are incremental and only useful for those who know what the
> immediately previous release contained, but for most people who get
> their Git from distros, I have this impression that the versions of
> Git they get skip versions, and seeing the notable changes since the
> previous source release will not give them wrong information---they
> may have this warm fuzzy feeling that they know what is going on,
> but they are missing information on all the accumulated changes that
> were added in earlier versions their distro skipped---these changes
> are still in the version they are running.

That's a reasonable argument. I did look at trying to get the 
"stalenotes" to work as an alternative, that is extract the stalenotes 
section from the git.txt, and create a release notes man page from that. 
However there were two issues there that I couldn't solve (noted in the 
cover letter).

The first is that the man page generator does not expect more than 99 
references so the link numbers repeat themselves. I'm sure that is 
fixable by someone who knows the insides of acsiidoc.

The other was that the links for the main version documentation appear 
to been to be made at kernel.org, so that links back there are created. 
Again I wasn't sure how that should be resolved.

>   I do not understand why
> it is even a good idea to show release notes from the command line
> "git" interface.

My looking at this came from Stefan's suggestion noted above 
$gmane/240595. So it had at least one follower ;-)

Philip
-- 
