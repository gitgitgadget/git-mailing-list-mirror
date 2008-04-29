From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Re: reflog/show question
Date: Tue, 29 Apr 2008 11:17:09 +0930
Message-ID: <93c3eada0804281847q267611aeke51b482cfbe100d6@mail.gmail.com>
References: <93c3eada0804271859p1b4d8b52i811bdc5e42672822@mail.gmail.com>
	 <20080428092410.GD16153@sigill.intra.peff.net>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_7604_12998504.1209433629905"
To: "Jeff King" <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 03:49:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqexr-0005tD-AF
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 03:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221AbYD2BrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 21:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752032AbYD2BrN
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 21:47:13 -0400
Received: from mu-out-0910.google.com ([209.85.134.186]:42711 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872AbYD2BrM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 21:47:12 -0400
Received: by mu-out-0910.google.com with SMTP id i10so3628859mue.1
        for <git@vger.kernel.org>; Mon, 28 Apr 2008 18:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:references;
        bh=Xv8OrhiWQ3Y7v+U3UW54LtvVrWtYN6A2zfcPVl9nd4U=;
        b=saut5F9eEWAM9dwzFghMUAWC+1o09psagOJdnitOAp4D+SwioVcJxR1OgCmZkoyRFsDuQmuxQsABSmt7niWUKeU2NyTX6COlbTaxSmvf3+jbqx1v8K7qOJ1iNxKFbWVJWn5qU4DX5lWEAtbKNPFmubX8gD1x0/3sKPuGt+LIKaI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:references;
        b=We05k82XpToeDtTicCpZhcoDpSfdT16EK5fWqSnrN+SKnILyAuqQDWkG7Uu9/gOqlIcv0iOVgDeEUKJIe62DA56j7oO630/FVNYcSbq1jzqFx9XGQqx5mUgGLdwjDGbkmJNCXum3S7NAOysuvEmk7b7B3TN77pyZEvdlLLUeveA=
Received: by 10.82.188.15 with SMTP id l15mr3762738buf.74.1209433629923;
        Mon, 28 Apr 2008 18:47:09 -0700 (PDT)
Received: by 10.82.105.8 with HTTP; Mon, 28 Apr 2008 18:47:09 -0700 (PDT)
In-Reply-To: <20080428092410.GD16153@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80639>

------=_Part_7604_12998504.1209433629905
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, Apr 28, 2008 at 6:54 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Apr 28, 2008 at 11:29:17AM +0930, Geoff Russell wrote:
>
>  >      git show HEAD@{"3 minutes ago"}
>  >
>  > works as I expect, but
>  >
>  >      git show HEAD@{"3 minutes ago"}:data/node/node.data
>  >
>  > gives me a message:
>  >
>  >        warning: Log for 'HEAD' only goes back to Mon, 28 Apr 2008
>  > 10:18:37 +0930.
>  >
>  > [...]
>
> > I'm using 1.5.4.rc4
>
>  I can't reproduce here, using the current master or v1.5.4-rc4. If I
>  have a matching reflog, both work. And if I choose a much older time
>  (say, "1.year.ago"), then both fail. What are the entries in your
>  reflog (.git/logs/HEAD)?

I think its something to do with the filename and my commit comments.
The command
works as expected on other files.  The HEAD file is attached.

Geoff

>
>  -Peff
>



-- 
6 Fifth Ave,
St Morris, S.A. 5068
Australia
Ph: 041 8805 184 / 08 8332 5069

------=_Part_7604_12998504.1209433629905
Content-Type: application/octet-stream; name=HEAD
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fflthn7e0
Content-Disposition: attachment; filename=HEAD

MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMCA3MzM4N2Y0YWJjM2Y1NWJh
OTNmOTM3OWQ5MzU5YzVhMDNhNTE2YTY2IE1BVFJJQ1MgU29mdHdhcmUgPG1hdHJpY3NAZmFpdGgu
bG9jYWxkb21haW4+IDEyMDk0MzI2NDYgKzA5MzAJY29tbWl0IChpbml0aWFsKTogY3JlYXRlRGF0
YXNldCBuZXdkczEKNzMzODdmNGFiYzNmNTViYTkzZjkzNzlkOTM1OWM1YTAzYTUxNmE2NiBmMTM0
NjliODA1YTA1Y2VmMjEzZTNjYThiMDMwZTgzMTRkMTk2YWNjIE1BVFJJQ1MgU29mdHdhcmUgPG1h
dHJpY3NAZmFpdGgubG9jYWxkb21haW4+IDEyMDk0MzI2NDggKzA5MzAJY29tbWl0OiBzZXRQcm9w
ZXJ0aWVzCmYxMzQ2OWI4MDVhMDVjZWYyMTNlM2NhOGIwMzBlODMxNGQxOTZhY2MgZmU2MWVlYWE4
NWM4ZWM2ODkzNTIyNGJhZTk5NTI4ZmRjZmM4NzM1MiBNQVRSSUNTIFNvZnR3YXJlIDxtYXRyaWNz
QGZhaXRoLmxvY2FsZG9tYWluPiAxMjA5NDMyNjU5ICswOTMwCWNvbW1pdDogdXBkYXRlIC5tYXRy
aWNzLnJlc3RyaWN0CmZlNjFlZWFhODVjOGVjNjg5MzUyMjRiYWU5OTUyOGZkY2ZjODczNTIgN2Iw
NzgzYTJmOTkxMzFhMWE3NTlkMTY0OTRmOTE4ODlmZTIzZTcyNiBNQVRSSUNTIFNvZnR3YXJlIDxt
YXRyaWNzQGZhaXRoLmxvY2FsZG9tYWluPiAxMjA5NDMyNjYyICswOTMwCWNvbW1pdDogbmV3IG5v
ZGUuZGIKN2IwNzgzYTJmOTkxMzFhMWE3NTlkMTY0OTRmOTE4ODlmZTIzZTcyNiAyMTI0ZGE4MDY0
Mzc2MGU5Y2I2NWNiZWVhMTY3OGY2ZjY1ZjZhNjAzIE1BVFJJQ1MgU29mdHdhcmUgPG1hdHJpY3NA
ZmFpdGgubG9jYWxkb21haW4+IDEyMDk0MzI2NjUgKzA5MzAJY29tbWl0OiBuZXcgbm9kZS5uZXdk
czEKMjEyNGRhODA2NDM3NjBlOWNiNjVjYmVlYTE2NzhmNmY2NWY2YTYwMyA0MTY3ZmNhZDIyNDk0
MTMyMmM0YTE1ZTgxM2FjNGZkZDcwMmZhNmZmIE1BVFJJQ1MgU29mdHdhcmUgPG1hdHJpY3NAZmFp
dGgubG9jYWxkb21haW4+IDEyMDk0MzI2NjYgKzA5MzAJY29tbWl0OiBuZXcgbm9kZS5kZWxuZXdk
czEKNDE2N2ZjYWQyMjQ5NDEzMjJjNGExNWU4MTNhYzRmZGQ3MDJmYTZmZiBiM2QxY2EwM2E2ZWRl
MzFhYzdmN2Q0ZWEyNjRhYmE2ZTE3Y2E0OWJiIE1BVFJJQ1MgU29mdHdhcmUgPG1hdHJpY3NAZmFp
dGgubG9jYWxkb21haW4+IDEyMDk0MzI2NjcgKzA5MzAJY29tbWl0OiBkZWxmIG5vZGUuZGVsbmV3
ZHMxCmIzZDFjYTAzYTZlZGUzMWFjN2Y3ZDRlYTI2NGFiYTZlMTdjYTQ5YmIgZDZiNzI3ZjBhNTRm
NjQ1MTExMjY3MTVkMGYzMjgyNjEzOTFlZjYwYSBNQVRSSUNTIFNvZnR3YXJlIDxtYXRyaWNzQGZh
aXRoLmxvY2FsZG9tYWluPiAxMjA5NDMyNjcxICswOTMwCWNvbW1pdDogdXNlcj1nZW9mZixmaWxl
PW5vZGUubmV3ZHMxLHByb2dyYW09cHV0Zixjd2Q9L3Vzci9sb2NhbC9BdXNUb3AvQXVQcm9ncmFt
cy9BdVNlcnZlcix0aW1lPTEyMDk0MzI2NzEsc291cmNlZHM9bmV3ZHMxCmQ2YjcyN2YwYTU0ZjY0
NTExMTI2NzE1ZDBmMzI4MjYxMzkxZWY2MGEgZjk5NzVmNmNjMDYxMzUwYWIzZDFkMWI0OTQ3YTIx
OGIwZGZiOGIyMyBNQVRSSUNTIFNvZnR3YXJlIDxtYXRyaWNzQGZhaXRoLmxvY2FsZG9tYWluPiAx
MjA5NDMyNjc0ICswOTMwCWNvbW1pdDogcmVjdmYgbm9kZS5uZXdkczEKZjk5NzVmNmNjMDYxMzUw
YWIzZDFkMWI0OTQ3YTIxOGIwZGZiOGIyMyA4YmJkNzRiMjhkYmIwYjM1MGU2OTlkNjYxYzc0ODA4
NGUwOGVkZjNlIE1BVFJJQ1MgU29mdHdhcmUgPG1hdHJpY3NAZmFpdGgubG9jYWxkb21haW4+IDEy
MDk0MzI2ODYgKzA5MzAJY29tbWl0OiB1c2VyPWdlb2ZmLGZpbGU9bm9kZS5uZXdkczEscHJvZ3Jh
bT1wdXRmLGN3ZD0vdXNyL2xvY2FsL0F1c1RvcC9BdVByb2dyYW1zL0F1U2VydmVyLHRpbWU9MTIw
OTQzMjY4NSxzb3VyY2Vkcz1uZXdkczEKOGJiZDc0YjI4ZGJiMGIzNTBlNjk5ZDY2MWM3NDgwODRl
MDhlZGYzZSAxYjgzNDY4YmYyMzQ0NTUwNDBhMjcwMzkyOTkyMDc3YmQwZDA3YjAxIE1BVFJJQ1Mg
U29mdHdhcmUgPG1hdHJpY3NAZmFpdGgubG9jYWxkb21haW4+IDEyMDk0MzI2ODkgKzA5MzAJY29t
bWl0OiBnZW9mZiByZXNldHRpbmcgZGF0YXNldCAyMTI0ZGE4MDY0Mzc2MGU5Y2I2NWNiZWVhMTY3
OGY2ZjY1ZjZhNjAzCjFiODM0NjhiZjIzNDQ1NTA0MGEyNzAzOTI5OTIwNzdiZDBkMDdiMDEgZDIz
NTZiMWNlMDJiYmNiZjI0ZTFlNzk1MWY0ZmEwMGQ1YjU4ZDRhMCBNQVRSSUNTIFNvZnR3YXJlIDxt
YXRyaWNzQGZhaXRoLmxvY2FsZG9tYWluPiAxMjA5NDMyNjkwICswOTMwCWNvbW1pdDogZ2VvZmYg
cmVzZXR0aW5nIGRhdGFzZXQgSEVBREAnezF9JwpkMjM1NmIxY2UwMmJiY2JmMjRlMWU3OTUxZjRm
YTAwZDViNThkNGEwIGYwMjY1YzJiYmRlZmE1MmNkODMwYmQwZTk2MjRlYjdkNzIwZWVkMTIgTUFU
UklDUyBTb2Z0d2FyZSA8bWF0cmljc0BmYWl0aC5sb2NhbGRvbWFpbj4gMTIwOTQzMjY5MiArMDkz
MAljb21taXQ6IGNvcHlmIG5vZGUubmV3ZHMxIG5vZGUuY29weW5ld2RzMQpmMDI2NWMyYmJkZWZh
NTJjZDgzMGJkMGU5NjI0ZWI3ZDcyMGVlZDEyIGJmZTcwOTRmNGJkM2IzZjlmZjMzOTUwYzQ4NGIz
YjQ0ZTBkOWI1ZTUgTUFUUklDUyBTb2Z0d2FyZSA8bWF0cmljc0BmYWl0aC5sb2NhbGRvbWFpbj4g
MTIwOTQzMjY5NSArMDkzMAljb21taXQ6IGRlbGYgbm9kZS5jb3B5bmV3ZHMxCmJmZTcwOTRmNGJk
M2IzZjlmZjMzOTUwYzQ4NGIzYjQ0ZTBkOWI1ZTUgNDBjMmM3Mjg1MjQxOWYxYzIyMjA5MDNlZTk3
N2VhM2UwNjMzODkyNiBHZW9mZiBSdXNzZWxsIDxnZW9mZnJleS5ydXNzZWxsQGdtYWlsLmNvbT4g
MTIwOTQzMjk5NyArMDkzMAljb21taXQ6IG1vZGlmeSBpdAo0MGMyYzcyODUyNDE5ZjFjMjIyMDkw
M2VlOTc3ZWEzZTA2MzM4OTI2IDY5ZWRhZmQ4MzcxZWQ4NjEzY2Y4NzczNmI2OWUzMTg0Zjk3NGNk
NzQgR2VvZmYgUnVzc2VsbCA8Z2VvZmZyZXkucnVzc2VsbEBnbWFpbC5jb20+IDEyMDk0MzMxMTgg
KzA5MzAJY29tbWl0OiBhZGQgc3R1ZmYKNjllZGFmZDgzNzFlZDg2MTNjZjg3NzM2YjY5ZTMxODRm
OTc0Y2Q3NCA4ZDRlN2FhMjMwMzk4MmRhNWRkMWRmZjYwYjY3ZTkyNDA5ODMyM2I0IEdlb2ZmIFJ1
c3NlbGwgPGdlb2ZmcmV5LnJ1c3NlbGxAZ21haWwuY29tPiAxMjA5NDMzMjIwICswOTMwCWNvbW1p
dDogbmV3IGZpbGU6IGRhdGEvbm9kZS94eHgKOGQ0ZTdhYTIzMDM5ODJkYTVkZDFkZmY2MGI2N2U5
MjQwOTgzMjNiNCBlZmUwZjkwNzcyZDg0YzgwOGEyMjhjMWM3ODU1NjVhMzRiNWIyYzgyIEdlb2Zm
IFJ1c3NlbGwgPGdlb2ZmcmV5LnJ1c3NlbGxAZ21haWwuY29tPiAxMjA5NDMzMjUwICswOTMwCWNv
bW1pdDogT2theQo=
------=_Part_7604_12998504.1209433629905--
