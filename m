From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 03:09:08 +0300
Message-ID: <94a0d4530808271709s4e96c5a7ie6152b2937f2234b@mail.gmail.com>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>
	 <1219664940.9583.42.camel@pmac.infradead.org>
	 <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	 <7vy72kek6y.fsf@gitster.siamese.dyndns.org>
	 <20080826145719.GB5046@coredump.intra.peff.net>
	 <7vr68b8q9p.fsf@gitster.siamese.dyndns.org>
	 <20080827001705.GG23698@parisc-linux.org>
	 <7v63pmkozh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Matthew Wilcox" <matthew@wil.cx>, "Jeff King" <peff@peff.net>,
	"David Woodhouse" <dwmw2@infradead.org>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	users@kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 02:10:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYV5y-00013g-C6
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 02:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754790AbYH1AJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 20:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754736AbYH1AJK
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 20:09:10 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:36560 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754441AbYH1AJI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 20:09:08 -0400
Received: by rv-out-0506.google.com with SMTP id k40so107988rvb.1
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 17:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=2DG9eV6wjhg9ttBm2bwSQgrmGPGNejok3qHKDwmnuPs=;
        b=rTwqFSiNKPq/FFUazJf3PMfn7uTD6KE5vtX1Sd44Kn5sIA3WGdDEJB/oVws6F09QaT
         FhzClUf+RM6QJ6emR/OBzw/LplV2ucNIm6YaBw+zSMNpNphXcQRY7jG9G1uiV+SqtY2p
         xpbvWgwDD6yWxIMtbAFCb6RoZfSl3MgLhcSXI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=kvIY5NPoMeJie8QI2ksOpBePweA9GmJWWq+QDuskU1zJsZ6pipy2yHsVRzRKcGMvXG
         JyWwVBogHhvUkrg0gkij2CGMk2gVWJlKripO+ecQxn76fAs2yUlxZvkMJ1oMJP2tHwS1
         hd6L2JvKCXNpA+ZYAh/fwzTX9DdLi9ze7SzA8=
Received: by 10.141.29.14 with SMTP id g14mr345134rvj.241.1219882148272;
        Wed, 27 Aug 2008 17:09:08 -0700 (PDT)
Received: by 10.140.166.19 with HTTP; Wed, 27 Aug 2008 17:09:08 -0700 (PDT)
In-Reply-To: <7v63pmkozh.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93996>

On Thu, Aug 28, 2008 at 2:38 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Matthew Wilcox <matthew@wil.cx> writes:
>
>> On Tue, Aug 26, 2008 at 01:39:30PM -0700, Junio C Hamano wrote:
>>> When I hear something like what David Woodhouse said in this thread, I
>>> should be feeling "People -- those of you who claimed to be the silent
>>> majority -- see, I told you so!  This is a very bad move".
>>>
>>> But I can't.  People who complain _now_ just annoy me even more.  Why
>>> weren't you defending the backward compatibility with me, which you seem
>>> to value it so much, perhaps even more than I did back then?  Why are you
>>> wasting our time bringing it up again, instead of joining the discussion
>>> when it _mattered_ back then?
>>
>> We didn't know the conversation was going on.  Why should we?  We only
>> use the tool, not develop it.  I'm also not on the mailing lists for
>> mutt, vim, gcc, binutils, openssh, grep, xchat, mozilla, gnome, xpdf or
>> any of the dozens of other programs I use on a daily basis.
>
> Oh, I wasn't talking to you, or "we as git users".  The user side of the
> discussion has long been over in another thread titled "[kernel.org users]
> README and ChangeLog files" that was started by HPA, and everybody now
> knows that the conclusion of the discussion was that 1.6.0 transition was
> underadvertised to the end-user community and caused pain.  Sorry about
> that, but let's leave it behind.  What has happend has happened.
>
> The discussion in this thread was about how to go forward from here, now
> the transition is over.  One of the future directions the transition was
> aiming at was removal of git-foo form for built-ins even from the libexec
> area -- I was complaining about David's beating an offtopic dead horse in
> the above, because it was throwing the thread in an off-track direction,
> distracting everybody from discussing what was more important, discussing
> constructively if/how to proceed from here.
>
> Now the primary topic of what to do about built-ins have already settled.
> We _will_ keep git-foo commands in the libexec area.  We won't be removing
> them.
>
> So there is no need to worry.

Still, if this is the decision, all the documentation should be
updated, and people should be discouraged to mention the git-foo
commands ever again, otherwise new users would get confused.

-- 
Felipe Contreras
