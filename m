From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 2/8] docbook: improve css style
Date: Tue, 24 Mar 2009 12:52:18 +0200
Message-ID: <94a0d4530903240352m8b9094br841f5a0f36ca50ea@mail.gmail.com>
References: <1237745121-6325-1-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-2-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-3-git-send-email-felipe.contreras@gmail.com>
	 <20090323064242.GB1119@coredump.intra.peff.net>
	 <94a0d4530903230331g3b620f80h77e317a09dc5273f@mail.gmail.com>
	 <49C7A8AF.9080500@drmicha.warpmail.net>
	 <94a0d4530903231721i2a2a6fc1yf54d4303283ec415@mail.gmail.com>
	 <49C899E1.6060809@drmicha.warpmail.net>
	 <94a0d4530903240206k6eecdabg2cbb2c5595cd4bc@mail.gmail.com>
	 <49C8B851.1010300@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 24 11:54:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm4GY-0006dX-At
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 11:53:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757194AbZCXKwW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2009 06:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756975AbZCXKwW
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 06:52:22 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:30922 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756337AbZCXKwV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2009 06:52:21 -0400
Received: by fg-out-1718.google.com with SMTP id e12so651350fga.17
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 03:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fyLgODPLoyLp4Cr4uKNQzCs1YbtA8jV955jEc30u/XA=;
        b=PgnjLhi+tJu83vwm2OVoXd6HKtYL47oagWpsB8/jdxGAtnlBHMzmqaRMzl8SpThUF8
         rHxoohpfVmdikToG9r4tYmoy4cQgSF0Ofle4b0NXe8tJH+SwrewyPBitu0+G+Ad9MxKJ
         OWgepeqxDfgdvMn4PBR0nK58mUvNj2OkVRM3w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Lk3d8USeJPvTHquTs0TOZ2xG8e3t5Ysdmicuz/yApSBEjTi2G6raohwGebI73oEWKp
         +KoT6mwnbaFrEjiwiC3idmhTClqGYwWB1taXtsH4mDEgckrqlRV0SMf0lBV2tfj5Z5rj
         iDwGLVs5TbQXYT2+S3RhXZF2zUC7Z8Q4XSaxM=
Received: by 10.86.49.13 with SMTP id w13mr244413fgw.76.1237891938463; Tue, 24 
	Mar 2009 03:52:18 -0700 (PDT)
In-Reply-To: <49C8B851.1010300@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114447>

On Tue, Mar 24, 2009 at 12:39 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Felipe Contreras venit, vidit, dixit 24.03.2009 10:06:
>> On Tue, Mar 24, 2009 at 10:29 AM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>> Felipe Contreras venit, vidit, dixit 24.03.2009 01:21:
>>>> On Mon, Mar 23, 2009 at 5:20 PM, Michael J Gruber
>>>> <git@drmicha.warpmail.net> wrote:
>>>>> Felipe Contreras venit, vidit, dixit 23.03.2009 11:31:
>>>>>> On Mon, Mar 23, 2009 at 8:42 AM, Jeff King <peff@peff.net> wrote=
:
>>>>>>> On Sun, Mar 22, 2009 at 08:05:15PM +0200, Felipe Contreras wrot=
e:
>>>>>>>
>>>>>>>> =C2=A0tt.literal, code.literal {
>>>>>>>> =C2=A0 =C2=A0color: navy;
>>>>>>>> + =C2=A0font-size: 1em;
>>>>>>>> +}
>>>>>>>
>>>>>>> Isn't 1em already the default size? Or are you trying to overri=
de some
>>>>>>> other size specification elsewhere? It's hard to tell what the =
goal is
>>>>>>> because your commit message merely says "improve".
>>>>>>
>>>>>> That's correct.
>>>>>>
>>>>>> The problem is that when the user has a different size for the
>>>>>> sans-serif and monospace fonts it looks horrible when they are o=
n the
>>>>>> same paragraph. I thought 1em did the trick, but you are right, =
it
>>>>>> doesn't.
>>>>>>
>>>>>> It looks like the only way to fix this is to set absolute sizes.
>>>>>>
>>>>>
>>>>> Also, it seems that everything which is not black is blue, except=
 for
>>>>> terms, which are green and slanted. I don't think that looks nice
>>>>> together. How about slanted blue?
>>>>
>>>> What's wrong with having 2 colors?
>>>
>>> I don't mind having 2, they just don't look good together over here=
, on
>>> my screen and to my eyes...
>>>
>>> Right now we have "plain old asciidoc look" which doesn't look that=
 old
>>> after all. You pointed out a deficiency, and I'm all for fixing it.=
 I
>>> just think that introducing new colors is something that may requir=
e a
>>> ground up rethinking of the theme being used: make it informative b=
ut
>>> unobtrusive. Also, I'm against over-emphasizing: use slanted or a
>>> specific color, but not both. Unless one color means emphasizing an=
d
>>> slanted means file, for example.
>>
>> Take a look at:
>> http://people.freedesktop.org/~felipec/git/user-manual.html#bisect-m=
erges
>>
>> Do you think slanting Z (and the other characters) is enough to emph=
asize it?
>>
>
> In that case I actually don't know why to emphasize the commit names =
at
> all. (And not all are emphasized.) If it's about distinguishing upper
> case letters from commit names, i.e. denoting the latter as variables=
,
> then slanting them suffices.
>
> I don't wnat to complicate thos or blow this up or anything, but (as =
I
> pointed out in another thread) we need a style guide first, something=
 like:
>
> - Write commands in backticks.
> - Write arguments (appearing apart from the command) in backticks.
> - Write paths as 'path'.
> - Write quotation in ``quotation''.
> - Write commit names as ?
>
> Then, after having the semantic markup distinction (which we don't ha=
ve
> right now) <snip/>

That's exactly what my patches are trying to do. Since asciidoc
doesn't have that many distinctions I followed a slightly more general
guideline; if 'foo' is not distinct enough, then do '"foo"'. In some
places I was lazy, so I did 'Z' instead of '"Z"', but again, this is
only RFC.

After a bit more thinking I think some long texts like
remote.<name>.url should also be '"remote.<name>.url"'.

Also, you cannot apply a general rule, like 'all commands should have
backticks'. Some command are meant to be emphasized while others have
been repeated so often that it doesn't make sense. The same applies
with links.

--=20
=46elipe Contreras
