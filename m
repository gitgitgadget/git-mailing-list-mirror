From: Craig Moore <craigtmoore@googlemail.com>
Subject: Re: Trouble with 'make prefix=/usr info'
Date: Wed, 6 Jan 2010 13:32:03 +0100
Message-ID: <d4133e471001060432v38a3f910qb27b9e77f4c1aa8b@mail.gmail.com>
References: <loom.20091222T164442-704@post.gmane.org>
	 <4B30ECA1.2040508@drmicha.warpmail.net>
	 <d4133e470912220814h465175bfr8fd10942898096a1@mail.gmail.com>
	 <4B310054.4060900@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jan 06 13:32:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSV3e-0004gB-80
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 13:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755748Ab0AFMcI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jan 2010 07:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755684Ab0AFMcI
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 07:32:08 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:38764 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755672Ab0AFMcG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jan 2010 07:32:06 -0500
Received: by bwz27 with SMTP id 27so10631391bwz.21
        for <git@vger.kernel.org>; Wed, 06 Jan 2010 04:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8GTiYF+YGs7LiRB4NrQSa3Z49Ztp0WAIdpLpFkxpBfc=;
        b=Kcv4FswoE5n4Jv1I8E/1TAEFYORDU23XqIO4ZgGDHq4e0IsyQOLlqgNgaunXOdbKp8
         /YNVNrtmx+A8sxRn/RVUUvmVKZ6PezdWwoSR4ZQx4gA2cQcJM626s4OSFWyia6qM9lko
         8z8FcRV/vlyy6oUULwGdiZsEw4IV3wVUROCsY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qCh2lxPfzob1L2bxBg1OG4Gxj7mYPjCpPeJ50u0z5bcnFRwIIBjBzR4qqkLWjA/TOG
         nODjrutQG41zKUgK095j3DFyFFzQwk5qqdwp5hs838A7Kwt0P2R9wimkvfn34h/WD0sS
         KOLCA3UrQqqRQ1Cs8aahDdNGOpQzFY/XzAuh4=
Received: by 10.204.154.150 with SMTP id o22mr8580024bkw.154.1262781123262; 
	Wed, 06 Jan 2010 04:32:03 -0800 (PST)
In-Reply-To: <4B310054.4060900@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136265>

