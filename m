From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Announcing a new (prototype) git-remote-hg tool
Date: Fri, 5 Dec 2014 22:44:59 -0000
Organization: OPDS
Message-ID: <0B0D868B05D243178E3A2AC2912938DA@PhilipOakley>
References: <20141205205335.GA28935@glandium.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Mike Hommey" <mh@glandium.org>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 05 23:44:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx1bi-0007Vg-J2
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 23:44:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927AbaLEWoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 17:44:10 -0500
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:26143 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751041AbaLEWoJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Dec 2014 17:44:09 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AowVAPw0glROl3BEPGdsb2JhbABZgwZSWIcfvzKBeQGEEQEDAQGBGBcBAQEBAQEFAQEBATggG4N9BgEBBAgBAS4eAQEcBQsCAwUCAQMOBwwlFAEEGgYHAxQGARIIAgECAwGILgnGJY9+AQsBH5BPgyiBFQWKAIVGXIMih3GVWD8wgQUkgRoBAQE
X-IPAS-Result: AowVAPw0glROl3BEPGdsb2JhbABZgwZSWIcfvzKBeQGEEQEDAQGBGBcBAQEBAQEFAQEBATggG4N9BgEBBAgBAS4eAQEcBQsCAwUCAQMOBwwlFAEEGgYHAxQGARIIAgECAwGILgnGJY9+AQsBH5BPgyiBFQWKAIVGXIMih3GVWD8wgQUkgRoBAQE
X-IronPort-AV: E=Sophos;i="5.07,525,1413241200"; 
   d="scan'208";a="536450049"
Received: from host-78-151-112-68.as13285.net (HELO PhilipOakley) ([78.151.112.68])
  by out1.ip03ir2.opaltelecom.net with SMTP; 05 Dec 2014 22:43:59 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260905>

From: "Mike Hommey" <mh@glandium.org>
> Hi,
>
> I've (re)started work on a longstanding idea of mine of having a git 
> tool
> talking the mercurial wire protocol directly. I'm now at a stage where
> the tool can clone and pull/fetch from mercurial.
>
> As it is a prototype, there are many things that it doesn't handle 
> (like
> named branches, bookmarks, phases, obsolescence markers), but it
> currently transposes a complete mercurial dag to git and maintains
> metadata about the original mercurial data.
>
> Code on https://github.com/glandium/git-remote-hg
>
> It doesn't support push, but support for that should come in the 
> coming
> weeks.
>
> More background on http://glandium.org/blog/?p=3382
>
> This is meant to be a prototype, and will stay that way for now.
> It's a validation that this can actually work. Now that I have pull
> support I know I can make it push.
> I'm currently evaluating what the final tool would look like. I'm 
> *very*
> tempted to implement it in C, based on core git code, because there 
> are
> many things that this helper does that would be so much easier to do
> with direct access to git's guts. And that wouldn't require more
> dependencies than git currently has: it would "just" need curl and 
> ssh,
> and git already uses both.
>
> If I were to go in that direction, would you consider integrating it
> in git core? If not, would you rather see git helpers to make this
> git-remote-hg helper more efficient?
>
You may also be interested in 
https://felipec.wordpress.com/2013/08/26/whats-new-in-git-v1-8-4-remote-hg/ 
and https://github.com/felipec/git-remote-hg.

Though Filipe's unique work style hasn't found favour locally.

see also https://github.com/buchuki/gitifyhg/wiki/List-of-git-hg-bridges

Philip 
