From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Documentation for git gui blame
Date: Tue, 12 Oct 2010 09:27:11 -0700
Message-ID: <4CB48C5F.2030007@gmail.com>
References: <4CB48909.6050708@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Tue Oct 12 18:27:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5hh4-0003SS-Hv
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 18:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757814Ab0JLQ0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 12:26:52 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:51835 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757732Ab0JLQ0v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 12:26:51 -0400
Received: by pxi16 with SMTP id 16so575038pxi.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 09:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=pTnwVM8PRiJN6Mj0Y3gOBzCkTVd4Hy/zUnQVcAW/ej8=;
        b=N1ySg4Oxix/li7KMNEU6GbgXesE/jyMUlwvd2vJIzmMdEZRxjSpbAEwY/TuwKlfO4T
         3R3O5PCQDIZr/c2FPmX4X1ySs6W+QzC2F/C3lEJ774NfmTZumnxscdmA5+HeDW9vglGB
         MHZRhFiofpECSV8G5epHUp48v+qh06Sq3F/SU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=IfvyrygFN3g8EIShPhZRZmKKI9SXLfsDpJ3HZ40LNMSfbfMN9rleaYr5hrN3ENjIAr
         22GZBQBoLpAJgqOnVrufeflfbzKwpDZHmIH79BG6hH9pCuMNjDmQPl91psasKIhVaE2k
         A5cm25PjLN/Q8DYPVFV/Fn/7aktRfYzqKGhc4=
Received: by 10.114.38.1 with SMTP id l1mr8824026wal.86.1286900807579;
        Tue, 12 Oct 2010 09:26:47 -0700 (PDT)
Received: from laptop.site (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id p4sm10159451wal.15.2010.10.12.09.26.45
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 12 Oct 2010 09:26:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.12) Gecko/20100914 SUSE/3.0.8 Thunderbird/3.0.8
In-Reply-To: <4CB48909.6050708@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158859>

On 12/10/10 09:12, Joshua Jensen wrote:
>  Is there any documentation for git gui blame 

Not sure but it's displaying the same info as git blame so start with
man git-blame. That probably covers most of what you want to know

> that explains what the two left columns containing 4 letter SHAs are?

These are the first 4 characters of the commit id that last
added/changed that line of code. Basically the standard abbreviated 8
character SHA1 would take up too much screen real estate. You can still
use a 4 character SHA as long as there aren't any commits in your tree
that start with the same 4 characters (the possibility of collisions
exists with 8 character ones too, it's just less likely).

> 
> What does "Blame Parent Commit" mean?
> 

It means that you have decided that the commit that it currently has
selected is not interesting and you want to see the previous commit that
modified that section (e.g. it was just some formatting change and you
want the commit that actually added the code in question).

> Thanks!
> 
> Josh
> -- 
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
