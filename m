From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCHv2] t/t5515-fetch-merge-logic.sh: Added tests for the merge login in git-fetch
Date: Mon, 5 Mar 2007 09:36:27 +0100
Message-ID: <8aa486160703050036r42701933k321e93d166e78575@mail.gmail.com>
References: <87ps7oslwk.fsf@gmail.com> <87abyskt6k.fsf@gmail.com>
	 <7vslck14ly.fsf@assigned-by-dhcp.cox.net>
	 <20070305082846.GC12104@always.joy.eth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Joshua N Pritikin" <jpritikin@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 09:36:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HO8gQ-0005kN-0g
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 09:36:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbXCEIga convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 5 Mar 2007 03:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbXCEIga
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 03:36:30 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:47348 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932263AbXCEIg3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Mar 2007 03:36:29 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2014237nfa
        for <git@vger.kernel.org>; Mon, 05 Mar 2007 00:36:28 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VwXWFq5OP02zhCgUJZ3dT1+rsoLMU4IQM2WJp1U3zl9TzDY20OV8V6Q++ESuGNG5MRikoy4HaN16mlHLquxINrXqEX18MXttGxrwr5P47CsxQNe3Tz1XiimHmQTF1SIRsRliT5qBMW3l60T/hI1rssOjJLB60wsDt3BL7vmJeBk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pFVU6PWIV8yr0CIglv6u8dQPAl6jaYxaHz0WEPRjNcK0crkmG3/DTe4oTovur1VpCCrJnK2Je52L10Z+SiM4ut8i2HCxWbZd6lMrVjH/6PCayhi39YdEAJ23X/jdEO9En0g/IzvDt1HdSwFBZtPKlz0DOEZQJyD/WkinsOGHa4k=
Received: by 10.78.201.2 with SMTP id y2mr587671huf.1173083787989;
        Mon, 05 Mar 2007 00:36:27 -0800 (PST)
Received: by 10.78.69.4 with HTTP; Mon, 5 Mar 2007 00:36:27 -0800 (PST)
In-Reply-To: <20070305082846.GC12104@always.joy.eth.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41421>

On 3/5/07, Joshua N Pritikin <jpritikin@pobox.com> wrote:
> On Mon, Mar 05, 2007 at 12:23:05AM -0800, Junio C Hamano wrote:
> > Santi B=E9jar <sbejar@gmail.com> writes:
> > > P.D.: When sended this way the From: must be quoted or in UTF-8?
> >
> > Absolutely not.
>
> I think Junio meant that UTF-8 is OK. At least it is okay here in mut=
t.

OK, thanks. So the next question is if git-format-patch needs a flag
to indicate that?

--in-body?

Santi
