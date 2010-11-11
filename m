From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v3 0/3] Teach fetch and pull to recursively fetch submodules
Date: Thu, 11 Nov 2010 09:18:37 +0100
Message-ID: <4CDBA6DD.4040701@web.de>
References: <4CDB3063.5010801@web.de> <20101111000538.GB14189@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Kevin Ballard <kevin@sb.org>,
	Jon Seymour <jon.seymour@gmail.com>,
	Chris Packham <judge.packham@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 09:24:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGSRz-0007BK-Aa
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 09:24:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757817Ab0KKIYB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 03:24:01 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:44888 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757721Ab0KKIYA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 03:24:00 -0500
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate02.web.de (Postfix) with ESMTP id C3FF9181945B5;
	Thu, 11 Nov 2010 09:18:37 +0100 (CET)
Received: from [93.240.103.159] (helo=[192.168.178.29])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #24)
	id 1PGSMf-0007UI-00; Thu, 11 Nov 2010 09:18:37 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <20101111000538.GB14189@burratino>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+vckSoVp26WO1QfdrQluEPg0em3RdaveW62SmM
	Pv/ZABLyycAnYf1EcKlMNPkyHtQJliNNF9b6KH2DL0dnUP35eg
	ueai+9Tm8cYRqxvT/LVg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161216>

Am 11.11.2010 01:05, schrieb Jonathan Nieder:
> Jens Lehmann wrote:
> 
>> * Should the "--submodule-prefix" option - which is only used internally
>>   now - be a hidden option to "git fetch"?
> 
> Yes.  (Any option that is useless outside scripts should be, imho.)

Ok, I will change that.

>> But nonetheless I think this patch series is ok for inclusion as it does
>> not change default behavior and gives people the opportunity to play with
>> recursive fetch/pull by enabling one of the introduced config options.
> 
> Except for the .gitmodules detail I mentioned, it looks good to me.
> Looking forward to trying it out.

Thanks!
