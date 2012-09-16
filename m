From: Adrian Johnson <ajohnson@redneon.com>
Subject: Re: [PATCH] Add userdiff patterns for Ada
Date: Sun, 16 Sep 2012 16:49:14 +0930
Message-ID: <50557D72.60205@redneon.com>
References: <50554D67.1020204@redneon.com> <7vboh6zek0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 09:19:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TD98Y-0004bp-2U
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 09:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693Ab2IPHTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2012 03:19:18 -0400
Received: from redneon.com ([76.191.252.68]:37446 "EHLO redneon.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751614Ab2IPHTR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2012 03:19:17 -0400
Received: from bearcat.lan (ppp121-45-48-176.lns20.adl2.internode.on.net [121.45.48.176])
	by redneon.com (Postfix) with ESMTPA id 67554193027D;
	Sun, 16 Sep 2012 16:49:16 +0930 (CST)
Received: from [192.168.1.1] (bearcat.lan [192.168.1.1])
	by bearcat.lan (Postfix) with ESMTP id 0E35340256B2;
	Sun, 16 Sep 2012 16:49:15 +0930 (CST)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <7vboh6zek0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205599>

On 16/09/12 15:37, Junio C Hamano wrote:
> Adrian Johnson <ajohnson@redneon.com> writes:
> 
>> Add Ada xfuncname and wordRegex patterns to the list of builtin
>> patterns.
>>
>> Signed-off-by: Adrian Johnson <ajohnson@redneon.com>
>> ---
> 
> Interesting.  I do not read Ada, but in this "expect" file,...
> 
>> diff --git a/t/t4034/ada/expect b/t/t4034/ada/expect
>> new file mode 100644
>> index 0000000..be2376e
>> --- /dev/null
>> +++ b/t/t4034/ada/expect
>> @@ -0,0 +1,27 @@
>> +<BOLD>diff --git a/pre b/post<RESET>
>> +<BOLD>index d96fdd1..df21bb0 100644<RESET>
>> +<BOLD>--- a/pre<RESET>
>> +<BOLD>+++ b/post<RESET>
>> +<CYAN>@@ -1,13 +1,13 @@<RESET>
>> +Ada.Text_IO.Put_Line("Hello World<RED>!<RESET><GREEN>?<RESET>");
>> +1 1e<RED>-<RESET>10 16#FE12#E2 3.141_592 '<RED>x<RESET><GREEN>y<RESET>'
>> +<RED>a<RESET><GREEN>x<RESET>+<RED>b a<RESET><GREEN>y x<RESET>-<RED>b<RESET>
>> +<RED>a<RESET><GREEN>y<RESET>
>> +<GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>/<RED>b<RESET>
>> +<RED>a<RESET><GREEN>y<RESET>
>> +<GREEN>x<RESET>**<RED>b<RESET>
>> +<RED>a<RESET><GREEN>y<RESET>
>> +<GREEN>x<RESET>(<RED>b<RESET><GREEN>y<RESET>)
>> +<RED>a<RESET><GREEN>x<RESET>:=<RED>b<RESET>
>> +<RED>a<RESET><GREEN>y<RESET>
>> +<GREEN>x<RESET>=<RED>b a<RESET><GREEN>y x<RESET>/= <RED>b<RESET>
>> +<RED>a<RESET><GREEN>y<RESET>
>> +<GREEN>x<RESET><<RED>b a<RESET><GREEN>y x<RESET><=<RED>b a<RESET><GREEN>y x<RESET>><RED>b a<RESET><GREEN>y x<RESET>>=<RED>b<RESET>
>> +<RED>a<RESET><GREEN>y<RESET>
>> +<GREEN>x<RESET>,<RED>b<RESET>
>> +<RED>a<RESET><GREEN>y<RESET>
>> +<GREEN>x<RESET>=><RED>b<RESET>
>> +<RED>a<RESET><GREEN>y<RESET>
>> +<GREEN>x<RESET>..<RED>b<RESET>
>> +<RED>a<RESET><GREEN>y<RESET>
>> +<GREEN>x<RESET><><RED>b<RESET><GREEN>y<RESET>
> 
> I do not seem to find anything interesting after @@, which means
> that xfuncname is not tested at all even though the log message
> claims the patch adds some.

I probably misunderstood how the tests work. I thought t4034 tested
wordRegex while t4018 is for xfuncname. I based the Ada tests on the
Pascal tests but changed the operators to Ada operators. I'm not really
sure what else the test needs.

> 
> Puzzled...
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
