From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Pull is Evil
Date: Thu, 1 May 2014 22:16:33 +0100
Organization: OPDS
Message-ID: <B662835E37564DC6A3029973AFDD702F@PhilipOakley>
References: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com>	<xmqqoazlqot4.fsf@gitster.dls.corp.google.com>	<536106EA.5090204@xiplink.com> <xmqqppjyhnom.fsf@gitster.dls.corp.google.com> <536152D3.5050107@xiplink.com> <E699B6CE8ADD46618D52F05DB8EF6F07@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
Cc: "Marat Radchenko" <marat@slonopotamus.org>,
	"Felipe Contreras" <felipe.contreras@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Marc Branchaud" <marcnarc@xiplink.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 01 23:16:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfyLM-00058H-JN
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 23:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201AbaEAVQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 17:16:32 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:41384 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751867AbaEAVQb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 May 2014 17:16:31 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AklWAOi4YlMCYJZX/2dsb2JhbABagwZfA4hovCwFAQIBAQuBCRd0giAFAQEEAQgBAS4eAQEWCwUGAgMFAgEDFQELJRQBBBoGBxcGEwgCAQIDAQoDiBsMq2OeMY5SNYJ2gRUEiUyGN5wagzQ8
X-IPAS-Result: AklWAOi4YlMCYJZX/2dsb2JhbABagwZfA4hovCwFAQIBAQuBCRd0giAFAQEEAQgBAS4eAQEWCwUGAgMFAgEDFQELJRQBBBoGBxcGEwgCAQIDAQoDiBsMq2OeMY5SNYJ2gRUEiUyGN5wagzQ8
X-IronPort-AV: E=Sophos;i="4.97,967,1389744000"; 
   d="scan'208";a="459372089"
Received: from host-2-96-150-87.as13285.net (HELO PhilipOakley) ([2.96.150.87])
  by out1.ip03ir2.opaltelecom.net with SMTP; 01 May 2014 22:16:29 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247884>

Oops..
From: "Philip Oakley" <philipoakley@iee.org>
> From: "Marc Branchaud" <marcnarc@xiplink.com>
> Sent: Wednesday, April 30, 2014 8:45 PM
> [...]
>> I don't think we'll ever be able to create a One "Git Pull" To Rule 
>> Them All.
>> At best we'll end up with something with enough knobs that it could 
>> be
>> configured to work in most workflows (I think we're actually pretty 
>> close to
>> that).  But for new users that defeats the purpose.  It means that 
>> "git pull"
>> is really an advanced command, and beginners should avoid it until 
>> they
>> understand enough of git to configure it properly.
>>
>> So rather than perpetuate the myth that one command can always (or 
>> even just
>> usually) do the right thing, let's just retire the command.
>>
>> All that said, I don't object to any attempts at improving the 
>> command
>> either.  But I also don't see any kind of improvement that would lead 
>> me to
>> start using "git pull" let alone recommending it to new users.
>>
>> M.
>>
>> [1] By "significant" I mean "enough to perpetually create new mailing 
>> list
>> threads about changing 'git pull'".
>>
> [general reply to all, rather than to anyone in particular, using 
> Marc's summary]
>
> The point that there is no easy solution to an updated default pull 
> action that is right for everybody, straight out of the box, I think 
> is now fairly obvious, a summarised by Marc. I certainly avoid pull.
>
> My 'solution', if it could be called that, would be that at the point 
> of switch over, after a period of release note warning and then code 
> warning, that the plain 'git pull' would not even do the no-ff, but

s/no-ff/--ff/g that is, only 'merge' if it's a fast forward.

> would simply refuse to do anything unless the user had explicitly set 
> the [new] config variable(s) to a value of _their_ choice. The message 
> could give guidance based on their old setting(s) and the new options 
> as appropriate, i.e. if they have an old definitive setting then the 
> new setting may be an obvious one.
>
> During the warning period between the release cycles, we may have a 
> two step ramp up of the warning, where the first cycle allows users 
> who have read the release notes to choose their new setting and it's 
> auto detected from there on, then in the second cycle Git detects the 
> lack of a setting and gives a warning prompt (just like the Git 2.0 
> warning), and finally the change over release makes a 'git pull' 
> without a config setting an error.
>
> I know that for some it's a phaff that appears to waste time (been 
> there, been that person), but it does allow the stragglers time to 
> pick up the hints and not be too surprised, which will include many 
> otherwise professional folks who just happen to have other priorities 
> [e.g. this message typed from a Win XP machine!].
>
> The approach does have a solid heritage, and avoids anyone (on the 
> coding side) having to decide on an initial default, when it should be 
> a user choice. Though I do agree with Filipe that the '--no-ff merge'

s/no-ff/--ff/

> would probably be the least worst for the new user and likely be a 
> suitable 'if you don't know use this one' suggestion.
>
> Philip
> -- 
sorry for the finger-brain failures. 
