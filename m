From: Robert Buck <buck.robert.j@gmail.com>
Subject: Re: how do I create a branch and push it so several developers can
 share work?
Date: Wed, 8 Sep 2010 19:01:28 -0400
Message-ID: <AANLkTiknS8vwqWRVn49eaEEbmQ-iqBa6zpgq6Y=nB326@mail.gmail.com>
References: <AANLkTinO9TVyg6EBS1ZuQPS+VWxzODmLan0sDGzFw8eh@mail.gmail.com>
	<20100908224041.GB8466@vfa-6z.perlninja.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 09 01:01:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtTe6-0004m8-0S
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 01:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756620Ab0IHXBc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Sep 2010 19:01:32 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:37007 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756615Ab0IHXBa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Sep 2010 19:01:30 -0400
Received: by ewy23 with SMTP id 23so512771ewy.19
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 16:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rBX2AEokSAlAl/4n6pmHa5Rmi35GRZERejBg0QXFP5A=;
        b=BaoTO5CfdH5hwOMl98pYJ10Cxl1Tg7WG/4oGG7MPSSfn8wIkglCQ3AjB1YqMAb33Wy
         tcswiSt5ZVgVyETCpHmaxvaedsABCNoqTJDNzO9U3yPQIPbXnHVN1z+gybcIwaHMBg0Q
         +6vXTYp2tDWpwulB7DYnP8TcP72srGfYJcBa8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=yDsy54i1tcIpTJfs4RiqDPuqEVEYGKF9UH/Lgz4r6c0476M2fhU+xQiC7wGkAasfE7
         Av4aWGW6oR+MJPD5HOrfVf1VnlFZs2nnV4uu8shHNKa/CGS5C7PqftPT7R/CVLbCcpOw
         SveLbiz30iPNVH42hXK9x2C3HmDWqN6v8stQA=
Received: by 10.14.119.3 with SMTP id m3mr771826eeh.22.1283986889012; Wed, 08
 Sep 2010 16:01:29 -0700 (PDT)
Received: by 10.14.4.11 with HTTP; Wed, 8 Sep 2010 16:01:28 -0700 (PDT)
In-Reply-To: <20100908224041.GB8466@vfa-6z.perlninja.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155821>

Thanks Jacob. I thought I had done it right, but when I cloned and did
not get what I expected at first, I was a bit concerned. Thanks.

Related question, is there a way to have fullers show up automatically
as a local branch for developers simply through a `git clone`?



On Wed, Sep 8, 2010 at 6:40 PM, Jacob Helwig <jacob.helwig@gmail.com> w=
rote:
> On Wed, 08 Sep 2010 18:31:30 -0400, Robert Buck wrote:
>>
>> We just switched over to git and also use gitolite.
>>
>> To create a new branch and push it so a team of developers can
>> collaborate on that branch I performed the following commands:
>>
>> Listed available tags:
>> git fetch --tags
>>
>> Listed available branches, which for me only showed one, master:
>> git branch
>>
>> Created the branch off the tag:
>> git branch fullers tagduvel
>>
>> Checked out the branch to verify the contents:
>> git checkout fullers
>> ...
>>
>> Push the branch to the remote repository:
>> git push origin fullers
>>
>> Now, when I clone the repository and list the branches I only see
>> 'master'. If I list the branches with the -a option I see something =
I
>> did not anticipate:
>> git branch -a
>> * master
>> =C2=A0 remotes/origin/HEAD -> origin/master
>> =C2=A0 remotes/origin/duvel
>> =C2=A0 remotes/origin/fullers
>> =C2=A0 remotes/origin/master
>>
>> What I had expected was a fullers branch.
>>
>> So apparently I did something very wrong here. What did I do wrong?
>>
>> Thanks,
>>
>> Bob
>
> You didn't do anything wrong at all. =C2=A0That's exactly what I'd ex=
pect to
> see at the end. =C2=A0Git doesn't automatically create local branches=
 (the
> ones without remotes/.../ in front) for any branches other than the o=
ne
> pointed to by remotes/origin/HEAD.
>
> The other developers will still have your fullers branch available to
> them, but if they want to do any work on it, they'll need to do
> something like "git checkout -b fullers origin/fullers" to create a
> local branch, which they can modify.
>
> --
> Jacob Helwig
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
>
> iQGcBAEBAgAGBQJMiBDiAAoJEHJabXWGiqEBu1cL+gNCu5BiRFytPSi7IsjPNk81
> dPO6AX69K1hq22eShO0Li62NPDhM4B8H5aXAlfdtjVLz/VdRrAiuBaW2zX0eUaQ6
> i7k3vl+QeyDt02UphG9mM8dEYivrh7UUozQ3OVTYitkN5+3kmfg7tw+7pF7+Z6Et
> LZ7bRUb3pzEaD8sKSKNbqjSpj9bqo2aCdgZFd+fE8yzNDmpE6wQby9vks15IOtPd
> Skh+SjhmD9yNL6LC3+8989muxXomi2gZvXIcCyBy/ECexeLSTOQGH6JX086TIqus
> rVKn7UNNncNzB2Q/lY8VM89A7zTyEdFhIbh8xkbEEGPGkGTU3t/TOwANGU0Q3rRO
> ymNJYLhg9cg+JWnO04f5gTPI66df4J16ctqIEWqBiqK6gm+8/VlLyz2H4yIvxRfW
> zocPp3ae/JsKIYKAqBPwFaeNgW4mHMmLlnv6Gc96ZscFE66dj5HgwuY80B6pNSqR
> U3H3VJGWNJsAceByhArsaytrzLURbxqpE4a79IuVIg=3D=3D
> =3Dfj56
> -----END PGP SIGNATURE-----
>
>
