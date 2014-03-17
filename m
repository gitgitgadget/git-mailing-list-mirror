From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: What's cooking in git.git (Mar 2014, #03; Fri, 14)
Date: Mon, 17 Mar 2014 22:41:20 -0000
Organization: OPDS
Message-ID: <A3D6A8DA9247437B9B4751C5C5B6924C@PhilipOakley>
References: <xmqqlhwcfn4a.fsf@gitster.dls.corp.google.com> <EA1EF5746EA7414CAE1320AA61100178@PhilipOakley> <CALkWK0npxgi2gWQbuYZLn_N0GxgTdPTR8c-yhgCxEV=mM2Zngw@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git List" <git@vger.kernel.org>
To: "Ramkumar Ramachandra" <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 23:41:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPgDo-00006Q-9U
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 23:41:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753115AbaCQWlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 18:41:24 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:64154 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753031AbaCQWlX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Mar 2014 18:41:23 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhcXABx5J1NZ8YHW/2dsb2JhbABagwaEGIU+uVABAgEBgSUXdIIgBQEBAQECAQgBARkVHgEBHAUFBgIDBQIBAw4HAwICBSECAhQBBAgSBgcXBhMIAgECAwGHVAMJDLEAhVmVSQ2HOheBKYsngUcBAU+CdjWBFASPOoUggX+OVYVIgy09gTU
X-IPAS-Result: AhcXABx5J1NZ8YHW/2dsb2JhbABagwaEGIU+uVABAgEBgSUXdIIgBQEBAQECAQgBARkVHgEBHAUFBgIDBQIBAw4HAwICBSECAhQBBAgSBgcXBhMIAgECAwGHVAMJDLEAhVmVSQ2HOheBKYsngUcBAU+CdjWBFASPOoUggX+OVYVIgy09gTU
X-IronPort-AV: E=Sophos;i="4.97,673,1389744000"; 
   d="scan'208";a="448209658"
Received: from host-89-241-129-214.as13285.net (HELO PhilipOakley) ([89.241.129.214])
  by out1.ip05ir2.opaltelecom.net with SMTP; 17 Mar 2014 22:41:20 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244304>

From: "Ramkumar Ramachandra" <artagnon@gmail.com>
> Philip Oakley wrote:
>>> * po/everyday-doc (2014-01-27) 1 commit
>>> - Make 'git help everyday' work
>>>
>>> This may make the said command to emit something, but the source is
>>> not meant to be formatted into a manual pages to begin with, and
>>> also its contents are a bit stale.  It may be a good first step in
>>> the right direction, but needs more work to at least get the
>>> mark-up right before public consumption.
>>
>> I'm not sure what elements you feel need adjustment. At the moment 
>> the
>> markup formats quite reasonably to my eyes, both as an HTML page and 
>> as a
>> man page.
>
> I sent you a small patch fixing some minor markup issues.

Thanks, I'll look through them. There was one part where there was a 
sub-list which made the numbering look wrong, but it formatted fine.

>
>> That said, the (lack of) introduction could do with a paragraph to 
>> introduce
>> the "guide". I have something in draft..
>>
>> I had a thought that it may be worth a slight rearrangement to add a 
>> section
>> covering the setting up of one's remotes, depending whether it was 
>> forked,
>> corporate, or independent, but the lack of resolution on the next
>> {publish/push} topic makes such a re-write awkward at this stage. 
>> (Ram cc'd)
>
> Before attempting to introduce remote.pushdefault and triangular
> workflows, I'd first fix the main issue: stale content.

My priority order was to fix accessibility, then basic format, followed 
by a nicer intro, and then the "current" content, rather than get hung 
up on initially word-smithing new content, which could go down a rabbit 
hole which would leaving the stale content in place. Hopefully the patch 
will bring out some more clarifications that folks feel are outdated or 
no longer informative.

>     I'm not sure
> who uses git show-branch or mailx anymore, for instance.

I hadn't even realised mailx was refering to specific program rather 
than a generic "mail-MUA-X" ;-)

regards

Philip 
