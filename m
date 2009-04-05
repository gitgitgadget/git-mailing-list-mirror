From: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Sun, 5 Apr 2009 02:05:36 +0200
Message-ID: <20090405000536.GA12927@vidovic>
References: <20090404220743.GA869@curie-int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Sun Apr 05 02:07:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqFtk-0006db-LA
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 02:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754911AbZDEAFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 20:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754454AbZDEAFp
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 20:05:45 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:34477 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754002AbZDEAFo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 20:05:44 -0400
Received: by ewy9 with SMTP id 9so1443375ewy.37
        for <git@vger.kernel.org>; Sat, 04 Apr 2009 17:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=YLgPYqk0nfakVeezvX4HRFPU9rDlxGuFeQweRiaTMwQ=;
        b=OGUyopedcUABrL316CJCN3Dzaw2tHBXPFLgIU+kkF0kKIMVErnDtIjwbIXL8WPJIsd
         lc9g8+R55MtU/cG0PZVM9ptxaZWs3BWYGFID69b2WJhLyWRDyD0VBmNq/mIhsWRCqe0N
         oB5MmxaTE8quHNkZj7DhOOTFaey+4C9O+N7VM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=tO3k2VYf43F8RJxK2gpBqENsgaKwEWS9t5FTFlSGdGIoSnu+lBNmxC6JIs0ve223Su
         Nd3GcK/7Jt7OZZYNkULWl455OT+TShQw62oTfHEHDWnWytpd3uKfAEjI3M5R+0l77gu8
         bTJqJh4vTDvWjemKU/ULQN+FtaY4vNETZ1NK4=
Received: by 10.210.40.10 with SMTP id n10mr2105093ebn.71.1238889941790;
        Sat, 04 Apr 2009 17:05:41 -0700 (PDT)
Received: from @ (ABordeaux-258-1-82-86.w86-201.abo.wanadoo.fr [86.201.73.86])
        by mx.google.com with ESMTPS id 23sm4827218eya.36.2009.04.04.17.05.39
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Apr 2009 17:05:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090404220743.GA869@curie-int>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115608>

On Sat, Apr 04, 2009 at 03:07:43PM -0700, Robin H. Johnson wrote:

> Our full repository conversion is large, even after tuning the
> repacking, the packed repository is between 1.4 and 1.6GiB. As of Feburary
> 4th, 2009, it contained 4886949 objects. It is not suitable for
> splitting into submodules either unfortunately - we have a lot of
> directory moves that would cause submodule bloat.

Actually, I'm not sure that a full portage tree repository would be the
best thing to do. It would not be suitable in the long term and working
on the repository/history would be a big mess. Why provide a such repo ?
Or at least, why provide a such readable repo ?

IMHO, you should provide a repository per upstream package on the main
server.


PS: what about cc'ing gentoo-scm list ?

-- 
Nicolas Sebrecht
