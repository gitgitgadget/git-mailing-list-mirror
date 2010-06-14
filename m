From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/6] Add library for string-specific memory pool
Date: Mon, 14 Jun 2010 11:26:37 +0200
Message-ID: <AANLkTilr9Qa9RJ3TIaCTgGwgp75TDBZbqRENC41xRFlq@mail.gmail.com>
References: <1276175389-6185-1-git-send-email-artagnon@gmail.com> 
	<1276175389-6185-4-git-send-email-artagnon@gmail.com> <7vk4q5ictl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 14 11:27:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OO5we-0004jv-9f
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 11:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755846Ab0FNJ07 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jun 2010 05:26:59 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:61331 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754126Ab0FNJ06 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jun 2010 05:26:58 -0400
Received: by gye5 with SMTP id 5so2230288gye.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 02:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=kYZod57OJQPK0T+OYsjHiMGsnG4lrvR7PcMs0HMt3+E=;
        b=n2WYbyiO3+bShgxMU+/vVf7J34e5D2LCTUAUv38wbMoEVzSCAEzxysJo0z1fDRm+t+
         97B4xEVZlvDaVhF42HS4VU/v15pfI6P0MjIObqOQuVmrEdqHT+0P27R4/Pt1W8pX9Z/1
         uhmexFyElg8UsAQR6rlYsE7olUqazrN/c9MvI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=WzlVxIS20Dgh2QJbbqA1NfW6yn7g549ifz+8uQTcq8truD5ZONLV80QVwqO6yQiDU7
         oIRx5pqFY3teHut3EO1GAqx7FQcm4cv6a/Mou36MW6eQ9vaDbRgQ9EYW77F2TfvBMP/6
         Alw0CNbilh/mb0s4v637Uv6iFuazflc0hmutw=
Received: by 10.229.214.8 with SMTP id gy8mr2163598qcb.173.1276507617411; Mon, 
	14 Jun 2010 02:26:57 -0700 (PDT)
Received: by 10.229.182.85 with HTTP; Mon, 14 Jun 2010 02:26:37 -0700 (PDT)
In-Reply-To: <7vk4q5ictl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149089>

Hi Junio,

Junio C Hamano wrote:
>> diff --git a/vcs-svn/string_pool.h b/vcs-svn/string_pool.h
>> new file mode 100644
>> index 0000000..a69d165
>> --- /dev/null
>> +++ b/vcs-svn/string_pool.h
>> @@ -0,1 +1,15 @@
>
> How did you manage to get "-0,1" here? =C2=A0This is supposed to be a=
 new file.
> PATCH 4/6 throws the same puzzlement at me.

I hand-edited the patch in Emacs and expected that diff-mode would
take care of all this. Apparently, I was wrong- I will investigate
this problem further, because editing patches by hand and making some
last-minute corrections (just before send-email) is very useful.
Thanks for pointing this out!

And thanks for getting the series into `pu`! Now I can focus on
figuring out the SVN API.

-- Ram
