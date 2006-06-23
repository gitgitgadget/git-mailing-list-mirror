From: "=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?=" 
	<pclouds@gmail.com>
Subject: Re: [PATCH] Introduce Git.pm (v3)
Date: Fri, 23 Jun 2006 13:34:17 +0700
Message-ID: <fcaeb9bf0606222334x59a76a65l52564a34858d98d4@mail.gmail.com>
References: <20060622220201.19132.67536.stgit@machine.or.cz>
	 <7vlkrohj9p.fsf@assigned-by-dhcp.cox.net>
	 <20060622235017.GH21864@pasky.or.cz>
	 <7v1wtghga6.fsf@assigned-by-dhcp.cox.net>
	 <20060623011205.GJ21864@pasky.or.cz>
	 <7vk678fpqy.fsf@assigned-by-dhcp.cox.net> <e7g079$8qt$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 23 08:34:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtfFG-0000Pr-30
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 08:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932881AbWFWGeT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 02:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932882AbWFWGeT
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 02:34:19 -0400
Received: from wx-out-0102.google.com ([66.249.82.192]:734 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932881AbWFWGeS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 02:34:18 -0400
Received: by wx-out-0102.google.com with SMTP id s17so407093wxc
        for <git@vger.kernel.org>; Thu, 22 Jun 2006 23:34:17 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kccStga5Y6sRQ0B5r9WnMYz/MBaU6qrGVPkDw52rFnH1TgAVbeFVHEdOqMgGYM2XpFtjYUrAKhq12JHBAh1T6SgPpwuUebKsOUFA6Ae9P6xQq7oQH5EniRHWCPv432iSblu/2aCwK4IOaAWAWLxOt5eWeXhPi8UyGhAh6atYsVM=
Received: by 10.70.63.2 with SMTP id l2mr4168861wxa;
        Thu, 22 Jun 2006 23:34:17 -0700 (PDT)
Received: by 10.70.45.11 with HTTP; Thu, 22 Jun 2006 23:34:17 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <e7g079$8qt$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22400>

On 6/23/06, Jakub Narebski <jnareb@gmail.com> wrote:
> Perhaps Git.pm should provide also generic, pure Perl (and slower)
> fallback implementation (when for some reason we cannot compile XS).
Haven't looked at Git.pm. But I have written receive-pack in perl. It
may have some useful functions for Git.pm
