From: Rusi Mody <rustompmody@gmail.com>
Subject: Re: crlf issues
Date: Fri, 19 Jun 2015 23:21:54 -0700 (PDT)
Message-ID: <d9cb6527-e137-4b55-95e6-c3d08557d905@googlegroups.com>
References: <f96f4550-af8c-48b9-98ef-2c1f3282d8a7@googlegroups.com>
 <b1d861878d2f0a4414490439bf865cbb@www.dscho.org>
 <06bed56e-b934-43e1-af1e-df1253c07dac@googlegroups.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_2032_1496723800.1434781314411"
Cc: git@vger.kernel.org
To: msysgit@googlegroups.com
X-From: msysgit+bncBC3KJTP2RAOBBBENSSWAKGQET6UC57I@googlegroups.com Sat Jun 20 08:21:58 2015
Return-path: <msysgit+bncBC3KJTP2RAOBBBENSSWAKGQET6UC57I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qk0-f185.google.com ([209.85.220.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBC3KJTP2RAOBBBENSSWAKGQET6UC57I@googlegroups.com>)
	id 1Z6CA9-0007pT-DC
	for gcvm-msysgit@m.gmane.org; Sat, 20 Jun 2015 08:21:57 +0200
Received: by qkbx78 with SMTP id x78sf36515105qkb.0
        for <gcvm-msysgit@m.gmane.org>; Fri, 19 Jun 2015 23:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:x-original-sender:precedence:mailing-list
         :list-id:x-spam-checked-in-group:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe;
        bh=CN96SJmxNCOyuGOZq3grLGNBlDE/eNfCkKrSgDpVj/M=;
        b=JmHF2PIVkgz9uegcbOdjblrmGx7k/hvPlQYarkwghBCnsDw3uNUeGQDn5SFhqTI2YU
         8v88JSJ75LX49okOf0E9aWMVUBftKIBRv6Ww2O0gZ0Ov0idu7ahzmgrZjJQxbXi30AaW
         x3srD2Mhs09V6eXbFpPq7rBoLIy5SQR/rW0z9OGFTQl0mhiFWxfY38srIcVSTAFPWmer
         UzSMNGNTXtagUu1w3MLql8/VDlzjqISn6GdXlgjY95hp1R5v5LEVtpadd+7QrNtsnK1h
         uk2aZvyTXW9t/zQYW0VWFpe8F2Wd+lIMOWgiVDMLcd1sbIzmL8qB8CaJ3nXsd12YY241
         RaWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:x-original-sender:precedence:mailing-list
         :list-id:x-spam-checked-in-group:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe;
        bh=CN96SJmxNCOyuGOZq3grLGNBlDE/eNfCkKrSgDpVj/M=;
        b=Lp7E14EpHusTdrxVd01NeFLaBCxsGVOgrIA706EnHNZDm6L8b0R1y74Hoj1VmtqTqE
         uVzXWMp/ubZZmzllviVti7R2cvXYTGpjoi+ytd4cgbDXDZjiHVLbQ8rE0ORf0V51SaQN
         b9H9eVD3TP1VDegq/MEdT1mM2qiGWp7ZlMp0t9XHakEbrExM/UP/mB0M63vdjeLsEKpa
         ys85eVJaFGJPklXHyZDWFYrGW0P0e3v2MFQYSDvFDEW64IZXl4JmQdlwzBXrYi/Yq5xe
         EGIF+SZNl5igwB8+1a5mk4c+vYzbHwvDvYom0ZwT1p8LL71McAbiNHtuJQQajaj4Tj+0
         nd8A==
X-Received: by 10.50.142.99 with SMTP id rv3mr143457igb.3.1434781316454;
        Fri, 19 Jun 2015 23:21:56 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.107.32.138 with SMTP id g132ls1620710iog.102.gmail; Fri, 19
 Jun 2015 23:21:55 -0700 (PDT)
X-Received: by 10.50.107.105 with SMTP id hb9mr143478igb.3.1434781315926;
        Fri, 19 Jun 2015 23:21:55 -0700 (PDT)
In-Reply-To: <06bed56e-b934-43e1-af1e-df1253c07dac@googlegroups.com>
X-Original-Sender: rustompmody@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272224>

------=_Part_2032_1496723800.1434781314411
Content-Type: multipart/alternative; 
	boundary="----=_Part_2033_1960949289.1434781314412"

------=_Part_2033_1960949289.1434781314412
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


On Friday, June 19, 2015 at 8:59:19 PM UTC+5:30, Rusi Mody wrote:
>
>
>
> On Friday, June 19, 2015 at 7:41:00 PM UTC+5:30, Johannes Schindelin wrot=
e:
>>
>> Hi Rusi,=20
>>
>> Cc:ing the main Git list, as some of this has been discussed at the=20
>> GitMerge in Paris, and some participants of that discussion might want t=
o=20
>> join this thread.=20
>>  =20
>> On 2015-06-19 14:55, Rusi Mody wrote:=20
>> > Trying to setup git.=20
>> > Majority folks are MS VS users but also some *nixers.=20
>> >=20
>> > My current understanding/analysis of the situation:=20
>> >=20
>> > 1. autocrlf is broken -- keep it false=20
>> > 2. safecrlf is a cure (to some extent) -- keep it true=20
>> > 3. core.eol can be left native (or is crlf on windows/lf on *nix=20
>> > preferred??)=20
>> >=20
>> > And of course most crucial:=20
>> > 4. Make sure ALL file types are covered in .gitattributes; eg=20
>> >=20
>> > *.txt text=20
>> > *.cs text=20
>> > :=20
>> > :=20
>> > *.pdf binary=20
>> > etc=20
>> >=20
>> > Still when we get a merge conflict the file (created by git with=20
>> conflict=20
>> > markers) shows ^M in vi=20
>> > ie I assume its unclean line endings.=20
>> >=20
>> > Any tips what to do?=20
>>
>> The most important preliminary question is: how cross platform is your=
=20
>> project?
>
>
> Somewhat complex question...
> Almost completely windows as of now.
> Good chance of starting to migrate to Linux shortly... little by little=
=20
> and would like to minimize future headches.
> =20
>
>> If there is no risk of any developer working on a non-Windows platform,=
=20
>> you could simply commit CRLF and be done with it.=20
>>
>
> Ok. So what are the (set of) settings for that?
> - MS-only project
> - No conversions any which way
> seems to be a better starting compromise than broken to start with :-)
>
>
> As to autocrlf: I actually had some good experience with setting it to=20
>> `input` when working with other developers.=20
>>
>
>
> Can hardly claim to be expert on this but general impression I got from=
=20
> searching the net is autocrlf is more broken than working
> and so best avoided
> eg
>
> http://stackoverflow.com/questions/2333424/distributing-git-configuration=
-with-the-code/2354278#2354278=20
>

