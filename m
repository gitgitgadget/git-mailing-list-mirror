From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Stupid quoting...
Date: Thu, 14 Jun 2007 09:06:30 +0200
Message-ID: <81b0412b0706140006v601b345re7dc0e58488cf61e@mail.gmail.com>
References: <86ir9sw0pi.fsf@lola.quinscape.zz>
	 <Pine.LNX.4.64.0706131316390.4059@racer.site>
	 <86ejkgvxmb.fsf@lola.quinscape.zz>
	 <Pine.LNX.4.64.0706140145450.4059@racer.site>
	 <86wsy76p4v.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "David Kastrup" <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jun 14 09:07:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyjQF-0003SS-2r
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 09:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754263AbXFNHGf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 03:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752481AbXFNHGe
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 03:06:34 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:5867 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754144AbXFNHGc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 03:06:32 -0400
Received: by wr-out-0506.google.com with SMTP id 76so398138wra
        for <git@vger.kernel.org>; Thu, 14 Jun 2007 00:06:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QCx+kbagFiWyfIK1zvuaDZJOB+fDe7ZVZcCqLrQPyUMtmpPMB9crISXZ/OXfw5MT3s8SQYOxlqxfoSNNqw8ytG4SGUbI6yA7fI2skjMcW2h3ZXSm2nFdDtZU9ed+TP5ag8UvJ80isEqBj9TroUpF4QrXkPntT/SFsRw+dupvR24=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NT0bEoWfC0xW090c5w1xLGmpJ5SNOwBZzE+LwSnEeXVctCBiWLbIMIysRGOKqgaEPhpw0sJBFflvIZasSsrDMDIja9ipDJDNQFtecpkufTcIq7n1plydQIZdDG7nxa4mwRoRV985TX8vNNDztHj9ZQsY25IvFjidtEc7RuO7pkI=
Received: by 10.78.206.9 with SMTP id d9mr545546hug.1181804790743;
        Thu, 14 Jun 2007 00:06:30 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Thu, 14 Jun 2007 00:06:30 -0700 (PDT)
In-Reply-To: <86wsy76p4v.fsf@lola.quinscape.zz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50172>

On 6/14/07, David Kastrup <dak@gnu.org> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> Can you actually name a program that would work with the default
> >> output of git here?
> >
> > echo.
>
> It doesn't, since it does not interpret the \NNN escape sequences that
> git chooses to output.

Have you tried that -z switch yet?
