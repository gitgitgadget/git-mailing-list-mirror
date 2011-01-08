From: Rich Eakin <reakinator@gmail.com>
Subject: Re: different name and email address depending on folder
Date: Sat, 8 Jan 2011 19:16:20 +1100
Message-ID: <A1770B45-1A98-49C3-8CD0-C61A51FFB66E@gmail.com>
References: <3178E076-FA22-4C3C-BEB2-2581A0E12086@gmail.com> <20110108073928.GD27334@kytes>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 08 09:20:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbU2i-0007Tq-77
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 09:20:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066Ab1AHIQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jan 2011 03:16:29 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60609 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936Ab1AHIQ2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Jan 2011 03:16:28 -0500
Received: by pwj3 with SMTP id 3so2445879pwj.19
        for <git@vger.kernel.org>; Sat, 08 Jan 2011 00:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:content-type:mime-version
         :subject:from:in-reply-to:date:content-transfer-encoding:message-id
         :references:to:x-mailer;
        bh=u1GaYtAtjH0RofLsJyd2LyGE2OhrIO4vhcV51XaIDXs=;
        b=lFxyH8kCAWUvMdk4nV4j/FAySIWb5dCFpdMHPRSJEpkaryxY9QxLA9L6qt0+PzuhBm
         Dq+7olTQ8pL9Jbn67L4BTHdpkQ2kbA1FPJdgLgVHO4XYlqSG9wQ0SErIJGfqrBq5/TH2
         oZbzmf3N2SndmUIJQkZY6h1wE/D48SaHCAzFw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=content-type:mime-version:subject:from:in-reply-to:date
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=rlFUMMg26y3iGdTYTVahXpZPdOroFT58ZafTCxSL5OVZFRbK/INxxBTgRmPVLYYXeN
         Iw4j+NPPFxXllGe1r8MRcpGvrGb3TUbsj/affeZTDG7BVz5SqX0SYJB+FAQ1WkyhaXQq
         6MBfWxrm/vqNLHqH7hqLISd/6xnpoq0m1V0xw=
Received: by 10.142.139.3 with SMTP id m3mr2421072wfd.16.1294474587703;
        Sat, 08 Jan 2011 00:16:27 -0800 (PST)
Received: from [10.1.1.11] (d110-33-100-19.mas800.nsw.optusnet.com.au [110.33.100.19])
        by mx.google.com with ESMTPS id p8sm3888656wff.4.2011.01.08.00.16.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 Jan 2011 00:16:25 -0800 (PST)
In-Reply-To: <20110108073928.GD27334@kytes>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164810>

I am currently using git-config in a bash script to set my user / email.  I was wondering if it was possible to tell git that if I am in a certain directory to use a specific user / email other than what is in my global config.  


On 08/01/2011, at 6:39 PM, Ramkumar Ramachandra wrote:

> Hi Rich,
> 
> Rich Eakin writes:
>> I am using git for development with a company and myself on the same computer and the name / user fields need to be different for each.  As I keep all my company's repos in one directory and my private stuff in another, I was wondering if there is a way to tell git to use a separate user and email whenever I make commits from within a specified directory.  
> 
> Yes. Please see the 'user.name' and 'user.email' configuration options
> in git-config(1). You can set them globally or on a per-repository
> basis.
> 
> -- Ram
