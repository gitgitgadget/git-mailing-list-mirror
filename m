From: David Brown <git@davidb.org>
Subject: Re: [PATCH] rebase interactive: Add hint how to continue after
	'Unknown command' error
Date: Sun, 6 Jan 2008 11:50:44 -0800
Message-ID: <20080106195044.GA24169@old.davidb.org>
References: <1199634385511-git-send-email-prohaska@zib.de> <5F80ADF7-A68A-4DF3-8453-92B76BC927EF@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 20:51:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBbWj-0003IZ-K6
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 20:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753035AbYAFTuq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jan 2008 14:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752857AbYAFTuq
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 14:50:46 -0500
Received: from mail.davidb.org ([66.93.32.219]:51304 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752675AbYAFTuq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2008 14:50:46 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.68 #1 (Debian))
	id 1JBbW8-0006Mw-53; Sun, 06 Jan 2008 11:50:44 -0800
Mail-Followup-To: Wincent Colaiuta <win@wincent.com>,
	Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <5F80ADF7-A68A-4DF3-8453-92B76BC927EF@wincent.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69741>

On Sun, Jan 06, 2008 at 06:33:32PM +0100, Wincent Colaiuta wrote:
>El 6/1/2008, a las 16:46, Steffen Prohaska escribi=F3:
>
>> @@ -310,7 +310,7 @@ do_next () {
>> 		;;
>> 	*)
>> 		warn "Unknown command: $command $sha1 $rest"
>> -		die_with_patch $sha1 "Please fix this in the file $TODO."
>> +		die_with_patch $sha1 "Please fix this in the file $TODO. And run =
=20
>> 'git rebase --continue'."
>
>Grammar nit: sentences can't start with "And", so that should really b=
e:

Not true:
<http://www.accu-assist.com/grammar-tips-archive/11-07-06_GrammarTip_an=
d-but-conjunctions.htm>

Although, in this case, I would agree that it should just be one senten=
ce
with a comma.  It's more of a stylistic construct, more common in ficti=
on
than technical documentation.

Dave
