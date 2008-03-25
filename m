From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/5] test_must_fail: 129 is a valid error code from  
 usage()
Date: Tue, 25 Mar 2008 12:21:50 +0100
Message-ID: <47E8E04E.6060606@viscovery.net>
References: <200803232150.29971.barra_cuda@katamail.com> <200803241502.21465.barra_cuda@katamail.com> <7vwsnrubmd.fsf@gitster.siamese.dyndns.org> <200803242218.44026.barra_cuda@katamail.com> <7vbq53nvaz.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803251100520.10660@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junio@pobox.com>,
	Michele Ballabio <barra_cuda@katamail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 25 12:23:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je7Ex-000543-TG
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 12:22:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753394AbYCYLWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 07:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753389AbYCYLV7
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 07:21:59 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:43501 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320AbYCYLV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 07:21:59 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Je7D9-0005MM-8U; Tue, 25 Mar 2008 12:21:02 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 436BC6B7; Tue, 25 Mar 2008 12:21:52 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <alpine.LSU.1.00.0803251100520.10660@wbgn129.biozentrum.uni-wuerzburg.de>
X-Spam-Score: -0.8 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_60=1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78181>

Johannes Schindelin schrieb:
> Hi,
> 
> On Mon, 24 Mar 2008, Junio C Hamano wrote:
> 
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index 870b255..7c2a8ba 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -300,7 +300,7 @@ test_expect_code () {
>>  
>>  test_must_fail () {
>>  	"$@"
>> -	test $? -gt 0 -a $? -le 128
>> +	test $? -gt 0 -a $? -le 129
> 
> IIRC exit status is a signed byte on Win32.  Can somebody check?

Not at the shell level. This command:

   git branch foo bar baz

exits with 129 both when invoked by bash ($?) and CMD (%ERRORLEVEL%).

-- Hannes
