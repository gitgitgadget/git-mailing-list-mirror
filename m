From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: EasyGit Integration
Date: Tue, 9 Jun 2009 16:42:33 -0400
Message-ID: <32541b130906091342s7dd6064fud2205bee8af95aab@mail.gmail.com>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com> 
	<32541b130906091252i6c96c44buc148bb525d7cde14@mail.gmail.com> 
	<20090609203747.GB13781@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 09 22:43:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME89s-0002Og-IN
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 22:43:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756293AbZFIUmw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2009 16:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756165AbZFIUmv
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 16:42:51 -0400
Received: from mail-gx0-f214.google.com ([209.85.217.214]:50090 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755777AbZFIUmv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2009 16:42:51 -0400
Received: by gxk10 with SMTP id 10so348854gxk.13
        for <git@vger.kernel.org>; Tue, 09 Jun 2009 13:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ElJvyM1QfxksycN5IMPcnX3pdbXFa9XFCQPXDEmg8Yo=;
        b=kogM1HISJlabll0zkm7HiMx8/Pto1kXhsL3gee5XcNKoDt+nwktHgfZjVkDNERQhPc
         9FnlYrssJtpYQLDvEi15NThIxBxKHISL/oabyMiY2Ze7upqVuXT8kHb122XcE8bgPmyD
         Z5lXbkzepTGJprOAw28Rqn/KpC3vTEAwFx7R4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ActA0N3ACmm3u29foNVpIo+yMjhmtl8VbHQ1ki7nn2dkB0lMAcHpJ8H3NftNjhu8Cb
         iWs5JmeXgTwJazNViG1G0jR75Pbv6NplZ4SJkICse7/MdzsAy6wr/gyue9uqzrNB80Xh
         JW6r+TesX+hYRDOrfxA7jGqU9HF4Jtz5+5XeY=
Received: by 10.151.136.6 with SMTP id o6mr1178997ybn.32.1244580173145; Tue, 
	09 Jun 2009 13:42:53 -0700 (PDT)
In-Reply-To: <20090609203747.GB13781@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121222>

2009/6/9 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
> On 2009.06.09 15:52:46 -0400, Avery Pennarun wrote:
>> To be honest, I'm not convinced svn's use of the word "revert" is
>> really right, though. =A0Git's isn't *really* right either, since it
>> actually makes a new commit, it doesn't remove the old one like it
>> sounds like it does. =A0Maybe 'reverse' would be a better name for w=
hat
>> git does, and we should just introduce another word for what svn doe=
s.
>> =A0(With CVS, you just deleted the file and then did a checkout/upda=
te
>> on it again, which made sense to me. =A0That works in git too.)
>>
>> Crazy idea: we could actually make 'git revert' do both: given a
>> commit, it applies the reverse as it does now. =A0Given filenames, i=
t
>> simply brings them back to HEAD. =A0But maybe that's too crazy.
>
> Doesn't seem that crazy to me. But maybe a bit problematic if you wan=
t
> to support both, "git checkout -- ." and "git checkout HEAD -- .". An=
d
> adding DWIMmery there seems dangerous, as in:
>
> git revert =3D=3D git checkout -- .
>
> git revert HEAD =3D=3D
> =A0no uncommitted changes =3D revert commit HEAD
> =A0uncommitted changes =3D revert to HEAD

Well, that's what I meant by "crazy" :)

Since so many of the other suggestions in eg are so simple and
non-conflicting, perhaps it's best to drop this branch of discussion
until the non-controversial bits are adopted.  It would be bad to lose
other great improvements just because this one command is
problematic...

Have fun,

Avery
