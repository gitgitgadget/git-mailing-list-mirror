From: jk@blackdown.de (=?utf-8?Q?J=C3=BCrgen?= Kreileder)
Subject: Re: [PATCH 3/4] gitweb: Don't append ';js=(0|1)' to external links
Date: Tue, 09 Apr 2013 19:54:16 +0200
Message-ID: <m2mwt7a8tz.fsf@zahir.fritz.box>
References: <m2wqscbx83.fsf@blackdown.de> <516430D5.6030201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 19:54:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPcki-0004FF-Bd
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 19:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934564Ab3DIRyg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Apr 2013 13:54:36 -0400
Received: from mail-bk0-f48.google.com ([209.85.214.48]:51100 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932110Ab3DIRyf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Apr 2013 13:54:35 -0400
Received: by mail-bk0-f48.google.com with SMTP id jf3so3666158bkc.7
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 10:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackdown.de; s=google;
        h=x-received:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=Oo5EEJndaEboiI7qHOqF0sEQJfLnWLRPYoQN522DxSo=;
        b=dVk9kj54vU3iL2R/WvTiaHEukhZBGURNERmk7su+sR3J+LhzCLUypW32k02DEuBTX3
         7D3V63+58Qozxtzmn3YDdEkOvzCuz7GQiZC1Xm3t7QOH/FbqeQ9fop6f6vfP+hI2S4yi
         tKszMqri0H9Oo1GQF7e+dUBdw33Z0yjvqvPTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=Oo5EEJndaEboiI7qHOqF0sEQJfLnWLRPYoQN522DxSo=;
        b=XxwgGlVzQx0NbiFx650uaETFmzRYMNamKdiqeKsDzV3DDr2oQ9688RTfDE4aC11cqx
         FwmMnaKotIPZJ3Qxn57SLeJrkaW0FMe5x5jp6tikiOuOKsYGafkY1lCpX2wFi+t/gM8m
         YHgQlC2YNrUazrq6EESbWoFTHAMebxBeZZfKsUkwO2y4MOAgt9748hPoEMZgLSzGtVuT
         eMiqqlaav6854obpQ6tRbBwVEB9IMmmhBq6V8gtNmc8BP01nMoeVHEYw37ZSxPBs1nMB
         4q7GEH8MgeGw5PXQhVqWygPIxEFXPewNn6xKJuRM0XsdJOYaZVKkmiqi3vw4n58EFG9l
         kgqA==
X-Received: by 10.204.229.72 with SMTP id jh8mr13421973bkb.88.1365530073886;
        Tue, 09 Apr 2013 10:54:33 -0700 (PDT)
Received: from zahir.fritz.box (p20030056CF2E81009227E4FFFEF3FF5E.dip.t-dialin.net. [2003:56:cf2e:8100:9227:e4ff:fef3:ff5e])
        by mx.google.com with ESMTPS id io13sm14413273bkc.15.2013.04.09.10.54.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Apr 2013 10:54:32 -0700 (PDT)
In-Reply-To: <516430D5.6030201@gmail.com> ("Jakub \=\?utf-8\?Q\?Nar\=C4\=99bski\?\=
 \=\?utf-8\?Q\?\=22's\?\= message of "Tue,
	09 Apr 2013 17:16:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3.50 (darwin)
X-Gm-Message-State: ALoCoQmJggqbdisvRLrOMOijyZIM8ozfEJxCmB27qLCbuVohX5pQLqrcsqci4xw00uvnfXH3mcui
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220600>

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> J=C3=BCrgen Kreileder wrote:
>
>> Don't add js parameters to links outside of gitweb itself.
>
> Hmmm... this limits adding ';js=3D(0|1)' to only links which begin wi=
th
> $my_url, i.e. absolute links beginning with gitweb's base URL.
>
> Wouldn't that mean that most internal gitweb-generated links wouldn't
> get ';js=3D(0|1)'?  href(..., -full =3D> 1) is not the default...

No, link.href is always absolute in JavaScript - even if the emitted UR=
L
was relative.

Old: https://git.blackdown.de/old.cgi?p=3Dcontactalbum.git;a=3Dsummary;=
js=3D1
New: https://git.blackdown.de/?p=3Dcontactalbum.git;a=3Dsummary;js=3D1

With the old version the external links in the description got ';js=3D1=
'
appended.  With the new version, ';js=3D1' isn't on those links.
Other links are the same in both versions.

>> Signed-off-by: J=C3=BCrgen Kreileder <jk@blackdown.de>
>> ---
>>  gitweb/gitweb.perl                       |    2 +-
>>  gitweb/static/js/javascript-detection.js |    4 ++--
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 1309196..f0912d7 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -4165,7 +4165,7 @@ sub git_footer_html {
>>  		print qq!<script type=3D"text/javascript">\n!.
>>  		      qq!window.onload =3D function () {\n!;
>>  		if (gitweb_check_feature('javascript-actions')) {
>> -			print qq!	fixLinks();\n!;
>> +			print qq!	fixLinks('$my_url');\n!;
>>  		}
>>  		if ($jstimezone && $tz_cookie && $datetime_class) {
>>  			print qq!	var tz_cookie =3D { name: '$tz_cookie', expires: 14, p=
ath: '/' };\n!. # in days
>> diff --git a/gitweb/static/js/javascript-detection.js b/gitweb/stati=
c/js/javascript-detection.js
>> index fa2596f..36964ad 100644
>> --- a/gitweb/static/js/javascript-detection.js
>> +++ b/gitweb/static/js/javascript-detection.js
>> @@ -29,11 +29,11 @@ var jsExceptionsRe =3D /[;?]js=3D[01](#.*)?$/;
>>   *
>>   * @globals jsExceptionsRe
>>   */
>> -function fixLinks() {
>> +function fixLinks(baseurl) {
>>  	var allLinks =3D document.getElementsByTagName("a") || document.li=
nks;
>>  	for (var i =3D 0, len =3D allLinks.length; i < len; i++) {
>>  		var link =3D allLinks[i];
>> -		if (!jsExceptionsRe.test(link)) {
>> +		if (!jsExceptionsRe.test(link) && !link.href.indexOf(baseurl)) {
>>  			link.href =3D link.href.replace(/(#|$)/,
>>  				(link.href.indexOf('?') =3D=3D=3D -1 ? '?' : ';') + 'js=3D1$1')=
;
>>  		}
>>=20
