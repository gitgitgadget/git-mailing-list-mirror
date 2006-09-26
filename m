From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 5/5] gitweb: Quote filename in HTTP Content-Disposition: header
Date: Tue, 26 Sep 2006 09:51:31 +0200
Message-ID: <200609260951.31806.jnareb@gmail.com>
References: <200609260153.08503.jnareb@gmail.com> <200609260159.43684.jnareb@gmail.com> <7v7izrw9la.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 26 09:51:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GS7j6-0001Xf-0J
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 09:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWIZHvd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 03:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWIZHvd
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 03:51:33 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:42303 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750758AbWIZHvc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 03:51:32 -0400
Received: by ug-out-1314.google.com with SMTP id o38so566345ugd
        for <git@vger.kernel.org>; Tue, 26 Sep 2006 00:51:31 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mjnYvHTjYzZdy+RmoXVc7Z17D4R1oaUUt11e3dDicUU/NJzG/lCZgZzHHFx2UjoJVihmIfJ8uxnM/8Y0XecEObfRO59mZctqn9Cc/L1ynnE6NmMbwnFQK0ifw0wyl+bVuhpL68EdFyBXyT9gFm7wt8zYCeTtjTIzGzROCA+kY4c=
Received: by 10.66.221.19 with SMTP id t19mr419272ugg;
        Tue, 26 Sep 2006 00:51:31 -0700 (PDT)
Received: from host-81-190-26-109.torun.mm.pl ( [81.190.26.109])
        by mx.gmail.com with ESMTP id b23sm2888656ugd.2006.09.26.00.51.30;
        Tue, 26 Sep 2006 00:51:30 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7v7izrw9la.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27782>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Finish work started by a2f3db2f5de2a3667b0e038aa65e3e097e642e7d commit
>> (although not documented in commit message) of quoting using quotemeta
>> the filename in HTTP -content_disposition header.  Uniquify output.
>>
>> Just in case filename contains end of line character.
> 
> What do you mean by "uniquify output"?

It means alsways use 'inline; filename="' . (quotemeta <whatever>) . '"',
and not sometimes qq(...), sometimes "...\"...\"", and sometimes '...'.

-- 
Jakub Narebski
Poland
