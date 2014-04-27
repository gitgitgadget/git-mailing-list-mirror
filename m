From: Marius Ungureanu <marius.ungureanu@xamarin.com>
Subject: Re: [PATCH 2/2] add csharp userdiff tests
Date: Sun, 27 Apr 2014 19:46:30 +0300
Message-ID: <CF7066B0-539D-4FAB-8845-8ED60DF1F17E@xamarin.com>
References: <29F78086-81B4-481F-9051-FF3EEBA9BB08@xamarin.com> <535B5BFF.40002@kdbg.org> <97789B23-A375-46B1-99FD-A851A15C2D85@xamarin.com> <535BF1C0.7080204@kdbg.org> <1EA6F663-54DC-4665-A88C-8627F38B356E@xamarin.com> <535BFFEB.8040103@kdbg.org> <3A0D05C9-C222-463E-BCD4-CD38F216E352@xamarin.com> <535D2E0C.40101@kdbg.org>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Apr 27 18:45:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeSD4-0001Pa-C3
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 18:45:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342AbaD0Qpc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Apr 2014 12:45:32 -0400
Received: from mail-ee0-f52.google.com ([74.125.83.52]:51143 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497AbaD0Qpa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Apr 2014 12:45:30 -0400
Received: by mail-ee0-f52.google.com with SMTP id e49so4169441eek.11
        for <git@vger.kernel.org>; Sun, 27 Apr 2014 09:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xamarin.com; s=google;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XNg/3cagLgKIB+bdVi+ELtuIIPRH5T5YN1M8+9/Hy7M=;
        b=Xi3zW3kAfD4OMDtIoPqial8Vb1GkS8Xo9y5uWD3Q0MO9zyOYzSszEjIm1yBrR/C/Qa
         5Bw5GWypRacDmVFa9bsdrF1GXpILpekm6YRVVyATLz7pgpTS862I7fXLRsEjPZ2b5f1+
         ckYkLEulA47lFPKWpX9TKCVhb/g+20xaNs1oU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=XNg/3cagLgKIB+bdVi+ELtuIIPRH5T5YN1M8+9/Hy7M=;
        b=l9/aDVkws4G730x4n8gNbhT6hUzyigPYS7jixHRvt6W3wb9rvm38YT/vhsNGL9vgAA
         cc6+h4M/1OWK4XD5Rb+4Ik2DKoKi/z/UAbQFZHYFDYZleMWGg5x93g2JFK/m9gIzJgbX
         6qb2jSRw+DKJv/EtRztuyfbtSzRRD9URoWe0bi6UTI33wmOlvuw6C2993vSBnWHzhR67
         udfmYNEmvKGJfIV6oF3Yjt8bUqGnmYmD7J0JIEAHVMeduwNgxAvQGcHYryP1jOZ7ChHG
         JxEnSc1BYGdaJ8TPea8Uy0Dq0z2mkySnV3vSE263dkZF201UC2aZkVkO00HDTf7OUXxy
         NPVQ==
X-Gm-Message-State: ALoCoQlgz2t0hp/vxONbCktBE+ONE952X9NKoao2F0g13A/XtFi6i1UzYeaAbQZZqxv2EBnsAyz4
X-Received: by 10.14.211.66 with SMTP id v42mr26311986eeo.31.1398617128689;
        Sun, 27 Apr 2014 09:45:28 -0700 (PDT)
Received: from [192.168.1.101] ([188.26.30.123])
        by mx.google.com with ESMTPSA id x45sm42940598eeu.23.2014.04.27.09.45.27
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Apr 2014 09:45:28 -0700 (PDT)
In-Reply-To: <535D2E0C.40101@kdbg.org>
X-Mailer: Apple Mail (2.1874)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247206>


On 27 Apr 2014, at 19:19, Johannes Sixt <j6t@kdbg.org> wrote:

> Am 27.04.2014 15:47, schrieb Marius Ungureanu:
>>=20
>> ---
>=20
> Thanks. Please signed off your patch.
>=20

Ah, yes, forgot to do that.

> When you re-send, please place [PATCH v3 n/m] in the subject (and dro=
p
> the "Re:") and note what you changed compared to the previous (or all
> earlier) rounds. The place for this note is here, after the "---" mar=
ker.
>=20
> Have a look at Documentation/SubmittingPatches.
>=20

Will do so.

>> t/t4018/csharp-constructor | 4 ++++
>> t/t4018/csharp-destructor  | 4 ++++
>> t/t4018/csharp-function    | 4 ++++
>> t/t4018/csharp-member      | 4 ++++
>> t/t4018/csharp-namespace   | 4 ++++
>> t/t4018/csharp-operator    | 4 ++++
>> t/t4018/csharp-property    | 4 ++++
>> t/t4018/csharp-skip-call   | 5 +++++
>> 8 files changed, 33 insertions(+)
>> create mode 100644 t/t4018/csharp-constructor
>> create mode 100644 t/t4018/csharp-destructor
>> create mode 100644 t/t4018/csharp-function
>> create mode 100644 t/t4018/csharp-member
>> create mode 100644 t/t4018/csharp-namespace
>> create mode 100644 t/t4018/csharp-operator
>> create mode 100644 t/t4018/csharp-property
>> create mode 100644 t/t4018/csharp-skip-call
>>=20
>=20
> Unfortunately, I think you have reduced the test cases too far. One o=
f
> the main properties of C# code is that usually member and property
> definitions are indented and there is a class definition around them:
>=20
>  class Foo {
>     Foo(X) {}
>     virtual void DoStuff() {}
>     public int X;
>  };
>=20
> In your examples, you omitted the surrounding class definition and di=
d
> not indent the member definitions. By doing so, the test cases do not
> demonstrate that the csharp userdiff patterns are significantly
> different from the default userdiff pattern: in the examples you
> present, the default pattern would have picked the same hunk headers =
as
> the csharp patterns!
>=20

Ah, I think I over judged minimal sample here. I=92ll do so.

Is it okay though if I add a few tests to show what is broken?

I think this can=92t be solved at a regex level.

> For a reviewer who is not (or only marginally) familiar with C# (like
> myself), it would have been very instructive to present patches with
> test cases that demonstrate weaknesses of the old patterns before
> patches that fix them. For example, you say that you fix the construc=
tor
> pattern. But I am unable to judge what is wrong and how you fix it. T=
he
> commit message is the right place to add text that helps reviewers.
>=20

