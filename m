From: Amos King <amos.l.king@gmail.com>
Subject: Re: [PATCH 2/2] Allow http authentication via prompt for http push.
Date: Fri, 20 Mar 2009 07:38:41 -0500
Message-ID: <d8c371a80903200538t71adbca5hc11aae2ea1e36c9@mail.gmail.com>
References: <d8c371a80903190812w59febbd3qc6bc3d70ce85f76e@mail.gmail.com>
	 <alpine.DEB.1.00.0903191755270.6357@intel-tinevez-2-302>
	 <d8c371a80903191202v6fb974f4t2321761d0cf21a70@mail.gmail.com>
	 <49C35891.7010004@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 20 13:40:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lke1G-0003VI-T0
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 13:40:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752765AbZCTMip convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Mar 2009 08:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752373AbZCTMip
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 08:38:45 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:36058 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189AbZCTMin convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2009 08:38:43 -0400
Received: by qw-out-2122.google.com with SMTP id 8so818702qwh.37
        for <git@vger.kernel.org>; Fri, 20 Mar 2009 05:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Le6cUQuh/DkthIPyS2w0qs1UxaUgiFD+N653OUWdWe4=;
        b=Z4U1krdaub9ZoPgmL2SAVX6WikKsM831rZQZ9sVqlUk5sxkBUwLbQBlZVyuWZHQK5V
         eyK+gBR4arqmvGtWZ29sLP9YMEApB8h+GRPzoGmWzLqK3kqdYk48IydDBZnFAzDh/5Vo
         ztOk76QqQQ5H3yEL0dmeErMO8tsdE0phtqRVU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=q+l9+zX8jlfsIK6Bi9WsdPGTZLVLoie73rFTcytKLE51kSExrUETpnhjwdUqT0Ese0
         djUSksE/Xhkap9UUbzaH4VDkWXapEMzXTpZE14sZ5jEITcn0xT0b1a7Bmf4CcD3Wmu0T
         UD2NvGZNJJCcGmxQtHAueLRAy/fWZn0tKIW8g=
Received: by 10.229.109.194 with SMTP id k2mr2027033qcp.6.1237552721635; Fri, 
	20 Mar 2009 05:38:41 -0700 (PDT)
In-Reply-To: <49C35891.7010004@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113949>

Where are the typos and I will fix them?

As far as my response, I will only apologize for my choice of words
and not my message.  Being rude does not encourage developers to
continue to try to improve git.  Almost every time I see Dscho respond
he says something about the little precious time he has, but doesn't
seem to respect the fact that other people are taking their precious
free time to prepare and submit the patches.  Continue with rude
comments and you will lose great developer after great developer.

Again I am sorry for the words I chose, and it was uncalled for.
Before anyone responded to my email I sent this to Dscho:

> Sorry for the way I responded.  It was not very appropriate of me.  I
> do think that if you would take a little tact in your approach that
> you would keep developers trying to improve the code they are putting
> into git, and trying to contribute more often.

Amos

On Fri, Mar 20, 2009 at 3:49 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Amos King venit, vidit, dixit 19.03.2009 20:02:
>> The issue with calling it remote is that it conflicts with the remot=
e
>> struct that is need for http_init, and is used in the rest of the
>> code. =C2=A0So do you want me to make this small impact change or a =
larger
>> and more broad sweeping change by changing the name of the other
>> remote. =C2=A0I don't believe fake is a better name. =C2=A0I would h=
ope that at
>> some point the 'repo' struct would go away and we can make http_push
>> work like all the other remote commands.
>>
>> I also believe that 'out' is the correct word. =C2=A0It was not a ty=
po, and
>> I appreciate your suggestion of assuming that I can't spell just
>> because I used a word that you didn't understand. =C2=A0I'm not buil=
ding
>> OUR authorization. =C2=A0I am building OUT authorization. =C2=A0Have=
 you heard
>> of building something out? =C2=A0Or even fleshing something out?
>>
>> I appreciated your first responses to my other patch. =C2=A0Even if =
your
>> tone was that of a person with low self-esteem who needs to pick
>> unimportant details apart in order to stroke their own ego. =C2=A0In=
stead
>> of responding in the same tone I thought I would respond nicely and
>> get your feedback. =C2=A0Responses like your first one don't cause p=
eople
>> to want to continue to contribute to the community.
>>
>> I have a great idea. =C2=A0Why don't you try using the 'nice' tense =
in your
>> next email instead of the high and mighty 'ass-hole' tense. =C2=A0Th=
en I
>> will gladly not use past tense in my commit messages, and others mig=
ht
>> respond more positively to your criticisms.
>>
>> Fiek Dich,
>> Amos
>
> We don't want these obscenities on this list, whether in plain Englis=
h
> or wrong German!
>
> In fact, Dscho's criticism was not only constructive but nice, and no=
t
> only by his standards.
>
> You managed to have at least 2 (3 by our count) typos in one line, an=
d
> Dscho pointed that out correctly and nicely.
>
> Your second response (which I saw just before hitting send) doesn't s=
how
> much new insight regarding the latter two points. I'll consider the
> first one dealt with by it.
>
> Michael
>
>> On Thu, Mar 19, 2009 at 11:59 AM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>> Hi,
>>>
>>> On Thu, 19 Mar 2009, Amos King wrote:
>>>
>>>> There is now a faux remote created in order to
>>>> be passed to http_init.
>>>>
>>>> Signed-off-by: Amos King <amos.l.king@gmail.com>
>>>> ---
>>>> =C2=A0http-push.c | =C2=A0 11 ++++++++++-
>>>> =C2=A01 files changed, 10 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/http-push.c b/http-push.c
>>>> index 9ac2664..468d5af 100644
>>>> --- a/http-push.c
>>>> +++ b/http-push.c
>>>> @@ -2195,7 +2195,16 @@ int main(int argc, char **argv)
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0 memset(remote_dir_exists, -1, 256);
>>>>
>>>> - =C2=A0 =C2=A0 http_init(NULL);
>>>> + =C2=A0 =C2=A0 /*
>>>> + =C2=A0 =C2=A0 =C2=A0* This is a faked remote so that http_init c=
an
>>>> + =C2=A0 =C2=A0 =C2=A0* get the correct data for builidng out atho=
rization.
>>>> + =C2=A0 =C2=A0 =C2=A0*/
>>>
>>> You might want to pass this through aspell ;-) =C2=A0Altough it wil=
l not
>>> suggest 'out ->our', I guess...
>>>
>>>> + =C2=A0 =C2=A0 struct remote *remote;
>>>> + =C2=A0 =C2=A0 remote =3D xcalloc(sizeof(*remote), 1);
>>>> + =C2=A0 =C2=A0 ALLOC_GROW(remote->url, remote->url_nr + 1, remote=
->url_alloc);
>>>> + =C2=A0 =C2=A0 remote->url[remote->url_nr++] =3D repo->url;
>>>> +
>>>> + =C2=A0 =C2=A0 http_init(remote);
>>>
>>> Would 'fake' not be a more appropriate name than 'remote'?
>>>
>>> That would also make the patch 1/2 rather unnecessary (I also have =
to
>>> admit that I do not find 'repo' a better name, as we have a reposit=
ory
>>> both locally and remotely, and this _is_ the remote repository, not=
 the
>>> local one).
>>>
>>> Ciao,
>>> Dscho
>>>
>>>
>>
>>
>>
>
>



--=20
Amos King
http://dirtyInformation.com
http://github.com/Adkron
--
Looking for something to do? Visit http://ImThere.com