I think I need to retract my complaint:
Tried a couple of times -- windows and linux.
Linux: there was never an issue
Windows: If the file-suffix is listed as text in .gitattributes there is no=
=20
issue
If not listed then the merge-conflict marked file is messed up =E2=80=93 ie=
 emacs=20
shows it as (Unix) with ^M on all lines except the lines with=20
conflict-markers added.

What I had earlier done different I am not quite sure...
So to ask again about strategy:
This is what seems to be working:
- core.eol native (leave as is)
- core.autocrlf false
- core.safecrlf true
- List all textish files in gitattributes (if not gitignore)

What I miss: A 'super-safecrlf' option which would would error-out upon any=
=20
file not explicitly listed in gitattributes as binary or text getting added=
.

Is there something like this?

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

------=_Part_2033_1960949289.1434781314412
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br>On Friday, June 19, 2015 at 8:59:19 PM UTC+5:30, Rusi Mody wrote:<block=
quote class=3D"gmail_quote" style=3D"margin: 0;margin-left: 0.8ex;border-le=
ft: 1px #ccc solid;padding-left: 1ex;"><br><br>On Friday, June 19, 2015 at =
7:41:00 PM UTC+5:30, Johannes Schindelin wrote:<blockquote class=3D"gmail_q=
uote" style=3D"margin:0;margin-left:0.8ex;border-left:1px #ccc solid;paddin=
g-left:1ex">Hi Rusi,
<br>
<br>Cc:ing the main Git list, as some of this has been discussed at the Git=
Merge in Paris, and some participants of that discussion might want to join=
 this thread.
<br>&nbsp;
<br>On 2015-06-19 14:55, Rusi Mody wrote:
<br>&gt; Trying to setup git.
<br>&gt; Majority folks are MS VS users but also some *nixers.
<br>&gt;=20
<br>&gt; My current understanding/analysis of the situation:
<br>&gt;=20
<br>&gt; 1. autocrlf is broken -- keep it false=20
<br>&gt; 2. safecrlf is a cure (to some extent) -- keep it true
<br>&gt; 3. core.eol can be left native (or is crlf on windows/lf on *nix=
=20
<br>&gt; preferred??)
<br>&gt;=20
<br>&gt; And of course most crucial:=20
<br>&gt; 4. Make sure ALL file types are covered in .gitattributes; eg
<br>&gt;=20
<br>&gt; *.txt text
<br>&gt; *.cs text
<br>&gt; :
<br>&gt; :
<br>&gt; *.pdf binary
<br>&gt; etc
<br>&gt;=20
<br>&gt; Still when we get a merge conflict the file (created by git with c=
onflict=20
<br>&gt; markers) shows ^M in vi
<br>&gt; ie I assume its unclean line endings.
<br>&gt;=20
<br>&gt; Any tips what to do?
<br>
<br>The most important preliminary question is: how cross platform is your =
project?</blockquote><br>Somewhat complex question...<br><div>Almost comple=
tely windows as of now.<br>Good chance of starting to migrate to Linux shor=
tly... little by little and would like to minimize future headches.<br><div=
>&nbsp;</div><blockquote class=3D"gmail_quote" style=3D"margin:0;margin-lef=
t:0.8ex;border-left:1px #ccc solid;padding-left:1ex">If there is no risk of=
 any developer working on a non-Windows platform, you could simply commit C=
