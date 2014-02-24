From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: git am and mangled subject lines
Date: Mon, 24 Feb 2014 15:24:15 -0500
Message-ID: <530BAA6F.4030401@ubuntu.com>
References: <530B9D50.6020705@ubuntu.com> <xmqqios48drt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 21:24:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WI24a-0002BX-LW
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 21:24:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649AbaBXUYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 15:24:16 -0500
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:38303 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbaBXUYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 15:24:16 -0500
X-Authority-Analysis: v=2.0 cv=GbyVbHrL c=1 sm=0 a=/DbS/tiKggfTkRRHPZEB4g==:17 a=JipEcVzqA9wA:10 a=NMzMoPr3rC4A:10 a=S1A5HrydsesA:10 a=Qsx_du5GiBkA:10 a=8nJEP1OIZ-IA:10 a=fxJcL_dCAAAA:8 a=KGjhK52YXX0A:10 a=wchcOXPDnHAA:10 a=QfKxxUxMAAAA:8 a=QhqDonyLQY_PZiEmhccA:9 a=wPNLvfGTeEIA:10 a=2eKvNQJKnqYA:10 a=/DbS/tiKggfTkRRHPZEB4g==:117
X-Cloudmark-Score: 0
X-Authenticated-User: 
X-Originating-IP: 67.78.168.186
Received: from [67.78.168.186] ([67.78.168.186:53663] helo=[10.1.1.236])
	by cdptpa-oedge02.mail.rr.com (envelope-from <psusi@ubuntu.com>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id DF/D6-00765-E6AAB035; Mon, 24 Feb 2014 20:24:14 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <xmqqios48drt.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242641>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 2/24/2014 3:19 PM, Junio C Hamano wrote:
> Phillip Susi <psusi@ubuntu.com> writes:
> 
>> git am already ignores the "[PATCH X/Y]" prefix that
>> format-patch adds.  Is it possible to get it to ignore any
>> additional prefix that a bug tracker mangles into the subject
>> line?  i.e. "bug #nnnn:"?
> 
> I think applypatch-msg hook is your friend in a case like this.

Can you point me in the direction of some documentation on this?  I
don't see it mentioned in the man pages for git am or mailinfo ( I
would think that would be the place to have it ).


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJTC6pvAAoJEI5FoCIzSKrwQpYH/iJ8RPqEoIoO+GBU2HxmCfEZ
Tlo1qwbvw26ALY71/WQFtVKW+3Bh1XYpAs0rsL5tpCJw/EMgAEm1cPFASf+BHcRI
NO57NBdk9we+hvUju+o6/It5e6OrYj/im+nI/AFfenRsbwPj8/S0MoMiP4jOEVkW
tTSCEeC5ldR4IbxBfphbV7me79Sk8nZssXTFmWJEv80H41LdMd8ZThR4ZFCcyzUR
ifAflWHN7dj3uwY0Lr+OdCRrPw3qU1LXRjKK2SHBTG1Qk4uJW3sFJKHTupAipOEQ
KKQ0QP/4WQWCSjq+8El4jnnlf++KAwbbOnAVYkbeKzy/4KOxJX7pimDypJHYGp8=
=LZvc
-----END PGP SIGNATURE-----
