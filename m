From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: Thunderbird and patches (was Re: [PATCH v2] Enable setting attach
   as the default in .gitconfig   for git-format-patch.)
Date: Mon, 09 Feb 2009 15:03:06 -0600
Message-ID: <kCHkjagMqmrTXbd229odxLGt0neIkfVZDCJPnhpXGVU71q9GcXEmPw@cipher.nrlssc.navy.mil>
References: <498E50E2.8050309@codeweavers.com> <200902072310.12764.bss@iguanasuicide.net> <498F01C2.5080105@codeweavers.com> <alpine.DEB.1.00.0902081827140.10279@pacific.mpi-cbg.de> <499022D3.3000200@drmicha.warpmail.net> <49902EDC.6020901@beonex.com> <alpine.DEB.1.00.0902091433270.10279@pacific.mpi-cbg.de> <49903521.1060101@codeweavers.com> <49903B27.8070608@beonex.com> <49904DE7.2080205@codeweavers.com> <4990519C.8060601@drmicha.warpmail.net> <499058B4.4070009@beonex.com> <qXxPO6LuQr7-9QoWMdojOMbuADIJ55oaOVr5t_8eLGR9vvNpW72wyA@cipher.nrlssc.navy.mil> <49907F75.2050100@beonex.com> <alpine.DEB.1.00.0902092013260.10279@pacific.mpi-cbg.de> <4990820B.504@beonex.com> <r57oMSnamWCJ1G1-r98G6mYQjX0YNpQz1OzEBHSrDifmBU_ir2P77A@cipher.nrlssc.navy.mil> <49908927.2030408@beonex.com> <49908B1A.7040101@
 beonex.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070904040803040408030006"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeremy White <jwhite@codeweavers.com>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org
To: Ben Bucksch <ben.bucksch.news@beonex.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 22:06:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWdJa-0005wl-T4
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 22:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753298AbZBIVDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 16:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753237AbZBIVDr
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 16:03:47 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:45777 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128AbZBIVDq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 16:03:46 -0500
Received: by mail.nrlssc.navy.mil id n19L37uD002445; Mon, 9 Feb 2009 15:03:07 -0600
In-Reply-To: <49908B1A.7040101@beonex.com>
X-OriginalArrivalTime: 09 Feb 2009 21:03:07.0462 (UTC) FILETIME=[CE9C7660:01C98AF9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109130>

This is a multi-part message in MIME format.
--------------070904040803040408030006
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Ben Bucksch wrote:
> On 09.02.2009 20:51, Ben Bucksch wrote:
>> On 09.02.2009 20:30, Brandon Casey wrote:
>>> Did you try it with the message I sent titled
>>> '[PATCH] example patch corrupted by thunderbird'?
>>
>> I tried now, and none of the editors/viewers I tried are displaying
>> anything that would come close to readable to me, even if you count
>> clearly marked hex character codes as readable. I tried less, e3 and
>> kwrite. Therefore, a) I can't verify whether the result is correct or not

You could look to see whether there are 6 lines in the hunk or 7.
There should only be 6.

  i.e. something like:

  @@ -0,0 +1,6 @@
  +T31,23
  +m4_location(_AC_LIST_MEMBER_IF)autoconf/fortran.m4:115
  +T17,203
  +m4_cr_not_Letters<sequence_of_control_characters>
  +<more_control_characters>
  +T15,855
  --

I have attached the original patch.  The headers will be different, and in the
attached patch they are only placeholders, but the content after the '---' should
be identical in all versions.

> I now compared the result of File | Save as.... (main menu, not context
> menu)

main menu or context menu both produce the same results for me.
Do they produce different results for you?

> | "1.eml" with the email on the cyrus server, and they are
> identical (diff and md5sum). So, TB *does* save it correctly,
> byte-for-byte.

Sorry, but I think you did your comparison wrong.  Possibly the tool
which extracted the email from the cyrus server performed the same
transformation that Thunderbird does.

You can also make a comparison with what is saved when you do
'View | Message Source' which pops up a new window, and then
File | Save Page As...

For me, they produce two different results. The one produced by
'View | Message Source ..etc' has a message body which is identical to
the one saved by pine, and to the original which is attached.

-brandon


--------------070904040803040408030006
Content-Type: text/x-patch;
 name="0001-autoconf.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="0001-autoconf.patch"

RnJvbSA5YWQ2MGUyZjEwOTAyOWY4Yzk2ZmNkYzExMTYyNTAxN2NiOGYzZWYyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBCcmFuZG9uIENhc2V5IDxjYXNleUBucmxzc2MubmF2
eS5taWw+CkRhdGU6IFdlZCwgMTQgSmFuIDIwMDkgMDc6MjQ6NTIgLTA2MDAKU3ViamVjdDog
W1BBVENIXSBleGFtcGxlIHBhdGNoIGNvcnJ1cHRlZCBieSB0aHVuZGVyYmlyZAoKVGhpcyBp
cyBhbiBleGFtcGxlIHBhdGNoIHdoaWNoIGlzIGNvcnJ1cHRlZCB3aGVuIHNhdmVkIHVzaW5n
IFRodW5kZXJiaXJkCnYyLjAuMC4xOS4KCi0tLQpkaWZmIC0tZ2l0IGEvYXV0b2NvbmYubTRm
IGIvYXV0b2NvbmYubTRmCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLjcz
MjgzYjUKLS0tIC9kZXYvbnVsbAorKysgYi9hdXRvY29uZi5tNGYKQEAgLTAsMCArMSw2IEBA
CitUMzEsMjMKK200X2xvY2F0aW9uKF9BQ19MSVNUX01FTUJFUl9JRilhdXRvY29uZi9mb3J0
cmFuLm00OjExNQorVDE3LDIwMworbTRfY3Jfbm90X0xldHRlcnMBAgMEBQYHCAkKKwsMDQ4P
EBESExQVFhcYGRobHB0eHyAhIiMkJSYnKCkqKywuLzAxMjM0NTY3ODk6Ozw9Pj9AW1xdXl9g
e3x9fn+AgYKDhIWGh4iJiouMjY6PkJGSk5SVlpeYmZqbnJ2en6ChoqOkpaanqKmqq6ytrq+w
sbKztLW2t7i5uru8vb6/wMHCw8TFxsfIycrLzM3Oz9DR0tPU1dbX2Nna29zd3t/g4eLj5OXm
5+jp6uvs7e7v8PHy8/T19vf4+fr7/P3+/y0KK1QxNSw4NTUKLS0gCjEuNi4xLjIzOS5nY2Yz
YmYKCg==
--------------070904040803040408030006--
