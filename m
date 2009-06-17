From: JiHO <jo.lists@gmail.com>
Subject: Re: Issues with file status over samba
Date: Wed, 17 Jun 2009 16:58:17 -0400
Message-ID: <35827F07-E0F2-40BD-B954-7E24CE24D004@gmail.com>
References: <3A1A5212-FFB4-4B0D-A972-C90EA336F5D9@gmail.com> <3dfcd29f-a1cd-4007-b962-2cf5156ab708@g19g2000yql.googlegroups.com> <46a038f90906171345n5a248d1bl253bc49baa819cd8@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 22:58:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MH2DF-0007zu-8o
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 22:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752235AbZFQU6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 16:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbZFQU6S
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 16:58:18 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:18327 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121AbZFQU6R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 16:58:17 -0400
Received: by an-out-0708.google.com with SMTP id d40so952601and.1
        for <git@vger.kernel.org>; Wed, 17 Jun 2009 13:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=za/Q0QcRbSa3PjxUZ48Ng3b/bjZLPh37/D4AxJzhM4I=;
        b=UNTJD/Vt+5+cYxcYvwa0xZ07Zpwra4tWkGcwwfafSuF0zivxWCQY1bV8FyU7m3aT79
         fA0Orbd6zIPsUfOvBfGVcWngbTYsvbx8fKB+wUkvLpWuKereD8mn4od4LbiDZ35XCaIY
         Pl28UigYXTt6sL4dOxli1jqme/v1ZPtv0LGGY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=fw9OEKS4NJiyev9B3oz9OKh2ygF5Q4peRlEUrxaeonnQJ4mHS/BfAM5k6h5tqGFFRJ
         uvGJ9NDy/8bOvhIfDi03hn3R1TTyXlN31/upftDYLaIkvZxQp5jNwhhjKRmxk1wCkl0F
         kC52lgBU0HZetowO8E49oOuxJZzhzxvcIYqH0=
Received: by 10.100.211.11 with SMTP id j11mr866821ang.101.1245272299229;
        Wed, 17 Jun 2009 13:58:19 -0700 (PDT)
Received: from irisson.rsmas.miami.edu (irisson.rsmas.miami.edu [129.171.100.9])
        by mx.google.com with ESMTPS id 9sm358723yws.10.2009.06.17.13.58.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Jun 2009 13:58:18 -0700 (PDT)
In-Reply-To: <46a038f90906171345n5a248d1bl253bc49baa819cd8@mail.gmail.com>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121774>

On 2009-June-17  , at 16:45 , Martin Langhoff wrote:
> On Wed, Jun 17, 2009 at 8:51 PM, jiho<jo.lists@gmail.com> wrote:
>> This is not an issue of clock differences betweent eh two computer
>> because setting the time on the server to -1h does not help.
>
> How about having ntp running on both?

It does already (the server is Ubuntu Linux running ntp, my machine is  
a MacBook synchronizing with Apple's time servers). I was worried  
about second to split second differences that might occur when the  
machines drift away from the reference. Plus samba sometimes messes up  
the times because of its 2-seconds round off setting (search for "dos  
filetime resolution" there: http://samba.org/samba/docs/man/manpages-3/smb.conf.5.html 
  )

JiHO
---
http://maururu.net
