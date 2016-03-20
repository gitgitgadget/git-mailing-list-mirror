From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [ANNOUNCE] Git v2.7.4 (and updates to older maintenance tracks)
Date: Sun, 20 Mar 2016 13:07:52 -0400
Message-ID: <CAPig+cSOjFqcKGaZC1HWGdp7aCg7Dog1GvFYPYRbShARPm9ODQ@mail.gmail.com>
References: <xmqqlh5gzuc8.fsf@gitster.mtv.corp.google.com>
	<680C4CDE-233E-4603-B3F1-D68EB126620F@FreeBSD.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Renato Botelho <garga@freebsd.org>
X-From: git-owner@vger.kernel.org Sun Mar 20 18:07:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahgpZ-0005YI-O9
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 18:07:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbcCTRHy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Mar 2016 13:07:54 -0400
Received: from mail-vk0-f53.google.com ([209.85.213.53]:34267 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405AbcCTRHx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Mar 2016 13:07:53 -0400
Received: by mail-vk0-f53.google.com with SMTP id e185so192630800vkb.1
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 10:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=o827OiY83VkQ2apUISQPJBe3unpRm9lk/eyWp1nA/mM=;
        b=Oavxar6/UEROnkFhWgvgth7bUMyxZxU8SxU4KOx67cbb0h8rhDBh/jGfCO2zpLxYOp
         cc1cbWp3tzjhgZjwi2qq2mjKOGuv7jke7hp4Jmggf858XVbxASMIZsaCoDHfFNFoD8KA
         ztElehK5Che34yz5hnz5zdW8YX0PTs9pfejET9k1l9raE4edF9lrkCNGJkhdt2xOjX5z
         1JBqZZWuP/0lwQ/Rui435AKlqOeQ0aQ3+pTfV6yzQB/KcfrjQGa+irwaCTkXje3FxEej
         8WWgRSr7+fOF7VXaRohveZPFpw+jrksc12uJ6US6Nk3uLuEyxnHV6mlno5sNYuP/0XxP
         QhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=o827OiY83VkQ2apUISQPJBe3unpRm9lk/eyWp1nA/mM=;
        b=JLTCXSssZFjdZFnJwy1ynLrwlsRXBIOE9UvQuVHci+Vwpv3reozPb+dYaHxFcLs5lN
         Afkft127bNqgD+8qjRoAVkR1SW2Slpm2TT/sg8dN4k5LlbtHx6VF15dbic6Rftzx7Aee
         5wr+YIHPQFuvxsMxul4HE+TnemVabja2VpfwZGp+ArNOrmy0PjjQmC1SlMIriTwkxfCJ
         Z1NfKCByEaGTX6W6LxV9IkzRH5EsyONhYFVlKOeO0mqWC2IufdvJ/8Sgoy1FEdLAnsvv
         r562heER4XCCzji1l987OgmOGIosux7w55370qmJa+w3XA13Hnqf3lrROdhK2bji3j7A
         1Z6Q==
X-Gm-Message-State: AD7BkJKZXam2Kv88x7lQ0J56F2NsQUyHSmOMrp9Vq6fpOBTWO/NsSj9uv+4l/4wzHsaDVYk/dBvsgh68Cen74w==
X-Received: by 10.31.130.74 with SMTP id e71mr13655350vkd.117.1458493672250;
 Sun, 20 Mar 2016 10:07:52 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Sun, 20 Mar 2016 10:07:52 -0700 (PDT)
In-Reply-To: <680C4CDE-233E-4603-B3F1-D68EB126620F@FreeBSD.org>
X-Google-Sender-Auth: pkOK64nBujb2eDYBgvFy6nlz2EU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289369>

[cc:+peff]

On Sun, Mar 20, 2016 at 11:32 AM, Renato Botelho <garga@freebsd.org> wr=
ote:
>> On Mar 17, 2016, at 18:07, Junio C Hamano <gitster@pobox.com> wrote:
>> Git v2.7.4 Release Notes
>>
>> Junio C Hamano (4):
>>      Git 2.4.11
>>      Git 2.5.5
>>      Git 2.6.6
>>      Git 2.7.4
>
> FYI,
>
> 2.7.4 fails to build on FreeBSD 9.x, that uses by default gcc 4.2.1. =
I=E2=80=99ve fixed it adding an extra dependency to make force it to re=
quire gcc 4.8+. Here is the output:
>
> cc -o combine-diff.o -c -MF ./.depend/combine-diff.o.d -MQ combine-di=
ff.o -MMD -MP -isystem/usr/local/include -O2 -pipe -fstack-protector -f=
no-strict-aliasing -I. -I/usr/local/include -I/usr/local/include -DUSE_=
CURL_FOR_IMAP_SEND -I/usr/include -DUSE_ST_TIMESPEC -pthread -DHAVE_PAT=
HS_H -DHAVE_STRINGS_H -DGMTIME_UNRELIABLE_ERRORS -DHAVE_CLOCK_GETTIME -=
DHAVE_CLOCK_MONOTONIC -DHAVE_BSD_SYSCTL -DHAVE_GETDELIM -DSHA1_HEADER=3D=
'<openssl/sha.h>'  -DDIR_HAS_BSD_GROUP_SEMANTICS -DSHELL_PATH=3D'"/bin/=
sh"'  combine-diff.c
> combine-diff.c: In function 'diff_tree_combined':
> combine-diff.c:1391: internal compiler error: Segmentation fault: 11
> Please submit a full bug report,
> with preprocessed source if appropriate.
> See <URL:http://gcc.gnu.org/bugs.html> for instructions.
> Makefile:1924: recipe for target 'combine-diff.o' failed
> gmake: *** [combine-diff.o] Error 1
> *** [do-build] Error code 1

Interesting. This appears to be the same bug as [1].

[1]: http://thread.gmane.org/gmane.comp.version-control.git/287486/focu=
s=3D287789
