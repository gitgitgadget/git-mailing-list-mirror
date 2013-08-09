From: "gnehzuil.liu" <gnehzuil.liu@gmail.com>
Subject: Re: [GUILT] add FreeBSD support
Date: Fri, 9 Aug 2013 23:04:45 +0800
Message-ID: <68E9B1AC-A3A3-47DD-B0A7-07752428D16D@gmail.com>
References: <1376051548-3126-1-git-send-email-wenqing.lz@taobao.com> <20130809144641.GK22686@poseidon.cudanet.local>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri Aug 09 17:04:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7oFL-0007Aw-K9
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 17:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934327Ab3HIPEw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Aug 2013 11:04:52 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:42309 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934064Ab3HIPEu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Aug 2013 11:04:50 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so655793pdi.5
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 08:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=references:mime-version:in-reply-to:content-type
         :content-transfer-encoding:message-id:cc:from:subject:date:to;
        bh=w2cl3G7QJuPSnT/GHIYX2NbFGEVk1G0EPeLEUM+W7lY=;
        b=L8Df3CR9PJizKas4XCsE91NSIXvLqYm004VL8z2OEK7EM1+ibRcq4L3zE3dmh3QRWB
         up0gD7Q3hOtF6iwnnaB7N9bdRWkWN5qCaCXdOC1rbWqdpya0OWmjqzt8VgQ7Drh+M/7m
         7DhM+xlJob+AWeokngxqlJp2phIeBcsDLv4mnKVtQar+Ht08oMqnocOBZSkThkbqJLb/
         aIgebk6skHEEPCQXq0Rw4OjjEflZsyDCO5p50Nw7qqBw9YUdq91hpZFi+Mt/NXO2kFfG
         MNuKhz+pGU8YvF/X2fnWs4mj06zynvP/apvEF57sJPSCC3jLyn1NoRQLHXQvMcfFuN2+
         mSfg==
X-Received: by 10.68.34.165 with SMTP id a5mr11796711pbj.156.1376060690413;
        Fri, 09 Aug 2013 08:04:50 -0700 (PDT)
Received: from [192.168.0.101] ([221.218.117.225])
        by mx.google.com with ESMTPSA id ar5sm20575516pbc.40.2013.08.09.08.04.48
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 09 Aug 2013 08:04:49 -0700 (PDT)
In-Reply-To: <20130809144641.GK22686@poseidon.cudanet.local>
X-Mailer: iPad Mail (10B329)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231987>

=D4=DA 2013-8-9=A3=AC=CF=C2=CE=E710:46=A3=ACJosef 'Jeff' Sipek <jeffpc@=
josefsipek.net> =D0=B4=B5=C0=A3=BA

> On Fri, Aug 09, 2013 at 08:32:28PM +0800, Zheng Liu wrote:
>> From: Zheng Liu <gnehzuil.liu@gmail.com>
>>=20
>> Currently guilt doesn't support FreeBSD platform.  This commit tries=
 to
>> add this support.  The file called 'os.FreeBSD' is copied from os.Da=
rwin
>> due to these two platforms have almost the same command tools.
>=20
> Out of curiosity, is it identical?  I eyeballed it, and they do look
> identical.  There's probably a better way to do this whole os-specifi=
c
> thing, but this will work well enough for now.

Yes, it is identical.  Sorry, I am a newbie for guilt, but I am happy t=
o improve this os-specific thing.    Any idea?

Regards,
                                                  - Zheng

>=20
> Jeff.
>=20
>> Signed-off-by: Zheng Liu <gnehzuil.liu@gmail.com>
>> ---
>> Hi all,
>>=20
>> After applied this patch, the regression test 010 and 060 will fail =
because
>> of the output format.  After fixing these issues, all the regression=
 tests
>> will pass.
>>=20
>> P.S. I don't subscribe git@ mailing list.  So please put my email ad=
dress
>> in Cc list.  Thanks!
>>=20
>> Regards,
>>                        - Zheng
>>=20
>> os.FreeBSD | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++
>> 1 file changed, 70 insertions(+)
>> create mode 100644 os.FreeBSD
>>=20
>> diff --git a/os.FreeBSD b/os.FreeBSD
>> new file mode 100644
>> index 0000000..3f23121
>> --- /dev/null
>> +++ b/os.FreeBSD
>> @@ -0,0 +1,70 @@
>> +# usage: touch_date <unix ts> <file>
>> +touch_date()
>> +{
>> +    touch -t `date -r $1 +%Y%m%d%H%M.%S` "$2"
>> +}
>> +
>> +# usage: last_modified <file>
>> +last_modified()
>> +{
>> +    stat -f "%m" "$1"
>> +}
>> +
>> +# usage: format_last_modified <file>
>> +format_last_modified()
>> +{
>> +    stat -f "%Sm" -t "%Y-%m-%d %H:%M:%S %z" "$1"
>> +}
>> +
>> +# usage: head_n [count]
>> +head_n()
>> +{
>> +    if [ "$1" -gt 0 ]; then
>> +        head -n "$1"
>> +    fi
>> +}
>> +
>> +# usage: sha1 [file]
>> +sha1()
>> +{
>> +    if [ $# =3D 1 ]
>> +    then
>> +        openssl dgst -sha1 "$1" | sed "s,SHA1.\(.*\).=3D \(.*\),\2 =
 \1,"
>> +    else
>> +        openssl dgst -sha1 | sed 's,\(.*=3D \)*\(.*\),\2  -,'
>> +    fi
>> +}
>> +
>> +# usage: cp_a <src> <dst>
>> +cp_a()
>> +{
>> +    cp -pR "$1" "$2"
>> +}
>> +
>> +# usage: _tac
>> +_tac()
>> +{
>> +    sed -e '1!G;h;$!d'
>> +}
>> +
>> +_seq()
>> +{
>> +    (
>> +        if [ $# -eq 1 ]
>> +        then
>> +            /usr/bin/jot $1
>> +        elif [ $# -eq 2 ]
>> +        then
>> +            n1=3D$((${2} - ${1} + 1))
>> +            n2=3D$1
>> +            /usr/bin/jot $n1 $n2
>> +        elif [ $# -eq 3 ]
>> +        then
>> +            num1=3D$1
>> +            incr=3D$2
>> +            num2=3D$3
>> +            /usr/bin/awk -v n1=3D$num1 -v n2=3D$num2 -v add=3D$incr=
 'BEGIN{ for(i=3Dn1; i<=3Dn2; i+=3Dadd) print i;}' | /usr/bin/sed -E '/=
e/s/^.+e.+$/0/'
>> +        fi
>> +    )
>> +    return 0
>> +}
>> --=20
>> 1.8.3.4
>=20
> --=20
> Research, n.:
>  Consider Columbus:
>    He didn't know where he was going.
>    When he got there he didn't know where he was.
>    When he got back he didn't know where he had been.
>    And he did it all on someone else's money.
