From: "alturin marlinon" <alturin@gmail.com>
Subject: Re: [SoC RFC] git statistics - information about commits
Date: Sun, 23 Mar 2008 22:32:57 +0100
Message-ID: <bd6139dc0803231432s4a1f9d86r7ec97847fa70ca82@mail.gmail.com>
References: <bd6139dc0803210152o529f3b4fi15c515f5385d8f88@mail.gmail.com>
	 <7vmyospgz7.fsf@gitster.siamese.dyndns.org>
	 <7v3aqik0nz.fsf@gitster.siamese.dyndns.org>
	 <bd6139dc0803230707w29e31d89kf65cf4ac7ad3c8@mail.gmail.com>
	 <7vzlsp73fs.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 22:33:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdXoy-0003sB-Ar
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 22:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754934AbYCWVc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 17:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754632AbYCWVc7
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 17:32:59 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:46836 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754025AbYCWVc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 17:32:58 -0400
Received: by wf-out-1314.google.com with SMTP id 28so2674279wff.4
        for <git@vger.kernel.org>; Sun, 23 Mar 2008 14:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=iLfdvpnnLUUMQNSnZt3P/OAc9RXtTWpkd5/yl/vtdNQ=;
        b=l2FaGTwVBkhDr+ZdkIrEFTVJvxlD/iwDxtcH3iNEIGA521mkrywBQshMWSgthP63Ap9TZNUrZBewHjuGn7Nm05Z0wwLYdHPD6x6kzDglEBTaBxeaB2UeS7RgkeywFDEXgaITXKomgfBiWjk6D3VgWG6yux5+Pq5wseq2zWCZNtw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=E74TZZ4lpE4MhdpqI6Jbzj2RnX22Y62YdTCtjSiAHDQpglv/Jo4c6Bob4TIo21XxucvjwugEbOx0yvaNmOIOIQNlDq0dVlqPYK51hKGJjbkE+O13XrAMXGnHenk7RO2Z8zkAxZeEnma0jWy/u8TlSh8T8LyrsFBj8SH/E7vkSBg=
Received: by 10.142.178.13 with SMTP id a13mr3928712wff.226.1206307977511;
        Sun, 23 Mar 2008 14:32:57 -0700 (PDT)
Received: by 10.142.77.6 with HTTP; Sun, 23 Mar 2008 14:32:57 -0700 (PDT)
In-Reply-To: <7vzlsp73fs.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77961>

On Sun, Mar 23, 2008 at 6:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
>  Hey, don't get me wrong.  Please do not start your thought with "which of
>  these features".  Proposed feature set should come from you.  It's your
>  project after all.

Ah, perhaps I should have phrased it more like "which of these
features are of most interest to the community".

>  I was NOT giving you an instruction "You should do all of these" (I am not
>  your mentor), an opinion "These are all important" (I haven't thought
>  things through), nor criteria "Unless you do your feature this way, you
>  fail" (I am not GSoC admin to judge your application nor evaluate at the
>  end of project).  Nothing of that sort.  They are just random ideas, I
>  haven't even thought through the feasibility of, and/or possible approach
>  to solution for, some of them.

Even so, most of them are very interesting, although I agree that the
feasibility should perhaps be looked at more closely.

>  If you find any of them interesting, you are welcome to include them in
>  your target feature set.  Other uninteresting ones and unrealistic ones
>  you can discard without even commenting.

I think I will divide the features into subsets and list the
dependencies between them.
Then based upon 'popularity' an easy selection could be made.
Johannes said:

> I think it can be vague about the order in which things will be
> implemented.  And the features which you think might be too complicated
> should be marked as such: "possible extension (which might not be finished
> within this project): <blabla>".

Would such a list be allowed to include such a list of grouped
features which then can be selected later on?
