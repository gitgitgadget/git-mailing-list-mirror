From: Rusi Mody <rustompmody@gmail.com>
Subject: Re: crlf issues
Date: Fri, 19 Jun 2015 08:29:18 -0700 (PDT)
Message-ID: <06bed56e-b934-43e1-af1e-df1253c07dac@googlegroups.com>
References: <f96f4550-af8c-48b9-98ef-2c1f3282d8a7@googlegroups.com>
 <b1d861878d2f0a4414490439bf865cbb@www.dscho.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1446_838405911.1434727758858"
Cc: git@vger.kernel.org, rustompmody@gmail.com
To: msysgit@googlegroups.com
X-From: msysgit+bncBC3KJTP2RAOBBUHKSCWAKGQEBF5AUJY@googlegroups.com Fri Jun 19 17:29:24 2015
Return-path: <msysgit+bncBC3KJTP2RAOBBUHKSCWAKGQEBF5AUJY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yk0-f183.google.com ([209.85.160.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBC3KJTP2RAOBBUHKSCWAKGQEBF5AUJY@googlegroups.com>)
	id 1Z5yEL-0002d8-9G
	for gcvm-msysgit@m.gmane.org; Fri, 19 Jun 2015 17:29:21 +0200
Received: by ykq19 with SMTP id 19sf32522448ykq.0
        for <gcvm-msysgit@m.gmane.org>; Fri, 19 Jun 2015 08:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:x-original-sender:precedence:mailing-list
         :list-id:x-spam-checked-in-group:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe;
        bh=Z9ExyDlxzvknIaHjf5GhvDn3R1zxDvo11yK40nVXiUM=;
        b=QViQ6kdHJrCMbla6xcRIpHEBBD6jF+Jo4Gvtaxed73Z8QjJcbI1agugtvxBNOPIBLv
         lHrazpiXXTcGtKYr4yP2ehA7BN0KMxdL7HWEQDzSXWcLKpeANBDF+86hEwF3DbitlsDX
         TjAWxD8Us824Nu7JucJLQulBBICU0CXNxI82MwhFXz/TYMvl7wKBEAeil+K6zz4ToEkW
         IoKG6u/c4UiTEJZYUlCzNNVak4stdPnTp48Py1iVHTOAr/Td4ci+be/QOs/cYmsAX1GY
         oEHY+0IZA575PO74VFgv3JsQiq2TESa70B1fcQ6YxHdcNQTy9EwvewAM1+BD29UTOLG5
         Eh4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:x-original-sender:precedence:mailing-list
         :list-id:x-spam-checked-in-group:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe;
        bh=Z9ExyDlxzvknIaHjf5GhvDn3R1zxDvo11yK40nVXiUM=;
        b=vv0IHef//llCOTWlamwMbzXpF+Oz4dAgo5Qjz+fmXzk5K0m1b+3qiP6KKKcRZdfFyA
         c8knVJBGdbyo9DfAbvsp4DjPwALytuFhhypDnDig1rkHk/Xi90iB5HT8yx3UaGiCmLrD
         cp/HlXRC4nXzfsOLRaR6CfEI/Lcmu+AfZMV/baLT1w5OarBZvqrmAXG/Resal9LoPwof
         EELYSFAZVeaPEicPDv1vIjD07hCGrAbA0x4KptbawkIx8vck7ghX+iWTWg2HAZwZI4hi
         A/ETvBvtoNWmksgVEIR5C6XQc+1na4JvpNBvc6VqJXghvJ1LMD5NI4O5wuPLEjYH6lSs
         wlkQ==
X-Received: by 10.50.2.74 with SMTP id 10mr78214igs.5.1434727760480;
        Fri, 19 Jun 2015 08:29:20 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.107.47.13 with SMTP id j13ls1336275ioo.25.gmail; Fri, 19 Jun
 2015 08:29:19 -0700 (PDT)
X-Received: by 10.50.2.74 with SMTP id 10mr78212igs.5.1434727759952;
        Fri, 19 Jun 2015 08:29:19 -0700 (PDT)
In-Reply-To: <b1d861878d2f0a4414490439bf865cbb@www.dscho.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272162>

------=_Part_1446_838405911.1434727758858
Content-Type: multipart/alternative; 
	boundary="----=_Part_1447_1447938210.1434727758858"

------=_Part_1447_1447938210.1434727758858
Content-Type: text/plain; charset=UTF-8



On Friday, June 19, 2015 at 7:41:00 PM UTC+5:30, Johannes Schindelin wrote:
>
> Hi Rusi, 
>
> Cc:ing the main Git list, as some of this has been discussed at the 
> GitMerge in Paris, and some participants of that discussion might want to 
> join this thread. 
>   
> On 2015-06-19 14:55, Rusi Mody wrote: 
> > Trying to setup git. 
> > Majority folks are MS VS users but also some *nixers. 
> > 
> > My current understanding/analysis of the situation: 
> > 
> > 1. autocrlf is broken -- keep it false 
> > 2. safecrlf is a cure (to some extent) -- keep it true 
> > 3. core.eol can be left native (or is crlf on windows/lf on *nix 
> > preferred??) 
> > 
> > And of course most crucial: 
> > 4. Make sure ALL file types are covered in .gitattributes; eg 
> > 
> > *.txt text 
> > *.cs text 
> > : 
> > : 
> > *.pdf binary 
> > etc 
> > 
> > Still when we get a merge conflict the file (created by git with 
> conflict 
> > markers) shows ^M in vi 
> > ie I assume its unclean line endings. 
> > 
> > Any tips what to do? 
>
> The most important preliminary question is: how cross platform is your 
> project?


Somewhat complex question...
Almost completely windows as of now.
Good chance of starting to migrate to Linux shortly... little by little and 
would like to minimize future headches.
 

> If there is no risk of any developer working on a non-Windows platform, 
> you could simply commit CRLF and be done with it. 
>

Ok. So what are the (set of) settings for that?
- MS-only project
- No conversions any which way
seems to be a better starting compromise than broken to start with :-)