2009/12/22 Michael J Gruber <git@drmicha.warpmail.net>:
> Craig Moore venit, vidit, dixit 22.12.2009 17:14:
>> 2009/12/22 Michael J Gruber <git@drmicha.warpmail.net>:
>>> Craig Moore venit, vidit, dixit 22.12.2009 16:50:
>>>> Hi,
>>>>
>>>> I'm getting the following error when I make the info target:
>>>>
>>>> $ make prefix=3D/usr info
>>>> make -C Documentation info
>>>> make[1]: Entering directory `/local/software/git-1.6.5.7/Documenta=
tion'
>>>> make[2]: Entering directory `/local/software/git-1.6.5.7'
>>>> make[2]: `GIT-VERSION-FILE' is up to date.
>>>> make[2]: Leaving directory `/local/software/git-1.6.5.7'
>>>> =A0 =A0 DB2TEXI user-manual.texi
>>>> Usage: jw [<options>] <sgml_file>
>>>> where <options> are:
>>>> =A0 -f|--frontend <frontend>: =A0 =A0 =A0Specify the frontend (sou=
rce format)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
(default is docbook)
>>>> =A0 -b|--backend <backend>: =A0 =A0 =A0 =A0Specify the backend (de=
stination format)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
(default is html)
>>>> =A0 -c|--cat <file>: =A0 =A0 =A0 =A0 =A0 =A0 =A0 Specify an extra =
SGML open catalog
>>>> =A0 -n|--nostd: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Do not use =
the standard SGML open catalogs
>>>> =A0 -d|--dsl <file>|default|none: =A0Specify an alternate style sh=
eet
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
(default is to use the default stylesheet)
>>>> =A0 -l|--dcl <file>: =A0 =A0 =A0 =A0 =A0 =A0 =A0 Specify an altern=
ate SGML declaration
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
(usual ones like xml.dcl get detected
>>>> automatically)
>>>> =A0 -s|--sgmlbase <path>: =A0 =A0 =A0 =A0 =A0Change base directory=
 for SGML distribution
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
(usually /usr/share/sgml)
>>>> =A0 -p|--parser <program>: =A0 =A0 =A0 =A0 Specify the parser if s=
everal are installed
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 (jade or openjade)
>>>> =A0 -o|--output <directory>: =A0 =A0 =A0 Set output directory
>>>> =A0 -u|--nochunks: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Output only one=
 big file
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
(overrides the stylesheet settings)
>>>> =A0 -i|--include <section>: =A0 =A0 =A0 =A0Specify a SGML marked s=
ection to include
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
(should be marked as "ignore" in the SGML text)
>>>> =A0 -w|--warning <warning_type>|list: Control warnings or display =
the allowed
>>>> warning types
>>>> =A0 -e|--errors <error_type>|list: Control errors or display the a=
llowed error types
>>>> =A0 -h|--help: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Print this =
help message and exit
>>>> =A0 -V <variable[=3Dvalue]>: =A0 =A0 =A0 =A0 Set a variable
>>>> =A0 -v|--version: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Print the ver=
sion and exit
>>>> make[1]: *** [user-manual.texi] Error 1
>>>> make[1]: Leaving directory `/local/software/git-1.6.5.7/Documentat=
ion'
>>>> make: *** [info] Error 2
>>>>
>>>> I can see that the error is likely related to the fact that it ent=
ers the
>>>> Documentation directing, then exits the Documentation directory, a=
nd then tries
>>>> to build the user-manual.texi file in the root directory (however,=
 that file is
>>>> in the Documentation directory, which it just left). I've tried to=
 track down
>>>> and change where it exits the Documentation directory, but I've ha=
d no success.
>>>>
>>>> I would appreciate any recommendations you might have. I've alread=
y been able to
>>>> install git, but I couldn't install the 'info' target because of t=
his error.
>>>
>>> Does it work without prefix?
>>> Also, you may want to cd into Documentation and try to make there.
>>>
>>> Michael
>>>
>>>
>>
>> Hey Michael,
>>
>> Here is what happens when I run it inside the Documentation director=
y
>> (without the prefix):
>>
>> user@server: /local/software/git-1.6.5.7/Documentation
>> $ make info
>> =A0 =A0 SUBDIR ../
>> make[1]: `GIT-VERSION-FILE' is up to date.
>> =A0 =A0 DB2TEXI user-manual.texi
>> Usage: jw [<options>] <sgml_file>
>> where <options> are:
>> =A0 -f|--frontend <frontend>: =A0 =A0 =A0Specify the frontend (sourc=
e format)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(=
default is docbook)
>> =A0 -b|--backend <backend>: =A0 =A0 =A0 =A0Specify the backend (dest=
ination format)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(=
default is html)
>> =A0 -c|--cat <file>: =A0 =A0 =A0 =A0 =A0 =A0 =A0 Specify an extra SG=
ML open catalog
>> =A0 -n|--nostd: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Do not use th=
e standard SGML open catalogs
>> =A0 -d|--dsl <file>|default|none: =A0Specify an alternate style shee=
t
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(=
default is to use the default stylesheet)
>> =A0 -l|--dcl <file>: =A0 =A0 =A0 =A0 =A0 =A0 =A0 Specify an alternat=
e SGML declaration
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(=
usual ones like xml.dcl get detected
>> automatically)
>> =A0 -s|--sgmlbase <path>: =A0 =A0 =A0 =A0 =A0Change base directory f=
or SGML distribution
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(=
usually /usr/share/sgml)
>> =A0 -p|--parser <program>: =A0 =A0 =A0 =A0 Specify the parser if sev=
eral are installed
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
(jade or openjade)
>> =A0 -o|--output <directory>: =A0 =A0 =A0 Set output directory
>> =A0 -u|--nochunks: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Output only one b=
ig file
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(=
overrides the stylesheet settings)
>> =A0 -i|--include <section>: =A0 =A0 =A0 =A0Specify a SGML marked sec=
tion to include
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(=
should be marked as "ignore" in the SGML text)
>> =A0 -w|--warning <warning_type>|list: Control warnings or display th=
e
>> allowed warning types
>> =A0 -e|--errors <error_type>|list: Control errors or display the all=
owed
>> error types
>> =A0 -h|--help: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Print this he=
lp message and exit
>> =A0 -V <variable[=3Dvalue]>: =A0 =A0 =A0 =A0 Set a variable
>> =A0 -v|--version: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Print the versi=
on and exit
>> make: *** [user-manual.texi] Error 1
>>
>> The first thing it does is go to the directory above, weird.
>>
>> Craig
>
> I think it only looks like that. SUBDIR processing is finished at tha=
t
> point, and the DB2TEXI line is where user-manual.texi is actually bei=
ng
> processed, and that's what's causing the error. Did you set the texin=
fo
> processor in the Makefile or using variables?
>
> V=3D1 make info
>
> will show you the exact commands being executed.
>
> Michael
>

