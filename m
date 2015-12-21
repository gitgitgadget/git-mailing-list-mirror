From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (Dec 2015, #05; Tue, 15)
Date: Mon, 21 Dec 2015 16:31:07 +0100
Message-ID: <56781B3B.1000705@web.de>
References: <xmqq8u4ve3at.fsf@gitster.mtv.corp.google.com>
 <56710B96.30103@web.de> <xmqqk2oee0co.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Dec 21 16:32:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aB2RS-0003Sl-TL
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 16:32:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbbLUPb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 10:31:29 -0500
Received: from mout.web.de ([212.227.17.11]:60080 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751009AbbLUPb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 10:31:28 -0500
Received: from macce.local ([87.146.129.103]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0M9GVO-1a1iVS09bK-00Cfzy; Mon, 21 Dec 2015 16:31:20
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.4.0
In-Reply-To: <xmqqk2oee0co.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:dRkwoUUXrM1EDx5a6H+31XprFa42DuU7G4mOiDTpTXUNi329yWm
 gTeD3wmdfGF1R5M8jMdyx3pS/crB6tGq6+J11gv5RyKAfCgaz6BQD+fESh7TOAndfGZ/yvi
 GuIiXSNy7PsuburgOWzFLDnaO1v77GDXRv+pIXS7Cj7QCHStM/VkVgVyBX+nRiLJcqvmCBv
 0qvwYWcUIBPX0vrkTrGsg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:i5rvYxAv0js=:i6nFldM2ynB++cE32DfQu4
 L0z8/8fspZWyVST+d7s6m2iO97Yl1KvhytSJklTmLC2sFAiD7NJXhWmUacNJlW1uxE0JEr7Bl
 LsgxnrwOVds31rWgN+61Elz6ei37nsZeCIureziWGtZWzddLPwhGYkNh6yVeM5oSYhb5TTxuF
 c0DmyepvDrDUr10e64CCQZe+4lxtHvv8kdlpaXauK+dRQuMvXUmVxwY1b3iXHaNsFkKRMM0Bz
 ZE4Jlqqcou7bZYDWf8HLFDiy/um7ZtyBx2c5OzfecKDsBgw5i5OlUM6HLByLlv5+eYay7vIit
 K0QKx+kpekJNZCn8mFAml4S3HhrmlneQg4H4r0ukFcbPnQNC47YANaXYDTiSMoQdzM0JG2Cuy
 C3QNGXpuvcOswy7ia9s2rvQcLE2XYXYNngxZvDmTjohdZvJ3yaNDQBHIpv3m3ZfCsWZWvPSLK
 Fs//aPofyboxkuPogNEkrybhQse94SmGfedkqOH49ES6SNVhcJ8jhRtK5Tz1xriR+nEOi76rU
 2i2ZoAilFUUHXkaXFPXrFfbPw9Nzqh1QppXjegFcHUH+dBB8DkRjxFuTGYI5VzbjrhkDtFc9D
 JtfmhUu8F2KKT7mNPD0LjpBkTRW9RfXB8VZvPhkw0q+cC3h4gJUdoU7h9kNUDEt7TPesK+aqm
 wbfRH/rfq9N0vS+pZ5qhK8q5PRD6iyd3g4mbx3P64a1+MQSN5bn+0FxnIEtXR5ZdQsOqXTvts
 7QWzaB6RMTKXhrbMIuAZ0M8n0Eg9bUmp9VL5LJ4MaImvAg27USN56EEKH3mcLf+qEHNGtOLp 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282795>

On 2015-12-16 19.04, Junio C Hamano wrote:
> Thanks.  In the meantime, I'll pick up v6 $gmane/282061 and replace
> the above with it.
I'm looking for a replacement for the grep/sed combination, but no luck with
different trial.
Can anybody help me out, please ?

git ls-files --eol -o | grep "TeBi_" | sed -e 's!attr/[=a-z-]*!!g' -e "s/  */
/g" | sort >actual &&
