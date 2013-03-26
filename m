From: demerphq <demerphq@gmail.com>
Subject: Re: git ate my home directory :-(
Date: Tue, 26 Mar 2013 18:20:09 +0100
Message-ID: <CANgJU+Wihp=rSQevij6R7SnZtW8UpDtRpFYE00aKKAwiYi9Q_Q@mail.gmail.com>
References: <5150C3EC.6010608@nod.at>
	<20130325214343.GF1414@google.com>
	<7vboa7w2vm.fsf@alter.siamese.dyndns.org>
	<384BCFE976364F1EA6E56306566D003A@PhilipOakley>
	<51519DA0.4090201@nod.at>
	<20130326145637.GA3822@sigill.intra.peff.net>
	<5151D589.2000002@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
X-From: git-owner@vger.kernel.org Tue Mar 26 18:20:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKXY9-0003VT-Rm
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 18:20:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692Ab3CZRUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 13:20:11 -0400
Received: from mail-qc0-f176.google.com ([209.85.216.176]:61320 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683Ab3CZRUK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 13:20:10 -0400
Received: by mail-qc0-f176.google.com with SMTP id n41so3202960qco.21
        for <git@vger.kernel.org>; Tue, 26 Mar 2013 10:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=B+A2iCDhadpOZu/TbBWqUciJYN/DcbZb3NG5TPUOZK8=;
        b=sHQbfp70sTsHjZ0mbEqTHaVSSajJYckjyZhepyMnOg43lZd6HgmVGRbNr9Q16VvDfH
         KCdtwudrpXEozxf80E6AoCwMh6CZTt6cpJxd96oSeUNxEWUMkhOiVMuN5LaTEYk+0ysC
         ftI2wgt1A+MWp1b5GIStHZYmhdjnVTs2O3DvCAMvYvpEXrOEpz6vu5A9ZAEiBhSAzAiA
         GqZ33DydHLFXNtpO4Az5nWxNrEU1iX4Lp9Ed9UvVxQRXS8L+sEV+RnJX393JundxNmfU
         12QVyqteq41wipUJ1W7oBcvI7F0QzfWt007ay40obxlyt09lPeznoFrjTER3KG1mcAKn
         4GXg==
X-Received: by 10.229.76.37 with SMTP id a37mr2875641qck.130.1364318409252;
 Tue, 26 Mar 2013 10:20:09 -0700 (PDT)
Received: by 10.49.6.103 with HTTP; Tue, 26 Mar 2013 10:20:09 -0700 (PDT)
In-Reply-To: <5151D589.2000002@nod.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219172>

On 26 March 2013 18:06, Richard Weinberger <richard@nod.at> wrote:
> P.s: I've told this story to some friends and co-workers which use git like
> me very day.
> All of them were shocked about the behavior of git-clean and GIT_DIR.

Seconded. At $work lots of people started asking anxious questions
about this. It was suggested it is a potential security hole, although
I am not sure I agree, but the general idea being that if you could
manage to set this var in someones environment then they might use git
to do real damage to a system. (The counterargument being that if you
can set that in someones environment you can do worse already... But
im a not a security type so I cant say)

As a knee-jerk response we will be armoring various scripts we have
that use git automatically to refuse to run if GIT_DIR is set. I
suspect a lot of people will be doing the same.

cheers,
Yves



-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
