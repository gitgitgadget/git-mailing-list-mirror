From: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Subject: Re: [PATCH v4 1/2] git-imap-send: Add CRAM-MD5 authenticate method
 	support
Date: Sat, 13 Feb 2010 13:21:05 +0900
Message-ID: <4B7628B1.1070506@dcl.info.waseda.ac.jp>
References: <1265717345-2118-1-git-send-email-mitake@dcl.info.waseda.ac.jp>	 <1265974572-6282-1-git-send-email-mitake@dcl.info.waseda.ac.jp> <40aa078e1002120441p2240797du7481c8da21e6176b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Erik Faye-Lund <kusmabite@googlemail.com>, gitster@pobox.com,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Sat Feb 13 05:21:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ng9VL-0002Rc-Mx
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 05:21:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755795Ab0BMEVK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Feb 2010 23:21:10 -0500
Received: from ns.dcl.info.waseda.ac.jp ([133.9.216.194]:65373 "EHLO
	ns.dcl.info.waseda.ac.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754774Ab0BMEVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 23:21:09 -0500
Received: from localhost (localhost [127.0.0.1])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id E83CDEBFBF2;
	Sat, 13 Feb 2010 13:21:05 +0900 (JST)
X-Virus-Scanned: amavisd-new at dcl.info.waseda.ac.jp
Received: from ns.dcl.info.waseda.ac.jp ([127.0.0.1])
	by localhost (ns.dcl.info.waseda.ac.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JzRmebx0demA; Sat, 13 Feb 2010 13:21:05 +0900 (JST)
Received: from [192.168.10.21] (fw-cisco.dcl.info.waseda.ac.jp [133.9.216.204])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id 83A43EBFBEE;
	Sat, 13 Feb 2010 13:21:05 +0900 (JST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091211 Shredder/3.0
In-Reply-To: <40aa078e1002120441p2240797du7481c8da21e6176b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139773>

On 2010=E5=B9=B402=E6=9C=8812=E6=97=A5 21:41, Erik Faye-Lund wrote:
> On Fri, Feb 12, 2010 at 12:36 PM, Hitoshi Mitake
> <mitake@dcl.info.waseda.ac.jp>  wrote:
>> +
>> +static char *cram(const char *challenge_64, const char *user, const=
 char *pass)
>> +{
>> +       fprintf(stderr, "If you want to use CRAM-MD5 authenticate me=
thod,"
>> +               "you have to build git-imap-send with OpenSSL librar=
y\n");
>> +       exit(1);
>> +}
>> +
>
> Why not use die() here?
>

Ah, die() is the most adequate function for this case, thanks!
