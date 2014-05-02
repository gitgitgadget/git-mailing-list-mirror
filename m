From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Pull is Mostly Evil
Date: Fri, 2 May 2014 17:05:29 +0100
Organization: OPDS
Message-ID: <C439C0C76DA44AB5AAC91E7C0D2991BA@PhilipOakley>
References: <5363BB9F.40102@xiplink.com> <87k3a4xjzg.fsf@fencepost.gnu.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>, "David Kastrup" <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri May 02 18:05:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgFy1-0005SG-4F
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 18:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753923AbaEBQFf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 12:05:35 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:9190 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753100AbaEBQFb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 May 2014 12:05:31 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AiNTAPXBY1MCYJ6l/2dsb2JhbABagwZfA4hpvB0FAQIBDIEFF3SCIAUBAQQBCAEBLh4BASwCAwUCAQMVDCUUAQQaBgcXBgESCAIBAgMBiCgMq1+eZo8HgnaBFQSJTIY4nBuDNTw
X-IPAS-Result: AiNTAPXBY1MCYJ6l/2dsb2JhbABagwZfA4hpvB0FAQIBDIEFF3SCIAUBAQQBCAEBLh4BASwCAwUCAQMVDCUUAQQaBgcXBgESCAIBAgMBiCgMq1+eZo8HgnaBFQSJTIY4nBuDNTw
X-IronPort-AV: E=Sophos;i="4.97,973,1389744000"; 
   d="scan'208";a="610892892"
Received: from host-2-96-158-165.as13285.net (HELO PhilipOakley) ([2.96.158.165])
  by out1.ip06ir2.opaltelecom.net with SMTP; 02 May 2014 17:05:29 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247941>

From: "David Kastrup" <dak@gnu.org>
> Marc Branchaud <marcnarc@xiplink.com> writes:
>
>> To that end, I suggest that pull's default behaviour should be to do
>> *nothing*.  It should just print out a message to the effect that it
>> hasn't been configured, and that the user should run "git help pull"
>> for guidance.
>
> Fetching is uncontentious, and I _think_ that fast-forwards are pretty
> uncontentious as well.

While the fast forward is /pretty/ uncontentious, it still maybe 
contentious for some. But more importantly (in my mind) is the fact that 
it (git pull) hasn't been configured, and pressing for _that_ to happen 
is the big benefit.

I'm more than happy that the fast-forward should be the recommended 'if 
you don't know, choose this' option, as you say, its pretty 
uncontentious and has easy mechanisms for backing out which are well 
illustrated across the internet.

It would still need a few cycles of ramping up the warnings to ease folk 
in gently. One has to beware of the issues at both ends of the Kruger 
Dunning curve. This thread discussion in some ways has suffered from the 
inverse K-D effect.

>
> It's just when the merge-left/merge-right/rebase-left/rebase-right
> decision kicks in that prescribing one git-pull behavior looks like a
> recipe for trouble.
>
> -- 
> David Kastrup
>
--
Philip
