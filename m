From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: t3702-add-edit.sh failure in next
Date: Mon, 27 Apr 2009 17:30:25 +0100
Message-ID: <e2b179460904270930m3c292bd8l5067447fff330fef@mail.gmail.com>
References: <e2b179460904270812t3fa159f1ja3b06905d9effebe@mail.gmail.com>
	 <alpine.DEB.1.00.0904271812180.7741@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016364d243916b53604688bdd98
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 27 18:30:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyTjI-00049g-IK
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 18:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756166AbZD0Qa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 12:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755874AbZD0Qa2
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 12:30:28 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:58774 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755714AbZD0Qa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 12:30:27 -0400
Received: by ewy24 with SMTP id 24so13326ewy.37
        for <git@vger.kernel.org>; Mon, 27 Apr 2009 09:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=zgXm/ANQ+VxN32auMhLaUfeWtY1YwZg0h6CGBNXVtSM=;
        b=H76ilKlWQHbCbeGK6YXv0w9eYG4YcgF58Ilu+CheU+tHhytW3iaWVT55ClM0bDNLbo
         jqTqFeLwItwxf2n29i1kLp4ijZa4hfC/vDiBAQD24CEZDAnrVwVjonaAJCDyEEMIlChQ
         J9ZBD2DujHHW5Df7CL++pJZhcR8Q7ZEnHriy4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=qVOAupbvyRkmWD65H5uDlnFbyEv+QqRgY/VAzQx7Kp0phhKDM+LOzhAOHyWszFVNZF
         cIa3lhKedz0AUpJelx6RtiVMl7ct5jY6uQWhUu+NbWJL09g1jhMtj2KUFgP/g9H1y7RO
         C3pdFLk29Dbi/d60/SjWeXzL8eYkKBIp81PS8=
Received: by 10.216.16.212 with SMTP id h62mr561754weh.201.1240849825838; Mon, 
	27 Apr 2009 09:30:25 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0904271812180.7741@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117687>

--0016364d243916b53604688bdd98
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

2009/4/27 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> On Mon, 27 Apr 2009, Mike Ralphson wrote:
>> I'm seeing a reproducible failure in t3702 on AIX 5.3, shell set to
>> bash (v2.05b)
>>
>> The 'test_cmp orig-patch expected-patch' is seeing this diff:
>>
>> 2c2
>> < index b9834b5..52aff4c 100644
>> ---
>> > index b9834b5..0b8f197 100644
>
> Could you send me the output of
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0cd t/trash\ directory.t3702* &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git show 0b8f197 > file.txt

Well I would, but there isn't any. It's an unknown revision. git fsck
-v doesn't show it anywhere. I have:

Checking HEAD link
Checking object directory
Checking directory .git/objects/91
Checking directory .git/objects/b9
Checking directory .git/objects/e0
Checking directory .git/objects/ef
Checking tree 911cd8fe32ce30bdaee8753cd526394a5c878cc0
Checking blob b9834b51dd31af09b373c39cae5c5fce38ee1034
Checking commit e055285ca8312c5bd9f369a5762fb5871ad110e8
Checking blob ef6e94c5794cbad5c1dc41bec85640ca54a46a55
Checking reflog
0000000000000000000000000000000000000000->e055285ca8312c5bd9f369a5762fb5871=
ad110e8
Checking reflog
0000000000000000000000000000000000000000->e055285ca8312c5bd9f369a5762fb5871=
ad110e8
Checking connectivity (32 objects)
Checking ef6e94c5794cbad5c1dc41bec85640ca54a46a55
Checking b9834b51dd31af09b373c39cae5c5fce38ee1034
Checking e055285ca8312c5bd9f369a5762fb5871ad110e8
Checking 911cd8fe32ce30bdaee8753cd526394a5c878cc0

blob, tree and commit of 'initial' I believe plus the new blob of the
expected content in ef6e94c (attached).

I've just tried building without INTERNAL_QSORT just in case, and it
doesn't seem to be that.

Mike

--0016364d243916b53604688bdd98
Content-Type: text/plain; charset=US-ASCII; name="ef6e94c5.txt"
Content-Disposition: attachment; filename="ef6e94c5.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fu1dswor0

TE8sIHByYWlzZSBvZiB0aGUgcHJvd2VzcyBvZiBwZW9wbGUta2luZ3MKb2Ygc3BlYXItYXJtZWQg
RGFuZXMsIGluIGRheXMgbG9uZyBzcGVkLAp3ZSBoYXZlIGhlYXJkLCBhbmQgd2hhdCBob25vciB0
aGUgYXRoZWxpbmdzIHdvbiEKCk9mdCBTY3lsZCB0aGUgU2NlZmluZyBmcm9tIHNxdWFkcm9uZWQg
Zm9lcywKZnJvbSBtYW55IGEgdHJpYmUsIHRoZSBtZWFkLWJlbmNoIHRvcmUsCmF3aW5nIHRoZSBl
YXJscy4gU2luY2UgZXJzdCBoZSBsYXkKZnJpZW5kbGVzcywgYSBmb3VuZGxpbmcsIGZhdGUgcmVw
YWlkIGhpbToKCmZvciBoZSB3YXhlZCB1bmRlciB3ZWxraW4sIGluIHdlYWx0aCBoZSB0aHJvdmUs
CnRpbGwgYmVmb3JlIGhpbSB0aGUgZm9saywgYm90aCBmYXIgYW5kIG5lYXIsCndobyBob3VzZSBi
eSB0aGUgd2hhbGUtcGF0aCwgaGVhcmQgaGlzIG1hbmRhdGUsCmdhdmUgaGltIGdpZnRzOiAgYSBn
b29kIGtpbmcgaGUhCg==
--0016364d243916b53604688bdd98--
