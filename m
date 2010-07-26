From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Potential bug in gitweb 1.7.2
Date: Mon, 26 Jul 2010 13:39:00 +0000
Message-ID: <AANLkTinAO8R6mg967XeqFgMHInT4pMlxODz29Jovfki1@mail.gmail.com>
References: <4C4D152A.7050505@gmail.com>
	<alpine.DEB.2.00.1007260508290.14251@dr-wily.mit.edu>
	<4C4D8940.80802@gmail.com>
	<201007261536.11688.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: julio.lajara@alum.rpi.edu, Anders Kaseorg <andersk@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 15:39:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdNtc-00018M-GC
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 15:39:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260Ab0GZNjD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jul 2010 09:39:03 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44078 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247Ab0GZNjB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jul 2010 09:39:01 -0400
Received: by iwn7 with SMTP id 7so2849506iwn.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 06:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZqCtOlSfwFk8Z3pv+Zg8jpvA8C3CMc+Zgk4aF8kzQXU=;
        b=lOcmr7ay3Rwh3is1ORG5cTWtv3MBGYqjx6bI7p7wHDwnWlzZXRDAmGNiCDtv6IoKS3
         ax3B9LeFT2rOtEL1EJiWP5HBh1K41RTX3LIR+m1eYVgfhen/63lMohO+VwneClSD1xXp
         1kNmqnV2xOH+pmZpvgTKioLcCk/W3EbuZZT0w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FSwo1rbsUf3UzQ00aj912SwVy3WLsKG6MrAhDRDagX/2NAVzghpWQ/It9CnFt1dt3p
         JsUm7Tkpw873+mYKDrSUXjxtlmOcGiMe0Tpryast8uJHJgmD/klMZmt6BtllUKShW4ra
         8QqNfEDbeithND5yz4v57BcPQAVC6H5FRxO34=
Received: by 10.231.14.200 with SMTP id h8mr7794869iba.188.1280151540651; Mon, 
	26 Jul 2010 06:39:00 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Mon, 26 Jul 2010 06:39:00 -0700 (PDT)
In-Reply-To: <201007261536.11688.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151837>

On Mon, Jul 26, 2010 at 13:36, Jakub Narebski <jnareb@gmail.com> wrote:
> On Mon, 26 Jul 2010, Julio Lajara wrote:
>
>> Hi Anders, thanks for the input. I will begin chasing down the issue=
 in
>> my config then, but its strange that it would stop working as the ex=
act
>> same configuration works without issue in 1.7.0.4 . Ill follow up wi=
th
>> what I find.
>>
>> On 07/26/2010 05:27 AM, Anders Kaseorg wrote:
>
>>> The error that Julio originally posted:
>>>
>>>
>>>>> [Sat Jul 24 23:11:41 2010] [error] [client 192.168.1.100] Can't c=
all
>>>>> method "http" on an undefined value at /usr/share/gitweb/index.cg=
i
>>>>> line 3401., referer: http://192.168.1.142/gitweb/
>>>
>>> looks very strange, and does not seem like it would result from jus=
t a
>>> packaging problem.
>
> Julio, could you show us the neigbourhood of line 3401 in your index.=
cgi
> file? =C2=A0What is this index.cgi file - git doesn't have it?

His index.cgi is just gitweb.cgi under a different name. Line 3401 is
the same as gitweb/gitweb.cgi in the 1.7.2 release.