Well, the previous pattern didn=92t match constructors as they should b=
e
at a logical level. That means, it considered the constructor name
as being the return type. It=92s just a logical change that helped with
writing operator function parsing.

> You can mark a userdiff test case that demonstrates a breakage by
> including the work "broken" somewhere in the file. See
> http://www.repo.or.cz/w/alt-git.git/commitdiff/9cc444f0570b196f1c5166=
4ce2de1d8e1dee6046
>=20
>> diff --git a/t/t4018/csharp-constructor b/t/t4018/csharp-constructor
>> new file mode 100644
>> index 0000000..a39cffb
>> --- /dev/null
>> +++ b/t/t4018/csharp-constructor
>> @@ -0,0 +1,4 @@
>> +MyClass(RIGHT)
>> +{
>> +	ChangeMe;
>> +}
>> diff --git a/t/t4018/csharp-destructor b/t/t4018/csharp-destructor
>> new file mode 100644
>> index 0000000..55106d9
>> --- /dev/null
>> +++ b/t/t4018/csharp-destructor
>> @@ -0,0 +1,4 @@
>> +~MyClass(RIGHT)
>> +{
>> +	ChangeMe;
>> +}
>> diff --git a/t/t4018/csharp-function b/t/t4018/csharp-function
>> new file mode 100644
>> index 0000000..a5d59a3
>> --- /dev/null
>> +++ b/t/t4018/csharp-function
>> @@ -0,0 +1,4 @@
>> +virtual DoStuff(RIGHT)
>> +{
>> +	ChangeMe;
>> +}
>> diff --git a/t/t4018/csharp-member b/t/t4018/csharp-member
>> new file mode 100644
>> index 0000000..4939d53
>> --- /dev/null
>> +++ b/t/t4018/csharp-member
>> @@ -0,0 +1,4 @@
>> +unsafe class RIGHT
>> +{
>> +	int ChangeMe;
>> +}
>> diff --git a/t/t4018/csharp-namespace b/t/t4018/csharp-namespace
>> new file mode 100644
>> index 0000000..6749980
>> --- /dev/null
>> +++ b/t/t4018/csharp-namespace
>> @@ -0,0 +1,4 @@
>> +namespace RIGHT
>> +{
>> +	ChangeMe;
>> +}
>> diff --git a/t/t4018/csharp-operator b/t/t4018/csharp-operator
>> new file mode 100644
>> index 0000000..5b00263
>> --- /dev/null
>> +++ b/t/t4018/csharp-operator
>=20
> "csharp-user-defined-operator" would more precisely describe the case=
=2E I
> wouldn't mind seening other file names being a bit more elaborate, bu=
t I
> find this one particularly ambiguous.
>=20

Okay, I=92ll name them better. Also improve them.

>> @@ -0,0 +1,4 @@
>> +A operator+(RIGHT)
>> +{
>> +	ChangeMe;
>> +}
>> diff --git a/t/t4018/csharp-property b/t/t4018/csharp-property
>> new file mode 100644
>> index 0000000..82d67fc
>> --- /dev/null
>> +++ b/t/t4018/csharp-property
>> @@ -0,0 +1,4 @@
>> +public virtual int RIGHT
>> +{
>> +	get { ChangeMe; }
>> +}
>> diff --git a/t/t4018/csharp-skip-call b/t/t4018/csharp-skip-call
>> new file mode 100644
>> index 0000000..e89d083
>> --- /dev/null
>> +++ b/t/t4018/csharp-skip-call
>> @@ -0,0 +1,5 @@
>> +virtual void RIGHT()
>> +{
>> +	call();
>> +	ChangeMe;
>> +}
>=20
> In this last test case, you want to demonstrate that the line "call()=
"
> is not picked as hunk header. As written, the line would never be pic=
ked
> as hunk header, even if it would match some pattern, because it is to=
o
> close to "ChangeMe". You must have at least one more line between
> "call()" and "ChangeMe=94.
>=20

Oh, forgot about that.

> BTW, what is the expected hunk header in a diff like the following wh=
ere
> "class Foo" is at line 1 in the file (just above the hunk)?
>=20
> @@ -2,3 +2,3 @@
> {
> -   // old comment
> +   // new comment
>    public whatever()
>=20
> That is, when the class definition is undecorated (no "unsafe" etc.)

The class name should still get matched in that case even if it isn=92t=
 decorated.

>=20
> -- Hannes

Marius