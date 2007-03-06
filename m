From: "Jakub Narebski" <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Change to use explicitly function call cgi->escapHTML()
Date: Tue, 6 Mar 2007 10:34:32 +0100
Message-ID: <8fe92b430703060134l14fffcc4rbece3c2071c56422@mail.gmail.com>
References: <45ECE700.8090205@freescale.com>
	 <7v649euai8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Li Yang" <leoli@freescale.com>, git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 06 10:34:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOW45-0003Qf-Gu
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 10:34:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030453AbXCFJef (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 04:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030456AbXCFJee
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 04:34:34 -0500
Received: from wr-out-0506.google.com ([64.233.184.236]:43292 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030453AbXCFJee (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 04:34:34 -0500
Received: by wr-out-0506.google.com with SMTP id 37so1818094wra
        for <git@vger.kernel.org>; Tue, 06 Mar 2007 01:34:33 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=talKc0Nt/QiZh2Q4Em0/E5UC4XQvETOCKc9VIQO7b+KaPVnCbaewaWufl4OvOLCLbvgt2b6sIkP6d+yg5sUBpB3mNm5VHqv+EXC1CM7K/be39BZ3bNEhAXNquojObQcMLhkCddnC1K9YpOiIIrTnKDkbyr2bLl1+GiK7sueDg4w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=REHTWKOfKngYXuKTLWeYyY8acWzYYBkBHyu/VPmjLrusyZUWPtk2t5np1UQ53WNrL8Nlm9Y1oHz0qaFvEYV0yKJpeYSDOQpBh80ql1rLzxb32C2lb0IDzE+L2vzRnXKdrTvzWJYd9liCYkjywkPPRmpPU3uKo+g1J2D26V7qTXM=
Received: by 10.114.192.1 with SMTP id p1mr1674417waf.1173173672941;
        Tue, 06 Mar 2007 01:34:32 -0800 (PST)
Received: by 10.114.201.20 with HTTP; Tue, 6 Mar 2007 01:34:32 -0800 (PST)
In-Reply-To: <7v649euai8.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41564>

On 3/6/07, Junio C Hamano <junkio@cox.net> wrote:
> Li Yang <leoli@freescale.com> writes:
>
> > Change to use explicitly function call cgi->escapHTML().
> > This fix the problem on some systems that escapeHTML() is not
> > functioning, as default CGI is not setting 'escape' parameter.
> >
> > Signed-off-by: Li Yang <leoli@freescale.com>
>
> Regardless of the recent xhtml+html vs html discussion, I think
> this is probably a sane change.  Comments?

Good (although a bit magic) solution. Ack, FWIW.

-- 
Jakub Narebski