As to autocrlf: I actually had some good experience with setting it to 
> `input` when working with other developers. 
>


Can hardly claim to be expert on this but general impression I got from 
searching the net is autocrlf is more broken than working
and so best avoided
eg
http://stackoverflow.com/questions/2333424/distributing-git-configuration-with-the-code/2354278#2354278 

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

------=_Part_1447_1447938210.1434727758858
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br>On Friday, June 19, 2015 at 7:41:00 PM UTC+5:30, Johannes Schindeli=
n wrote:<blockquote class=3D"gmail_quote" style=3D"margin: 0;margin-left: 0=
.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">Hi Rusi,
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
>&nbsp;</div><blockquote class=3D"gmail_quote" style=3D"margin: 0;margin-le=
ft: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">If there is no ri=
sk of any developer working on a non-Windows platform, you could simply com=
mit CRLF and be done with it.
<br></blockquote><br>Ok. So what are the (set of) settings for that?<br>- M=
S-only project<br>- No conversions any which way<br>seems to be a better st=
arting compromise than broken to start with :-)<br><br><br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin: 0;margin-left: 0.8ex;border-left: =
1px #ccc solid;padding-left: 1ex;">As to autocrlf: I actually had some good=
 experience with setting it to `input` when working with other developers.
<br></blockquote><div><br><br>Can hardly claim to be expert on this but gen=
eral impression I got from searching the net is autocrlf is more broken tha=
n working<br>and so best avoided<br>eg<br>http://stackoverflow.com/question=
s/2333424/distributing-git-configuration-with-the-code/2354278#2354278 <br>=
</div>

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

------=_Part_1447_1447938210.1434727758858--
------=_Part_1446_838405911.1434727758858--
