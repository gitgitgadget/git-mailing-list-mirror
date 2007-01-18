From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH - todo] Changes to e-mailed patch handling in v1.5.0
Date: Thu, 18 Jan 2007 08:18:08 +0000
Message-ID: <200701180818.12372.andyparkins@gmail.com>
References: <7vk5zlqqum.fsf@assigned-by-dhcp.cox.net> <7vwt3lp97c.fsf_-_@assigned-by-dhcp.cox.net> <7vhcupp81v.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jan 18 09:18:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7STW-00010m-BO
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 09:18:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbXARIST (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 03:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751950AbXARIST
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 03:18:19 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:62150 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874AbXARISS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 03:18:18 -0500
Received: by ug-out-1314.google.com with SMTP id 44so113747uga
        for <git@vger.kernel.org>; Thu, 18 Jan 2007 00:18:17 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=smZILe/zi4h59z9V/mvEyTyHgf9nUvU1/g2JYDTwsxZnUrkqDusdFUwqE402rVy+lIjKo1mHhPneSsb3W4AHQJgZ0mbVjIMvIFZ9zRpEEHagE+BNrAU1gZyc7q0ONTNKLrNLHhnYWNNFWOWw4arhIx5HMNNsGYxT1mw5FjULWaY=
Received: by 10.67.19.20 with SMTP id w20mr881157ugi.1169108297185;
        Thu, 18 Jan 2007 00:18:17 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id j34sm500006ugc.2007.01.18.00.18.15;
        Thu, 18 Jan 2007 00:18:15 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <7vhcupp81v.fsf_-_@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37066>

On Wednesday 2007 January 17 23:06, Junio C Hamano wrote:

> I am neutral about changing the default suffix from .txt to .patch;
> comments?

I'm in favour.  The extension indicates file type, and gives guidance on the 
tool that can read it. Though .patch is stored in text it's more than that 
(c.f. .html) - the text inside it has meaning beyond just the text.

To me, .txt would implies that the file format is in human-language format 
(i.e. words, sentences, and paragraphs).


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
