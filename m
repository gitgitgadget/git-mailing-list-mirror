From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [RFD] gitweb configuration
Date: Sun, 18 Jun 2006 22:13:45 +1200
Message-ID: <46a038f90606180313x17ddc6dcpfd9484665468f042@mail.gmail.com>
References: <e720r0$qdv$1@sea.gmane.org> <20060617232358.GK2609@pasky.or.cz>
	 <e72j53$1m1$1@sea.gmane.org>
	 <46a038f90606180042w7b4d11dbvbea28b750ddbc6e2@mail.gmail.com>
	 <e731ai$su1$1@sea.gmane.org>
	 <20060618113052.660e1017.tihirvon@gmail.com>
	 <e735d7$6dq$1@sea.gmane.org> <7v8xnu3iol.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org,
	"Timo Hirvonen" <tihirvon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 18 12:13:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FruHu-0002kQ-8E
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 12:13:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbWFRKNr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 06:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbWFRKNr
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 06:13:47 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:7432 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750906AbWFRKNq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jun 2006 06:13:46 -0400
Received: by ug-out-1314.google.com with SMTP id a2so1429839ugf
        for <git@vger.kernel.org>; Sun, 18 Jun 2006 03:13:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dsiwAubHvnupHmIwyfiU99p7hu7cfB6+juqk5Q5HU+vTE+tLvg/FK+UyLShD5bmuR5KnV6wpfgIv7+5MpXLD9GRHfKRlcl4qgISYbpqs3JeBDBweWkejmo6M49ZI5tXpiYHYztbCZgnOc6TVMPhJqpv82SZPCI+tf7yBNzj57b8=
Received: by 10.78.51.16 with SMTP id y16mr1601834huy;
        Sun, 18 Jun 2006 03:13:45 -0700 (PDT)
Received: by 10.78.128.15 with HTTP; Sun, 18 Jun 2006 03:13:45 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v8xnu3iol.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22068>

On 6/18/06, Junio C Hamano <junkio@cox.net> wrote:
> My gut feeling is that it is sensible to assume git is on
> everybody's path -- after all the site is running gitweb and
> majority would be using binary packaged distribution, so git
> would be installed somewhere sensible and accessible.

+1. In the case of binary packages, the maintainer/packager can drop a
config file in /etc/apache/conf.d , so it's unlikely that munging
actually needs to happen.

cheers,


martin