RLF and be done with it.
<br></blockquote><br>Ok. So what are the (set of) settings for that?<br>- M=
S-only project<br>- No conversions any which way<br>seems to be a better st=
arting compromise than broken to start with :-)<br><br><br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0;margin-left:0.8ex;border-left:1px=
 #ccc solid;padding-left:1ex">As to autocrlf: I actually had some good expe=
rience with setting it to `input` when working with other developers.
<br></blockquote><div><br><br>Can hardly claim to be expert on this but gen=
eral impression I got from searching the net is autocrlf is more broken tha=
n working<br>and so best avoided<br>eg<br><a href=3D"http://stackoverflow.c=
om/questions/2333424/distributing-git-configuration-with-the-code/2354278#2=
354278" target=3D"_blank" rel=3D"nofollow" onmousedown=3D"this.href=3D'http=
://www.google.com/url?q\75http%3A%2F%2Fstackoverflow.com%2Fquestions%2F2333=
424%2Fdistributing-git-configuration-with-the-code%2F2354278%232354278\46sa=
\75D\46sntz\0751\46usg\75AFQjCNFYqMZn-KJDMXS4FhK0HTMabUEVHA';return true;" =
onclick=3D"this.href=3D'http://www.google.com/url?q\75http%3A%2F%2Fstackove=
rflow.com%2Fquestions%2F2333424%2Fdistributing-git-configuration-with-the-c=
ode%2F2354278%232354278\46sa\75D\46sntz\0751\46usg\75AFQjCNFYqMZn-KJDMXS4Fh=
K0HTMabUEVHA';return true;">http://stackoverflow.com/<wbr>questions/2333424=
/<wbr>distributing-git-<wbr>configuration-with-the-code/<wbr>2354278#235427=
8</a> <br></div></blockquote><div><br>I think I need to retract my complain=
t:<br>Tried a couple of times -- windows and linux.<br>Linux: there was nev=
er an issue<br>Windows: If the file-suffix is listed as text in .gitattribu=
tes there is no issue<br>If not listed then the merge-conflict marked file =
is messed up =E2=80=93 ie emacs shows it as (Unix) with ^M on all lines exc=
ept the lines with conflict-markers added.<br><br>What I had earlier done d=
ifferent I am not quite sure...<br>So to ask again about strategy:<br>This =
is what seems to be working:<br>- core.eol native (leave as is)<br>- core.a=
utocrlf false<br>- core.safecrlf true<br>- List all textish files in gitatt=
ributes (if not gitignore)<br><br>What I miss: A 'super-safecrlf' option wh=
ich would would error-out upon any file not explicitly listed in gitattribu=
tes as binary or text getting added.<br><br>Is there something like this?<b=
r></div>

<p></p>

-- <br />
-- <br />
*** Please reply-to-all at all times ***<br />
*** (do not pretend to know who is subscribed and who is not) ***<br />
*** Please avoid top-posting. ***<br />
The msysGit Wiki is here: <a href=3D"https://github.com/msysgit/msysgit/wik=
i">https://github.com/msysgit/msysgit/wiki</a> - Github accounts are free.<=
br />
&nbsp;<br />
You received this message because you are subscribed to the Google<br />
Groups &quot;msysGit&quot; group.<br />
To post to this group, send email to msysgit@googlegroups.com<br />
To unsubscribe from this group, send email to<br />
msysgit+unsubscribe@googlegroups.com<br />
For more options, and view previous threads, visit this group at<br />
<a href=3D"http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den">http:=
//groups.google.com/group/msysgit?hl=3Den_US?hl=3Den</a><br />
<br />
--- <br />
You received this message because you are subscribed to the Google Groups &=
quot;Git for Windows&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:msysgit+unsubscribe@googlegroups.com">msysgit+uns=
ubscribe@googlegroups.com</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

------=_Part_2033_1960949289.1434781314412--
------=_Part_2032_1496723800.1434781314411--
