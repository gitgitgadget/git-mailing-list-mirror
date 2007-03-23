From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] have merge put FETCH_HEAD data in commit message
Date: Fri, 23 Mar 2007 15:23:55 +0100
Message-ID: <200703231523.58150.jnareb@gmail.com>
References: <7v648u38ws.fsf@assigned-by-dhcp.cox.net> <eu0m6t$hln$1@sea.gmane.org> <20070323135930.GB24788@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Fri Mar 23 15:21:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUkdj-0001a1-Ov
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 15:21:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753078AbXCWOVG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 23 Mar 2007 10:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753084AbXCWOVG
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 10:21:06 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:54603 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091AbXCWOVC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 10:21:02 -0400
Received: by nf-out-0910.google.com with SMTP id o25so2030836nfa
        for <git@vger.kernel.org>; Fri, 23 Mar 2007 07:21:01 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ScKl0cNfiMkvkTBWeRYD8S+TxDP1w8kyYfgXWIxw09fA7hg0NLOocoPl71iVBAWoTBhv0xSIokGZ0lMCHSxwRi64VL/XBDYWELg3Z+6POUfEljyGuvgh2wKD+szn+c/1tIbnWEGl/hDOIQggeySD4yINV/lLu6Jjwuo2pCEpKjU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=t/ZMGhauVqn3bdtLsukUNz6Bo5qt/SN6uSCucEqKqXQTe0Dp58LeZQWi1G608Cb5196g+aH7lHl8f4x2r/UMgMlDmibWyRD73tpS3qFdBzzAl/WxqmxZBjEqOrOfKO2XP19zdkaHKVlQIC6lv5XKx0QwzxNDPMN+rJabbs+3sAY=
Received: by 10.82.148.7 with SMTP id v7mr6697724bud.1174659661095;
        Fri, 23 Mar 2007 07:21:01 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id i5sm15412420mue.2007.03.23.07.20.59;
        Fri, 23 Mar 2007 07:20:59 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070323135930.GB24788@fieldses.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42935>

J. Bruce Fields wrote:
> On Fri, Mar 23, 2007 at 02:57:38PM +0100, Jakub Narebski wrote:
>> Junio C Hamano wrote:
>>=20
>>> +The commit message is formed by the title taken from the
>>> +"Subject: ", a blank line and the body of the message up to
>>> +where the patch begins. =A0Excess whitespaces at the end of the
>>> +lines are automatically stripped.
>>=20
>> Does this mean that git-am cannot make a log message that doesn't
>> follow git formatting commit message guidelines, namely short one-li=
ne
>> description, then longer description and signoff?
>=20
> The input to git-am is email, not log messages.

But that means that commit message which doesn't have empty line after
first line cannot be send via git-send-email + git-am without changes,
not be subject to git-rebase (which uses git-am machinery unless invoke=
d
with --merge option) without changing commit message, isn't it?

--=20
Jakub Narebski
Poland
