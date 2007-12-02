From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: make test failure with latest master
Date: Sun, 02 Dec 2007 09:01:35 -0500
Message-ID: <4752BABF.1040707@gmail.com>
References: <4752A53E.4030000@gmail.com> <m3fxylw95y.fsf@roke.D-201>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 15:02:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IypOR-00040x-9l
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 15:01:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753692AbXLBOBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 09:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753994AbXLBOBj
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 09:01:39 -0500
Received: from wr-out-0506.google.com ([64.233.184.226]:43042 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048AbXLBOBi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 09:01:38 -0500
Received: by wr-out-0506.google.com with SMTP id c49so2436895wra
        for <git@vger.kernel.org>; Sun, 02 Dec 2007 06:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=A3wAesQu8dieLKEF8kdup7JihP4SK+LNkPU1skq/EdY=;
        b=Y+HRN1YDTPL9rf/FdgK+Y7dgw134+3RG8o2A02lk8bBob38FRGnhhlZdUadLKytsM9lRoijM3y1RxuI1cXd8hXAc+/1HiRcmHZItSI83KjX50DAVMs6hYx25KGn4ZMenoQ/VsMDyWXR8yqf82UuYr3CglAl/AdKEXXaSLdw+W8U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=C6B26ebC7e5ruiY075u132/xAOb/jfLs1cj8X3fE7wZeIWWwYpVfSSu1Ntsz0T/MmMnBZmVXIlLQT5Xf74KTLhOxvs05JLl6+BNMtb3Bt6LMls50NGj+INCEK6RqSP3VGsyN8o3btJDc7afR1lOW/0ismzPZ6Cvqq4JzG2Cde3Y=
Received: by 10.70.91.16 with SMTP id o16mr1612999wxb.1196604097357;
        Sun, 02 Dec 2007 06:01:37 -0800 (PST)
Received: from ?10.0.0.6? ( [66.177.19.100])
        by mx.google.com with ESMTPS id h9sm14637716wxd.2007.12.02.06.01.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 02 Dec 2007 06:01:36 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <m3fxylw95y.fsf@roke.D-201>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66778>

Jakub Narebski wrote:
> A Large Angry SCM <gitzilla@gmail.com> writes:
> 
>> [Resent due to incorrect list address.]
>>
>> With the latest master, 2221a6757161af1905925c405aded9ff470f70d5,
>> "make test" now fails; last successful "make test" was mid-week
>> sometime with master d25430. This is on a laptop running Suse 9.3.
>>
>>
>> *** t9600-cvsimport.sh ***
> 
> Trivial question: have you got cvs and cvsps installed?
> 

Yes. With the following (rpm based) versions:

	cvs-1.12.12-2.1
	cvsps-1.99-155.2
	cvsup-16.1h-173
	viewcvs-1.0-11
