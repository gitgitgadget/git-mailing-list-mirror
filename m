From: "jamesmikedupont@googlemail.com" <jamesmikedupont@googlemail.com>
Subject: Re: Introduction and Wikipedia and Git Blame
Date: Fri, 16 Oct 2009 16:23:20 +0200
Message-ID: <ee9cc730910160723j5d7346a4l195ac6d3825c393b@mail.gmail.com>
References: <ee9cc730910160207x49feb40ej692188abb0a57473@mail.gmail.com>
	 <alpine.DEB.1.00.0910161321550.4985@pacific.mpi-cbg.de>
	 <ee9cc730910160443k7e5f718bs964923a796cf38d1@mail.gmail.com>
	 <alpine.DEB.1.00.0910161548550.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 16 16:25:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MynkS-0008Gh-9S
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 16:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760359AbZJPOX7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Oct 2009 10:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760347AbZJPOX7
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 10:23:59 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:50538 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760324AbZJPOX6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Oct 2009 10:23:58 -0400
Received: by fxm18 with SMTP id 18so2468090fxm.37
        for <git@vger.kernel.org>; Fri, 16 Oct 2009 07:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=p4mqv0uyrY+8Rx9MEYSQLQiEG5Xo+XXCfMPo/i/Nvs4=;
        b=xTQ/+YyP+nTky2u7+45IJP4Yga0pgttUQJ1KRcyiz6IsY1K6G96biE8sS6OI6wSvqg
         LefUbRkaNyjEQwyEsjIyfAIHewRY/jGXaxqrTg1i6WdyZ31RjH9uaDzXj1Sw+LOGQUHE
         IytkFb+S+WY/njyKvnMfhPTbyS2BX/+FKV6Eg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=r3RspOlQU9F8pMnwyWraf0LRJihSnhLajuUG/6nWooE8MS56t7SzN/Ph8nVW2Z9FWM
         HvIMzYiJUJ2JN56RUle9gHksx6sdAuOPfqhWCQCKmXIaI6BCtJdDFQCFIk7eOXIihV+O
         OVWNpsPyDoERQR3lm4q/1iVa5sTYeUzHY39tQ=
Received: by 10.204.156.205 with SMTP id y13mr1317677bkw.116.1255703000789; 
	Fri, 16 Oct 2009 07:23:20 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0910161548550.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130495>

Johannes,
Thanks for your input,
comments below.
mfg,
mike

On Fri, Oct 16, 2009 at 4:11 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Fri, 16 Oct 2009, jamesmikedupont@googlemail.com wrote:
>
>> On Fri, Oct 16, 2009 at 1:26 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> >> Here is the discussion on foundation-l :
>> >> http://www.gossamer-threads.com/lists/wiki/foundation/181163
>> >
>> > I found the link to the bazaar repository there, but do you have a=
 Git
>> > repository, too?
>>
>> Not yet. Where should I put it? =A0Any suggestions.
>
> github.com has a nice interface.
>
> BTW after reading some of the code, I am a bit surprised that you did=
 not
> do it as a .php script outputting fast-import capable text...

I dont really know php, and I dont have a debugger or any tools in it..=
=2E.
Really cannot understand how people can work in such an environment.

I have done all my hacking work as perl scripts.
These can be rewritten in c later on.


> Okay, so basically you want to analyze the text on a word-by-word bas=
is
> rather than line-by-line.
yes.

>
> Or maybe even better: you want to analyze the text character-by-chara=
cter.
> That would also nicely circumvent to specify just what makes a word a=
 word
> (subject for a lot of heated discussion during the design of the
> --color-words=3D<regex> patch).

Yes,  Someone suggested in irc to review the color-words , I have the
source code now and will be looking into that.

>
> Basically, if I had to implement that, I would not try to modify
> builtin-blame.c, but write a new program linking to libgit.a, calling=
 the
> revision walker on the file you want to calculate the blame for. =A0(=
One of
> the best examples is probably in builtin-shortlog.c.)
>
> Then I would introduce a linked-list structure which will hold the bl=
amed
> regions in this form:
>
> =A0 =A0 =A0 =A0struct region {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int start;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct region *next;
> =A0 =A0 =A0 =A0};
>
> Initially, this would have a start element with the start offset 0
> pointing to the end element with start offset being set to the size o=
f the
> blob.
>
> Most likely you will have to add members to this struct, such as the
> original offsets (as you will have to adjust the offsets to the diffe=
rent
> file revisions while you go back in time), and the commit it was
> attributed to.
>
> Then I would make modified "texts" from the blob of the file in the
> current revision and its parent revision, by inserting newlines after
> every single byte (probably replacing the original newlines by other
> values, such as \x01).
>
> The reason for this touchup is that the diff machinery in Git only ha=
ndles
> line-based diffs.
>
> Then you can parse the hunk headers, adjust the offsets accordingly, =
and
> attribute the +++ regions to the current commit (by construction, the
> offsets are equal to the line number in the hunk header). =A0Here it =
is most
> likely necessary to split the regions.
>
> You should also have a counter how many regions are still unattribute=
d so
> you can stop early.

Ok this sounds like a plan. I think that will be a good outline to
start some work.
I will let you know when I have made some progress.
thanks,
mike
