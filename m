From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: Re: git show and the --quiet option
Date: Sat, 28 May 2011 20:03:50 +0200
Message-ID: <4DE13906.9030806@isy.liu.se>
References: <4DE12888.1040506@isy.liu.se> <20110528172611.GB28708@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 28 20:04:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQNsb-0006JO-3d
	for gcvg-git-2@lo.gmane.org; Sat, 28 May 2011 20:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754830Ab1E1SD4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 May 2011 14:03:56 -0400
Received: from muon.isy.liu.se ([130.236.48.25]:37386 "EHLO muon.isy.liu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754760Ab1E1SDz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2011 14:03:55 -0400
Received: from [192.168.2.5] (217-211-21-249-no36.tbcn.telia.com [217.211.21.249])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by muon.isy.liu.se (Postfix) with ESMTPSA id EFC5D34F;
	Sat, 28 May 2011 20:03:52 +0200 (MEST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <20110528172611.GB28708@centaur.lab.cmartin.tk>
X-Enigmail-Version: 1.1.1
X-ISY-LIU-SE-MailScanner-Information: Please contact postmaster@isy.liu.se for more information
X-ISY-LIU-SE-MailScanner-ID: EFC5D34F.A0045
X-ISY-LIU-SE-MailScanner: Found to be clean
X-ISY-LIU-SE-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-1, required 6, ALL_TRUSTED -1.00)
X-ISY-LIU-SE-MailScanner-From: hendeby@isy.liu.se
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174668>

Hi Carlos,

thanks for the detailed answer.

On 05/28/2011 07:26 PM, Carlos Mart=EDn Nieto wrote:
> On Sat, May 28, 2011 at 06:53:28PM +0200, Gustaf Hendeby wrote:
>> Hello everyone,
>>
>> I was playing around with "git show" lately and realized it has chan=
ged
>> its behavior regarding the --quiet option, which no longer suppresse=
s
>> the diff output as it used to.  The behavior change happened in
>> 1c40c36b ("log: convert to parse-options").  Was this intentional?
>  How are you using the --quiet option and why would you even need it?

I used

git show --quiet --pretty=3D"format:%ci" HEAD

to extract the commit date of HEAD, and I simply replaced it with

git log -1 --quiet --pretty=3D"format:%ci" HEAD

Though, the email from Junio suggests I should use (and this works)

git show -a --pretty=3D"format:%ci" HEAD

still, I wonder if there is no better/more efficient solution to this.

/Gustaf
