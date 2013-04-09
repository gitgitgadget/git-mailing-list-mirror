From: jk@blackdown.de (=?utf-8?Q?J=C3=BCrgen?= Kreileder)
Subject: Re: [PATCH 2/4] gitweb: Make feed title valid utf8
Date: Tue, 09 Apr 2013 19:40:46 +0200
Message-ID: <m2r4ija9gh.fsf@zahir.fritz.box>
References: <m2y5csbx91.fsf@blackdown.de> <51642F67.5010501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 19:41:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPcXz-0001Xd-SY
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 19:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760602Ab3DIRl1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Apr 2013 13:41:27 -0400
Received: from mail-bk0-f44.google.com ([209.85.214.44]:60711 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315Ab3DIRl0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Apr 2013 13:41:26 -0400
Received: by mail-bk0-f44.google.com with SMTP id jk13so3694800bkc.3
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 10:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackdown.de; s=google;
        h=x-received:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=EbcHW2joLioC45V7tCEHLI4It5TY68hDqOGPlXRkUAE=;
        b=KP/2kM3FKbl9Eesv9ikda0IOfPvbFp8s7jO04urty7TS7EGvihvmZnEaZfl0X4LWkI
         OshiAX6pKRdm+8OAFuSzbV3xHAVlt7Dni40cEgq2He/qOjXLAd8UIteRuvmzVxLTQhR9
         gZtfOmPqZPdVSFGOgCzN+4pSTnCQrEbkMBfR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=EbcHW2joLioC45V7tCEHLI4It5TY68hDqOGPlXRkUAE=;
        b=MXPFVDYG8m2LRcGH9nQ4ADzren+UelNxCVwsMnb8TkysTodHPMunoNmciJmvyD3WHa
         e+0zQj4aUiGGVmhTmk/hy5+MWIyxqOCV2YkUWGPHzbxQyEJ5SdydQeQzCSkehH/jzTNj
         +xgvqZZaKCmKkDtCRHns1c+E3c5Ex9/0iMqHQH8vPpveDub9YwHGp5Rt8jwxzTLaMjcR
         OLKP1DovHSSYUDysoA7GpzOdPD9wX0oABIbPNXiVtXwXIu3eEeWDye59E703uPVguHmF
         OrzkuPUw8p1XA5dIU6CjvHtgDISPUBLkRaucv4qF7yaAwBrFkgJQI9H8r23Jk+cjN/+n
         1m2Q==
X-Received: by 10.205.38.3 with SMTP id tg3mr13059197bkb.66.1365529284977;
        Tue, 09 Apr 2013 10:41:24 -0700 (PDT)
Received: from zahir.fritz.box (p20030056CF2E81009227E4FFFEF3FF5E.dip.t-dialin.net. [2003:56:cf2e:8100:9227:e4ff:fef3:ff5e])
        by mx.google.com with ESMTPS id w6sm14395023bkz.17.2013.04.09.10.41.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Apr 2013 10:41:23 -0700 (PDT)
In-Reply-To: <51642F67.5010501@gmail.com> ("Jakub \=\?utf-8\?Q\?Nar\=C4\=99bski\?\=
 \=\?utf-8\?Q\?\=22's\?\= message of "Tue,
	09 Apr 2013 17:10:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3.50 (darwin)
X-Gm-Message-State: ALoCoQnNe23k3IhuIcUxtat79Cvm4d8ArR5ewrMyPBjoq9Mpk1g8HtZsxzgyyqy6Y/M9G444kMgt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220596>

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> J=C3=BCrgen Kreileder wrote:
>
>> Properly encode site and project names for RSS and Atom feeds.
>>=20
>> Signed-off-by: J=C3=BCrgen Kreileder <jk@blackdown.de>
>> ---
>>  gitweb/gitweb.perl |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 9cfe5b5..09294eb 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -8056,7 +8056,7 @@ sub git_feed {
>>  	return if ($cgi->request_method() eq 'HEAD');
>> =20
>>  	# header variables
>> -	my $title =3D "$site_name - $project/$action";
>> +	my $title =3D to_utf8($site_name) . " - " . to_utf8($project) . "/=
$action";
>>  	my $feed_type =3D 'log';
>>  	if (defined $hash) {
>>  		$title .=3D " - '$hash'";
>>=20
>
> Was this patch triggered by some bug?

Yes, I actually see broken encoding with the old code, e.g on=20
https://git.blackdown.de/old.cgi?p=3Dcontactalbum.git;a=3Drss
my first name is messed up in the title tag.

New version: https://git.blackdown.de/?p=3Dcontactalbum.git;a=3Drss

> Because the above is not necessary, as git_feed() has
>
> 	$title =3D esc_html($title);
>
> a bit later, which does to_utf8() internally.

Good point.  But it doesn't fix the string in question:
It looks like to_utf8("$a $b") !=3D (to_utf8($a) . " " . to_utf($b)).


Juergen
