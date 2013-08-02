From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH v2] Provide some linguistic guidance for the documentation.
Date: Fri, 02 Aug 2013 10:16:34 -0400
Message-ID: <51FBBF42.5040102@xiplink.com>
References: <1375197114-10742-1-git-send-email-marcnarc@xiplink.com> <1375369825-28636-1-git-send-email-marcnarc@xiplink.com> <7vfvuts25p.fsf@alter.siamese.dyndns.org> <20130802062511.GA3013@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Fredrik Gustafsson <iveqy@iveqy.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 02 16:16:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5G9t-0003SZ-Aj
	for gcvg-git-2@plane.gmane.org; Fri, 02 Aug 2013 16:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753413Ab3HBOQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 10:16:41 -0400
Received: from smtp138.ord.emailsrvr.com ([173.203.6.138]:57299 "EHLO
	smtp138.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948Ab3HBOQl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 10:16:41 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp10.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 5A93D3701C7;
	Fri,  2 Aug 2013 10:16:40 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp10.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id DCE9D370186;
	Fri,  2 Aug 2013 10:16:39 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <20130802062511.GA3013@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231525>

On 13-08-02 02:25 AM, Jonathan Nieder wrote:
> Junio C Hamano wrote:
>
>> Is that accurate?  My impression has been:
>>
>>      The documentation liberally mixes US and UK English (en_US/UK)
>>      norms for spelling and grammar, which is somewhat unfortunate.
>>      In an ideal world, it would have been better if it consistently
>>      used only one and not the other, and we would have picked en_US.
>
> I'm not convinced that would be better, even in an ideal world.
>
> It's certainly useful to have a consistent spelling of each term to
> make searching with "grep" easier.  But searches with "grep" do not
> work well with line breaks anyway, and search engines for larger
> collections of documents seem to know about the usual spelling
> variants (along with knowing about stemming, etc).  Unless we are
> planning to provide a separate en_GB translation, it seems unfortunate
> to consistently have everything spelled in the natural way for one
> group of people and in an unnatural way for another, just in the name
> of having a convention.

Personally I find it distracting when the norms are mixed.  I don't 
think the current mishmash pleases anyone (as evidenced by the steady 
stream of patches that change spellings).

> I am not sure it makes sense for the documentation to say "A huge
> disruptive patch of such-and-such specific kind of no immediate
> benefit is unwelcome".  Isn't there some more general principle that
> implies that?  Or the CodingGuidelines could simply say
>
> 	The documentation uses a mixture of U.S. and British English.

I'm hoping this patch will help the list avoid seeing patches that 
merely flip between alternate spellings.  (Perhaps the commit message 
should state this?)  I think it's important to be clear about the kind 
of work the git community wants to see.  So I don't think that single 
sentence by itself would be helpful.

In the case of alternate spellings in the documentation, I think there's 
a temptation to create a blanket patch that "fixes" lots of perceived 
misspellings since such changes are mere typographic tweaks.  It's a bit 
easy to overlook the disruptive nature of such a patch, so IMO it bears 
repeating here.

Are you suggesting maybe that there should be no "official" dialect? 
That the guidance should simply say that we don't want to see patches 
that merely flip between alternate spellings (because we don't really care)?

		M.
