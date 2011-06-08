From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: New CIA.vc script
Date: Wed, 8 Jun 2011 18:50:21 +0530
Message-ID: <BANLkTi=PiAa7-OoW6UtTqidk8ut0P8ewyw@mail.gmail.com>
References: <BANLkTi=_nXGOcqC1PMLFJfgkdx8HbsweEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: JD Horelick <jdhore1@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 15:20:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUIgi-0001qT-J1
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 15:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754928Ab1FHNUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 09:20:43 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34190 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754573Ab1FHNUn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 09:20:43 -0400
Received: by wya21 with SMTP id 21so347781wya.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 06:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=5NfG2Tpw4V2BqaKN1TcejmjE0bHhRUfMTBJjY5OwdT8=;
        b=Aan1OmQIHu1xHzW2H5hqWgGMtEaP9RuNCSQfO6mYrIzEcEj1SlMRKgWgKIQlbyBAwB
         wAqpu7jBZpsploGM6m18X3kc0JBwr24wEm1Omv9K/opa1EDS2HfsmYTcb9obG67JnDYr
         M5rvkV93vqQXcQjWSlPgL1cvNYZZMd+YkMR8E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=wERQTIetN2RZ4iD7E5G8L1j0dvfCRH2I9cfR0uoF3tykNFT1jOFF56b+DcXZ1uJyOu
         LP4mWFMgjmqGHTbRPWvcyFcMmq+Zs2dP0vlKnlYSFdBu1Ra27zugRXgTkghddp81N2eh
         HlZicLyOED+aZsEVPSJvjjAEAVk4CoWJn1h34=
Received: by 10.216.28.200 with SMTP id g50mr55048wea.92.1307539241164; Wed,
 08 Jun 2011 06:20:41 -0700 (PDT)
Received: by 10.216.51.213 with HTTP; Wed, 8 Jun 2011 06:20:21 -0700 (PDT)
In-Reply-To: <BANLkTi=_nXGOcqC1PMLFJfgkdx8HbsweEg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175370>

Hi,

JD Horelick writes:
> I'm attaching the new ciabot.pl inline here:
[...]

> I welcome any constructive criticism and I hope to see this in
> contrib/ciabot soon. :)

Thanks.  I haven't read the patch yet, but you must read
Documentation/SubmittingPatches if this is to be considered for
inclusion.  The key points are: commit this script to the appropriate
place, include a signoff in the commit message, and use `git
format-patch` to generate an email to send to the list.

-- Ram
