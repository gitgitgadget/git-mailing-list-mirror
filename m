From: Osamu OKANO <okano.osamu@gmail.com>
Subject: Re: [PATCH 6/7] update git-stage.po
Date: Sat, 14 May 2011 22:36:13 +0900
Message-ID: <BANLkTi=u4_vbTjDyL1JNAz06=R_1XUikvA@mail.gmail.com>
References: <1305292458-3920-1-git-send-email-okano.osamu@gmail.com>
	<1305292458-3920-7-git-send-email-okano.osamu@gmail.com>
	<7vtycy7d9z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 14 15:36:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLF12-0001Fk-IF
	for gcvg-git-2@lo.gmane.org; Sat, 14 May 2011 15:36:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757463Ab1ENNgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2011 09:36:14 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58040 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756272Ab1ENNgN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2011 09:36:13 -0400
Received: by iwn34 with SMTP id 34so2889802iwn.19
        for <git@vger.kernel.org>; Sat, 14 May 2011 06:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cuiHtKtGJKyhbR5fUtl8FhL2zV8qsDMjkjO5jB6Db1Q=;
        b=B1cUwOujMR+x73Zf/aO5/aOvbh/sSDTFe4J7A+E414ViREE4PYU8YdVfppcuaAKwG9
         dUGTU05H9ILxCqzGIU1h6CZ3qHloAsfEQ9giClH7gBQhgoTs4r/giAPXPk4D7ddN/CJ1
         qCkfMosXEVUTEOcjGgfus/95g6qUVyEJygHzY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VnHddyoCoPk0FN/urXawEdcVGggr6CCXEe5FJi5oeYzDYJAM1/MlL6zxWu3Qaqy1Yf
         v3fTIIBJ9pQiqlbLUQ1wWC47rV1BZuQHkWmigF4g56aI9cONhtZ5QzuaZZLzAjbcxPBB
         5bly9KiEztq0M2JhOFFFa8xIcBQWb4c2mK0TM=
Received: by 10.42.172.131 with SMTP id n3mr3236112icz.247.1305380173263; Sat,
 14 May 2011 06:36:13 -0700 (PDT)
Received: by 10.42.164.1 with HTTP; Sat, 14 May 2011 06:36:13 -0700 (PDT)
In-Reply-To: <7vtycy7d9z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173583>

2011/5/14 Junio C Hamano <gitster@pobox.com>:
> Osamu OKANO <okano.osamu@gmail.com> writes:
>
>> @@ -53,7 +55,9 @@ msgstr "DESCRIPTION\n"
>>  msgid ""
>>  "This is a synonym for linkgit:git-add[1].  Please refer to the documentation "
>>  "of that command."
>> -msgstr "これは linkgit:git-add[1] の同義語です.  git-add のドキュメントを参照してください."
>> +msgstr ""
>> +"これは linkgit:git-add[1] の同義語です.  git-add のドキュメントを参照してくだ"
>> +"さい."
>
> Isn't this a no-op?  Translators need to be careful about these.
Yes, this part has no point.

Before I commit .po, I should run po4a-update
for the sake of line feed normalization.
Then I can avoid the crap diff.

1.2 new translation
====================
$ mkdir ja
$ cp git-stage.pot ja/git-stage.po
 -> 0003-cp-git-stage.pot-ja-git-stage.po.patch
$ cd ja
$  translate .po by hand ...
$ ../make_update  # add this procedure
 -> 0004-translate-ja-git-stage.po.patch
