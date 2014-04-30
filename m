From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] MSVC: link dynamically to the CRT
Date: Wed, 30 Apr 2014 21:37:12 +0200
Message-ID: <536150E8.20809@gmail.com>
References: <20140429102509.GA16706@camelia.ucw.cz> <xmqqa9b2fyve.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marat Radchenko <marat@slonopotamus.org>
To: Junio C Hamano <gitster@pobox.com>, Stepan Kasal <kasal@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Apr 30 21:37:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfaJs-0003y9-39
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 21:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933877AbaD3ThY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 15:37:24 -0400
Received: from mail-ee0-f45.google.com ([74.125.83.45]:57705 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932186AbaD3ThX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 15:37:23 -0400
Received: by mail-ee0-f45.google.com with SMTP id d17so1693771eek.18
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 12:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Gi+51kPFcYl7GLruZS67u+hUntfhwnZavi65ovhJ7EA=;
        b=AxPY78X2aWth+5pUBmx+3ZgZSVafDdJrALa+9cVl+fTKPjsG+tNnvSNEVcxmEMcq/Z
         Vz4N1yI1b3TdBudGPsJpVHBwb7emJStEx4AF1EZqvIEdWG4zSvbMridpOqTlyexdudCy
         bU1wXiFSTDskeI4xH3ysxin+D7lEjPX/c1QYiDFtutKPUNjBGS8dwbasgj+Xj7K7dCLL
         AkcvQZMk3eYiMPcJMdWgmPvqGBDRrNKwd5+IUsSTeg7czp6uNOP3BsSFDaijDXyGMbLq
         7xiA7MeBElanwMkfD2kzY1yyC7Zv9rj/glY46/nOPHAZkcv06pv7bWP+wxpJCpJk3tnV
         wGQA==
X-Received: by 10.15.24.201 with SMTP id j49mr5956099eeu.99.1398886642207;
        Wed, 30 Apr 2014 12:37:22 -0700 (PDT)
Received: from [192.168.188.20] (p5B156CCE.dip0.t-ipconnect.de. [91.21.108.206])
        by mx.google.com with ESMTPSA id q41sm70278143eez.7.2014.04.30.12.37.20
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 30 Apr 2014 12:37:21 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <xmqqa9b2fyve.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247762>

On 30.04.2014 20:36, Junio C Hamano wrote:

> I am not intimate with the msysgit developer community, and I do not
> know if it is appropriate for me to respond with a
>
> 	Does this look OK with msysgit folks?

This patch has been carried in the msysgit tree since more than 3 years, 
although strictly speaking it does not affect the msysgit build but only 
the MSVC build. Stefan is just bringing Karsten's patch upstream with 
this patch.

So yes, this is fine.

> cc'ed to the usual suspects (Erik Faye-Lund, Dscho and J6t).  Just
> like I do not have to ask "does this look ok?" question when seeing
> a patch from Erik or J6t, is it unnecessary for me to do so for a
> patch from you?

I'm putting Marat in CC who has been recently active in building Git 
with MSVC.

-- 
Sebastian Schuberth
