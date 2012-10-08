From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: Ignoring boring lines(that do not contain information) in git diff
Date: Mon, 08 Oct 2012 18:44:12 +0200
Message-ID: <507302DC.4030207@arcor.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000602030003040701070205"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 08 18:44:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLGRN-0007c6-TI
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 18:44:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754054Ab2JHQoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 12:44:16 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:47112 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751823Ab2JHQoO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Oct 2012 12:44:14 -0400
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mx.arcor.de (Postfix) with ESMTP id 9B84FA9D9C
	for <git@vger.kernel.org>; Mon,  8 Oct 2012 18:44:13 +0200 (CEST)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id 943DE28A4EB
	for <git@vger.kernel.org>; Mon,  8 Oct 2012 18:44:13 +0200 (CEST)
Received: from [10.0.0.3] (178-190-166-221.adsl.highway.telekom.at [178.190.166.221])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-02.arcor-online.net (Postfix) with ESMTPA id 68EB71198A2
	for <git@vger.kernel.org>; Mon,  8 Oct 2012 18:44:13 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-02.arcor-online.net 68EB71198A2
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1349714653; bh=lH3T6JXsC78aFpckvPV3PbXOmkvbpnyR7X8rAuk199Q=;
	h=Message-ID:Date:From:MIME-Version:To:Subject:Content-Type;
	b=eIoWCyyIyBbC2920hNkryBTCfSFZ2IoAzEyjb1gY4soEbi5NshgssQKbKi8ACwwX4
	 IyPWjyFJELLnwdpuN4sJbqFlogr4h8mqyKn4I+NjBZunf/CF1UEGNxECsAipP1/WNI
	 x6kDhYqxRZmZL0ld7Jr0WHHl59NVwTaOzkWs+a6c=
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:15.0) Gecko/20120827 Thunderbird/15.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207239>

This is a multi-part message in MIME format.
--------------000602030003040701070205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

is there a way to tell git diff about lines that are uninteresting?
I mean lines which do not contain a lot of information and
appear several times in pre and post image.

For example whitespace or language dependent stuff like.
{
}
END_IF;
END_FOR;
end sub

I have seen diffs that containing 2 interesting hunks splitted by such 
boring lines.
(I have attached a anonymized version of a real world example where this 
happens)

I think the diff would be clearer when this boring line was added to the 
surrounding hunks.
I already tried patience diff but in my test case it changed nothing.
I am using git 1.7.10.

Thanks,
Greetings Peter



--------------000602030003040701070205
Content-Type: text/x-diff;
 name="example_diff_boring_split.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="example_diff_boring_split.diff"

ZGlmZiAtLWdpdCBhL1NvdXJjZS9Gcm9iYmxlL0JsYWJiZXIudHh0IGIvU291cmNlL0Zyb2Ji
bGUvQmxhYmJlci50eHQKaW5kZXggODdjY2RkYi4uNjI3YmMzZSAxMDA2NDQKLS0tIGEvU291
cmNlL0Zyb2JibGUvQmxhYmJlci50eHQKKysrIGIvU291cmNlL0Zyb2JibGUvQmxhYmJlci50
eHQKQEAgLTEzOCw3MyArMTM4LDc0IEBAIEVORF9WQVIKLSAgICAgICAgIC8vZnJvYmJsZSBp
bW1lZGlhdGVseSBpZiBpbW1lZGlhdGVseSBmbGFnIGlzIHNldAotICAgICAgICAgSUYgYklt
bWVkaWF0ZWx5IEFORCBOT1QgQXJyYXlbaV0uYkRpc2FibGVkIFRIRU4KLSAgICAgICAgICAg
IGFGcm9iYmxlKGksIEVudHJ5KTsKKyAgICAgICAgIElGIEVudHJ5LmJCbGFoIFRIRU4KKyAg
ICAgICAgICAgICAgIEFsYXJtLkFsYXJtICA6PSBTb21lQWxhcm07CisgICAgICAgICBFTFNF
CisgICAgICAgICAgICAgICBBbGFybSA6PSBFbnRyeTsKICAgICAgICAgIEVORF9JRjsKICAg
ICAgICAgIAotICAgICAgICAgLy8gc2lnbmFsIGlmIGZyb2JibGUgY291bnQgaGFzIGNoYW5n
ZWQKLSAgICAgICAgIGlDaGFuZ2VkIDo9IGlDaGFuZ2VkICsgMTsKLSAgICAgICAgIEVYSVQ7
CisgICAgICAgICBJRiBBcnJheVtpXS5BbGFybSA9IEFsYXJtIFRIRU4KKyAgICAgICAgICAg
IC8vZG8gbm90IGJyYWJibGUgaWYgYWxhcm0gaXMgZ29iYmxlZAorICAgICAgICAgICAgICAg
RVhJVDsKKyAgICAgICAgIEVORF9JRjsKICAgICAgIEVORF9JRjsKLSAgIEVORF9GT1I7Ci1F
TFNFCi0gICBhRXhhbXBsZShOYW1lIDo9ICdhYWEnLAotICAgICAgICAgICAgSUQxIDo9IDEp
OwotRU5EX0lGOworICAgRUxTRQorICAgICAgLy9lbnRyeSBub3QgZm91bmQsIGFkZGluZw==
--------------000602030003040701070205--
