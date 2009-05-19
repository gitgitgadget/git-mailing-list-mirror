From: Ping Yin <pkufranky@gmail.com>
Subject: Re: git subtree: an alternative to git submodule
Date: Tue, 19 May 2009 22:27:03 +0800
Message-ID: <46dff0320905190727m77a582c1j5ddc161230cc4a83@mail.gmail.com>
References: <1241822349-27470-1-git-send-email-apenwarr@gmail.com>
	 <32541b130905150909h7e596f26w7db6887e7f4267ff@mail.gmail.com>
	 <7vzldes0ce.fsf@alter.siamese.dyndns.org>
	 <32541b130905151131h76048ff2o418764aa41bcd13b@mail.gmail.com>
	 <46dff0320905180855m3e1bd74esb564af0fbcf4b1ff@mail.gmail.com>
	 <32541b130905180938v5dd5283g6b75ffb7e76f3280@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 19 16:27:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6QHt-0007e3-4I
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 16:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748AbZESO1F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 May 2009 10:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753498AbZESO1E
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 10:27:04 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:29752 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbZESO1C convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 May 2009 10:27:02 -0400
Received: by yx-out-2324.google.com with SMTP id 3so2412860yxj.1
        for <git@vger.kernel.org>; Tue, 19 May 2009 07:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/cNBRo75kvRhKGszBVcegCaLxxu5G5iwhQW0yjgfGHw=;
        b=LWDXIGhn/BdgrAJ0y9GUThUzIhQTh6JaCc28eW0FF4R/3mRL/RqzYqjwqV1W94tSk5
         1ihV3Z8FOikc82CFIMjsvEXrOY45XLPALFAlhIIFq/u0gRITAu05HvJLx07WybOQf6p7
         pOw9Bj7U0+fdCPk0kc6r6A/Ui4nrpcsROGd2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dbCRbWL+CkFGb8s151Yrwk/fa04xZniNdoHGMbcfdzBmUcaAFbP0T0UKK8lbwDUZWe
         ZS7Dr+qUbKIZl8Zm+AU0x6U5NUmosCTK7GJaPvFtpVNjqPRoJk++4IfJLfjvN+P4mKyv
         7gxZloBUIfl0ZExuJwWG2hBSRhl+A+IP+lcQw=
Received: by 10.90.118.8 with SMTP id q8mr79127agc.80.1242743223854; Tue, 19 
	May 2009 07:27:03 -0700 (PDT)
In-Reply-To: <32541b130905180938v5dd5283g6b75ffb7e76f3280@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119534>

On Tue, May 19, 2009 at 12:38 AM, Avery Pennarun <apenwarr@gmail.com> w=
rote:
> On Mon, May 18, 2009 at 11:55 AM, Ping Yin <pkufranky@gmail.com> wrot=
e:
>> It's really a cool feature, but i havn't tried it. Why?
>>
>> It will spends me some time saving and applying the patches and then
>> testing it (i don't have the appropriate environment setuped). But I
>> am busy and there is no urgent need to use this feature ( it is only=
 a
>> rare case for me). =C2=A0So i will wait until i need the feature or =
there
>> is an easy to fetch the code ( pu of official reposotory or other
>> repository with these patches applied).
>
> Excellent, thanks for the feedback. =C2=A0In fact you can git clone t=
he
> code from here:
>
> =C2=A0git clone git://github.com/apenwarr/git-subtree.git
>
> (It's not a copy of the git repo; it's a tiny standalone repo.)
>
> The important file is 'git-subtree'. =C2=A0Copy this anywhere on your=
 PATH,
> and magically the 'git subtree' command will work.
>
> I admit that your next roadblock will probably be lack of
> documentation, though, as Junio points out.
>

Some problems after trying.

* "split" generates a commit hash which i take some time to figure out
the meaning. May it should accept one more argument (repository name)
to generate the repository directly?

* "pull" creates the merged files to the wrong directory. Following is
the output

git subtree -d pull --prefix=3Dfoo git@example.com:foo.git master
command: {pull}
quiet: {}
revs: {}
dir: {foo}
opts: {git@example.com:foo.git master}

+ git pull -s subtree git@example.com:foo.git master
=46rom example.com:foo
 * branch            master     -> FETCH_HEAD
Merge made by subtree.
 scripts/data.example/creatives/1.swf     |  Bin 0 -> 174109 bytes
 scripts/data.example/creatives/2.swf      |  Bin 0 -> 103622 bytes
 scripts/data.example/creatives/3.swf |  Bin 0 -> 35347 bytes
 scripts/data.example/creatives/4.swf  |  Bin 0 -> 16300 bytes
 5 files changed, 0 insertions(+), 0 deletions(-)
=2E..


* "merge" doesn't respect the prefix option. With the following
commands, foo.txt is not merged to subdir foo/

touch foo.txt && git add foo.txt && git commit -m "add foo.txt"
git branch foo  && git reset --hard HEAD^
git subtree merge --prefix=3Dfoo foo
