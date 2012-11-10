From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Workflow for templates?
Date: Sat, 10 Nov 2012 09:56:01 -0000
Organization: OPDS
Message-ID: <F9FF8107FA8F4CBD8C3D87B907BAE9E3@PhilipOakley>
References: <bbc40624-f95d-48c9-83ed-fd70430226a4@zcs>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>
To: "Enrico Weigelt" <enrico.weigelt@vnc.biz>,
	"Josef Wolf" <jw@raven.inka.de>
X-From: git-owner@vger.kernel.org Sat Nov 10 10:56:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TX7nT-00041e-Fs
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 10:56:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886Ab2KJJ4B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2012 04:56:01 -0500
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:3873 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750734Ab2KJJ4A (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Nov 2012 04:56:00 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArANACTrnVBcHm+W/2dsb2JhbABEhhmFP7Z2AQECf4EJghkFAQEEAQgBARkVHgEBIQUGAgMFAgEDFQEEAgUhAgIUAQQaBgcXBgESCAIBAgMBh3MKqxiSTYEiinJQMRw1g2UyYQONdJhKgm8
X-IronPort-AV: E=Sophos;i="4.80,750,1344207600"; 
   d="scan'208";a="390435813"
Received: from host-92-30-111-150.as13285.net (HELO PhilipOakley) ([92.30.111.150])
  by out1.ip04ir2.opaltelecom.net with SMTP; 10 Nov 2012 09:55:58 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209267>

From: "Enrico Weigelt" <enrico.weigelt@vnc.biz> Sent: Saturday, November
10, 2012 7:13 AM

I've picked out Enrico's key points.

>> Maybe I should try to explain the problem in terms of repository
>> hierarchy. Let's assume, there is this hierarchy of repositories:
>
> Let's talk about branches instead - repos are just containers for
> branches (and tags, etc).

This is often the key point that requires the 'new mindset'. Most folk
use/used the directory heirarchy (subtle distinction with the .git
'repo' directory heirarchy to be noted) as a way of separating ownership
between groups. They find it very hard to undo the old mindset and use
branches _instead of_ directories for the different group
configurations.

Teaching git is easy. Undoing the old mindset is hard hard hard. [it's
still hard]


> By the way: you really should use non-conflicting tag names (eg.
> adding some <site>+"/" or <site>+"-" prefix), otherwise you'll
> easiy run into conflicts, because per default retrieved and local
> tags will all be in some namespace
>          Better consider tag names to be really global.

Definitely.

Apologies if it's a bit of bike-shedding.

Philip
