From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 11/14] t3032-*.sh: Pass the -b (--binary) option to sed
 on cygwin
Date: Fri, 17 Dec 2010 08:34:02 +0100
Message-ID: <4D0B126A.8080702@viscovery.net>
References: <4D07B8B5.2030409@ramsay1.demon.co.uk> <7vtyigtaxn.fsf@alter.siamese.dyndns.org> <4D07FE91.2090003@sunshineco.com> <4D087AC7.2090705@viscovery.net> <4D088AB6.5090501@sunshineco.com> <4D0A8250.5090403@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Pat Thoyts <patthoyts@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Dec 17 08:34:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTUpS-00068X-KG
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 08:34:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676Ab0LQHeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Dec 2010 02:34:09 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:63634 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226Ab0LQHeI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Dec 2010 02:34:08 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PTUpG-0003sJ-Tz; Fri, 17 Dec 2010 08:34:03 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 8A3161660F;
	Fri, 17 Dec 2010 08:34:02 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <4D0A8250.5090403@ramsay1.demon.co.uk>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163866>

Am 12/16/2010 22:19, schrieb Ramsay Jones:
> Eric Sunshine wrote:
>> Your tool versions may indeed not be compatible with those of the 
>> netinstall environment [3]:
>>
>> $ sed --version
>> GNU sed version 4.2.1
>>
>> Unfortunately, the old --nocr is not recognized by modern GNU sed:
>>
>> $ sed --nocr
>> sed: unrecognized option `--nocr'
> 
> Yes. Like Johannes, I have sed version 3.02 on MinGW, but on cygwin
> I have sed version 4.1.5. See patch #14, where I introduce the
> SED_BIN_OPT variable to allow me to run the tests with SED_OPTIONS
> set to -c instead of -b.
> 
> [I thought I was unusual in having such an old sed version, but
> apparently not... ;-) ]

As far as I'm concerned, I'm not married to this old version, and I'll
update to a recent msysgit/MinGW environment RSN. So, in the long run,
your setup might turn out to be unusal ;-)

-- Hannes
