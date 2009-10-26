From: Eugene Sajine <euguess@gmail.com>
Subject: Re: git push interface inconsistency
Date: Mon, 26 Oct 2009 19:39:32 -0400
Message-ID: <76c5b8580910261639p374c6391h3ae39bf4512c2f10@mail.gmail.com>
References: <76c5b8580910261525y5397b54eyf9c3d58c0fe19fce@mail.gmail.com>
	 <32541b130910261531o36b8ce7eh6bddf26a2ae15663@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 00:39:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2ZA2-0008Vw-OD
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 00:39:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754322AbZJZXj2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Oct 2009 19:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754110AbZJZXj2
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 19:39:28 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:54466 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753764AbZJZXj1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Oct 2009 19:39:27 -0400
Received: by ywh40 with SMTP id 40so8761921ywh.33
        for <git@vger.kernel.org>; Mon, 26 Oct 2009 16:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=46fsqmCU8ICyoQ8V8rOw1mc4bXbNsMpo2GZO4bQXc20=;
        b=oOlzwiAO2xkpSGXU4MpPRMhEugtMmes4LMBhxauQFPX2CXHKGAPNCMCw7giFWErHCu
         3fLRD4qkeQRDcOckoJCIW4wd8VjBqOdSmgBiDompQBvGoYKXt+4Py5DaBf11EcKZla7Q
         DjIzWoMpvhZ32buBnNX+ThsRUmWgfKBWzpAWk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dATF5vzagwkWM4I2yUpY3VK7Fe6CBa0HViy8m6PG1KRJfMAL5eBJnb7h7HCKxTHY+k
         KIXxtEERvDGWPtAAmkNsBnjOvWjDZP9jB8qOIPuqGDtTcX3d6w6+gAPdgQTjYAXrS14z
         6QuOiCeVAtuRhqlfjy9Ha/7Hx3NskxOFIWa1I=
Received: by 10.90.16.38 with SMTP id 38mr8287601agp.112.1256600372272; Mon, 
	26 Oct 2009 16:39:32 -0700 (PDT)
In-Reply-To: <32541b130910261531o36b8ce7eh6bddf26a2ae15663@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131285>

Got it.


Thanks!

On Mon, Oct 26, 2009 at 6:31 PM, Avery Pennarun <apenwarr@gmail.com> wr=
ote:
> On Mon, Oct 26, 2009 at 6:25 PM, Eugene Sajine <euguess@gmail.com> wr=
ote:
>> I have a question:
>>
>> Why I can't do
>>
>> $ git push my_tag
>>
>> It will fail because the remote is not specified, even if there is
>> only one origin remote
>>
>> but can do
>>
>> $ git push --tags
>>
>> and it will push tags to origin...
>
> Because 'my_tag' is interpreted as the name or URL of the remote, not
> as a branch name. =C2=A0You can do "git push origin" and it will gues=
s the
> branch name(s) to push, but because of that, the one-parameter push
> can't *also* be used to guess the remote name.
>
> In contrast, --tags is a flag, so it's actually the zero-parameter
> version of push, which assumes 'origin' and then guesses the branch
> name (and --tags changes the guessed result).
>
> Hope that helps.
>
> Have fun,
>
> Avery
>
