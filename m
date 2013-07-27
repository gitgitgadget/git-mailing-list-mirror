From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCHv3] git-tag man: when to use lightweight or annotated tags
Date: Sat, 27 Jul 2013 12:26:26 +0100
Organization: OPDS
Message-ID: <720060083F5C476A905C09146E7CD711@PhilipOakley>
References: <51EFA9A9.4010103@gmail.com> <7vtxjj66kn.fsf@alter.siamese.dyndns.org> <51F12BE6.80606@gmail.com> <51F13A8F.9040400@xiplink.com> <51F23706.5040009@gmail.com> <51F2375E.1080003@gmail.com> <51F28D08.8050507@xiplink.com> <51F2AFBA.4020602@gmail.com> <51F2B2CD.1030004@gmail.com> <20130726190602.GC29799@sigill.intra.peff.net> <51F3A358.5000807@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=response
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Marc Branchaud" <marcnarc@xiplink.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Daniele Segato" <daniele.segato@gmail.com>,
	"Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 27 13:26:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V32dg-00064B-P0
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jul 2013 13:26:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484Ab3G0L0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jul 2013 07:26:17 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:61486 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751446Ab3G0L0Q (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Jul 2013 07:26:16 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Au0NACmt81FOl328/2dsb2JhbABbgwaEFIU+tQYEAQMBgRUXdIIfBQEBBQgBARkVHgEBIQsCAwUCAQMVAwICBSECAhQBBAgSBgcXBgESCAIBAgMBh20DE6cSiEANiF6BKIttgSlNcoJqM28Djn+Gd44PhSaBNIFhO4E1
X-IPAS-Result: Au0NACmt81FOl328/2dsb2JhbABbgwaEFIU+tQYEAQMBgRUXdIIfBQEBBQgBARkVHgEBIQsCAwUCAQMVAwICBSECAhQBBAgSBgcXBgESCAIBAgMBh20DE6cSiEANiF6BKIttgSlNcoJqM28Djn+Gd44PhSaBNIFhO4E1
X-IronPort-AV: E=Sophos;i="4.89,757,1367967600"; 
   d="scan'208";a="436904338"
Received: from host-78-151-125-188.as13285.net (HELO PhilipOakley) ([78.151.125.188])
  by out1.ip01ir2.opaltelecom.net with SMTP; 27 Jul 2013 12:26:14 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231236>

From: "Daniele Segato" <daniele.segato@gmail.com>
> On 07/26/2013 09:06 PM, Jeff King wrote:
>> On Fri, Jul 26, 2013 at 07:33:01PM +0200, Daniele Segato wrote:
>>
>>> stress the difference between the two with suggestion on when the 
>>> user
>>> should use one in place of the other.
>>>
>>> Signed-off-by: Daniele Segato <daniele.segato@gmail.com>
>>
>> The intent of your patch seems reasonable to me. There are a few 
>> minor
>> language and typographical mistakes, and the patch itself is
>> whitespace-damaged.
>
> Hi Jeff,
>
> thanks for the feedback, very appreciated.
>
> But I don't understand what's wrong with the whitespaces.
>
> Can you explain to me what's wrong and how I can avoid the issue?
>
> I use thunderbird in text mode to send emails, should I use something 
> else? what?

Try 'git format-patch' and 'git send-email'. The format-patch man page 
even has a note about Thunderbird corruptions.

Philip

>
>>
>> I also do not know that it is accurate to say "most git commands 
>> ignore
>> lightweight tags". It is really only "naming" ones like "git 
>> describe".
>>
>> Here is a re-send of your patch with the fixups I would recommend.
>>
>
> Thanks, it's obviously better.
>
> I'll send this new version as soon as you or someone else explain me 
> how to fix the whitespace damage.
>
[snip] 
