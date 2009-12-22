From: Craig Moore <craigtmoore@googlemail.com>
Subject: Re: Trouble with 'make prefix=/usr info'
Date: Tue, 22 Dec 2009 17:14:41 +0100
Message-ID: <d4133e470912220814h465175bfr8fd10942898096a1@mail.gmail.com>
References: <loom.20091222T164442-704@post.gmane.org>
	 <4B30ECA1.2040508@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 22 17:14:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NN7Nq-0003IQ-MO
	for gcvg-git-2@lo.gmane.org; Tue, 22 Dec 2009 17:14:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753717AbZLVQOp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Dec 2009 11:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753666AbZLVQOo
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 11:14:44 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:59849 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbZLVQOo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Dec 2009 11:14:44 -0500
Received: by bwz27 with SMTP id 27so4219529bwz.21
        for <git@vger.kernel.org>; Tue, 22 Dec 2009 08:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=nAJrLJ1js3SrTZXosYjkmxbKnat4KJhOmagmf4qSRQ4=;
        b=IUryWujv0xKmJn+teegNGRt/vCc2p3nlsMIfmBBOCFA4DnQ5KAqAswBKq2FTSxC/UE
         j6OZxAE6T9fGXT6qU3oh0bJBgKyWPG5O/+ZvwWzN7Aps7bvt+mI6u27UYISqHw4734L/
         uzXE4SBiiRGTZDCbzFekeP96EWYkjxrmpasPs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=tfP43X9zUYu5vHWE7kMLevGhol5mfJvQUtfjbOll4cgZ/u74U1ow+EdchkThdf+Lw/
         p56//oQhp/zhO5fdY+eNCXI7mSmGF1/rtd3+N5suBL7MWu5nQChcfxEZfUg/ij6eS0RY
         sokNwTI647PSK0ZF61OMVhSqE7vDG5s16IIhk=
Received: by 10.204.26.135 with SMTP id e7mr2857313bkc.183.1261498481623; Tue, 
	22 Dec 2009 08:14:41 -0800 (PST)
In-Reply-To: <4B30ECA1.2040508@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135583>

2009/12/22 Michael J Gruber <git@drmicha.warpmail.net>:
> Craig Moore venit, vidit, dixit 22.12.2009 16:50:
>> Hi,
>>
>> I'm getting the following error when I make the info target:
>>
>> $ make prefix=3D/usr info
>> make -C Documentation info
>> make[1]: Entering directory `/local/software/git-1.6.5.7/Documentati=
on'
>> make[2]: Entering directory `/local/software/git-1.6.5.7'
>> make[2]: `GIT-VERSION-FILE' is up to date.
>> make[2]: Leaving directory `/local/software/git-1.6.5.7'
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
e allowed
>> warning types
>> =A0 -e|--errors <error_type>|list: Control errors or display the all=
owed error types
>> =A0 -h|--help: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Print this he=
lp message and exit
>> =A0 -V <variable[=3Dvalue]>: =A0 =A0 =A0 =A0 Set a variable
>> =A0 -v|--version: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Print the versi=
on and exit
>> make[1]: *** [user-manual.texi] Error 1
>> make[1]: Leaving directory `/local/software/git-1.6.5.7/Documentatio=
n'
>> make: *** [info] Error 2
>>
>> I can see that the error is likely related to the fact that it enter=
s the
>> Documentation directing, then exits the Documentation directory, and=
 then tries
>> to build the user-manual.texi file in the root directory (however, t=
hat file is
>> in the Documentation directory, which it just left). I've tried to t=
rack down
>> and change where it exits the Documentation directory, but I've had =
no success.
>>
>> I would appreciate any recommendations you might have. I've already =
been able to
>> install git, but I couldn't install the 'info' target because of thi=
s error.
>
> Does it work without prefix?
> Also, you may want to cd into Documentation and try to make there.
>
> Michael
>
>

Hey Michael,

Here is what happens when I run it inside the Documentation directory
(without the prefix):

user@server: /local/software/git-1.6.5.7/Documentation
$ make info
    SUBDIR ../
make[1]: `GIT-VERSION-FILE' is up to date.
    DB2TEXI user-manual.texi
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
make: *** [user-manual.texi] Error 1

The first thing it does is go to the directory above, weird.

Craig