Michael, thanks for your reply, and happy 2010. I'm back in the
office, and here's what is returned when I execute the command:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
$ V=3D1 make info
make -C Documentation info
make[1]: Entering directory `/local/software/git-1.6.5.7/Documentation'
make -C ../  GIT-VERSION-FILE
make[2]: Entering directory `/local/software/git-1.6.5.7'
make[2]: `GIT-VERSION-FILE' is up to date.
make[2]: Leaving directory `/local/software/git-1.6.5.7'
rm -f user-manual.texi+ user-manual.texi && \
        docbook2x-texi user-manual.xml --encoding=3DUTF-8 --to-stdout
>user-manual.texi++ && \
        /usr/bin/perl fix-texi.perl <user-manual.texi++ >user-manual.te=
xi+ && \
        rm user-manual.texi++ && \
        mv user-manual.texi+ user-manual.texi
Usage: jw [<options>] <sgml_file>
where <options> are:
  -f|--frontend <frontend>:      Specify the frontend (source format)
                                 (default is docbook)
  -b|--backend <backend>:        Specify the backend (destination forma=
t)
                                 (default is html)
  -c|--cat <file>:               Specify an extra SGML open catalog
  -n|--nostd:                    Do not use the standard SGML open cata=
logs
  -d|--dsl <file>|default|none:  Specify an alternate style sheet
                                 (default is to use the default stylesh=
eet)
  -l|--dcl <file>:               Specify an alternate SGML declaration
                                 (usual ones like xml.dcl get detected
automatically)
  -s|--sgmlbase <path>:          Change base directory for SGML distrib=
ution
                                 (usually /usr/share/sgml)
  -p|--parser <program>:         Specify the parser if several are inst=
alled
                                  (jade or openjade)
  -o|--output <directory>:       Set output directory
  -u|--nochunks:                 Output only one big file
                                 (overrides the stylesheet settings)
  -i|--include <section>:        Specify a SGML marked section to inclu=
de
                                 (should be marked as "ignore" in the S=
GML text)
  -w|--warning <warning_type>|list: Control warnings or display the
allowed warning types
  -e|--errors <error_type>|list: Control errors or display the allowed
error types
  -h|--help:                     Print this help message and exit
  -V <variable[=3Dvalue]>:         Set a variable
  -v|--version:                  Print the version and exit
make[1]: *** [user-manual.texi] Error 1
make[1]: Leaving directory `/local/software/git-1.6.5.7/Documentation'
make: *** [info] Error 2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

I've isolated the problem, and its coming from this command:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
$ docbook2x-texi user-manual.xml --encoding=3DUTF-8 --to-stdout
>user-manual.texi++
Usage: jw [<options>] <sgml_file>
where <options> are:
  -f|--frontend <frontend>:      Specify the frontend (source format)
                                 (default is docbook)
  -b|--backend <backend>:        Specify the backend (destination forma=
t)
                                 (default is html)
  -c|--cat <file>:               Specify an extra SGML open catalog
  -n|--nostd:                    Do not use the standard SGML open cata=
logs
  -d|--dsl <file>|default|none:  Specify an alternate style sheet
                                 (default is to use the default stylesh=
eet)
  -l|--dcl <file>:               Specify an alternate SGML declaration
                                 (usual ones like xml.dcl get detected
automatically)
  -s|--sgmlbase <path>:          Change base directory for SGML distrib=
ution
                                 (usually /usr/share/sgml)
  -p|--parser <program>:         Specify the parser if several are inst=
alled
                                  (jade or openjade)
  -o|--output <directory>:       Set output directory
  -u|--nochunks:                 Output only one big file
                                 (overrides the stylesheet settings)
  -i|--include <section>:        Specify a SGML marked section to inclu=
de
                                 (should be marked as "ignore" in the S=
GML text)
  -w|--warning <warning_type>|list: Control warnings or display the
allowed warning types
  -e|--errors <error_type>|list: Control errors or display the allowed
error types
  -h|--help:                     Print this help message and exit
  -V <variable[=3Dvalue]>:         Set a variable
  -v|--version:                  Print the version and exit

$ docbook2x-texi --version
DocBook-utils version 0.6.14 (jw version 1.1)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

As you can see, I'm using DocBook-utils version 0.6.14 (jw version
1.1), and it doesn't list '--encoding=3DUTF-8 --to-stdout' in its
options list. I'm guessing I've got the wrong version or type
installed? Is there another which I should be using?

Thanks for your help,
Craig
