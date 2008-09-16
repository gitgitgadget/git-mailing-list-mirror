From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Re: Management of opendocument (openoffice.org) files in git
Date: Tue, 16 Sep 2008 09:41:38 +0200
Message-ID: <48CF6332.3020803@gmail.com>
References: <loom.20080915T222909-709@post.gmane.org> <vpqwshctwr7.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Tue Sep 16 09:43:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfVDT-0005dO-Ch
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 09:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585AbYIPHmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 03:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752486AbYIPHmL
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 03:42:11 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:14024 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399AbYIPHmK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 03:42:10 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2560829rvb.1
        for <git@vger.kernel.org>; Tue, 16 Sep 2008 00:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=QGQ9/KLc1Ox56M8QuGGqtn56LdS1/oq8mlBlN4TBWlg=;
        b=OHf8ImNU4wof/BPnN+XKr+4SzfiJT+3LCeFXnZ0myK4/4trwWm0hqgIQ0U8iIj5pT5
         s4SLynVpM+69VYIi9tyCOEZFhl/6xi3Mf24H5erW0vaBE/rBTgss5A96QSOO/ENN3ujM
         In+TJXHTOvaQMyl6zjvpknKhUCo06OCqVFDH0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        b=DyOdrgc2rzPcuYCA5Ohc1i/FBacAuoWlzNmSD4B+PtX95o2y3LAYpIvRfJC5f2gM3w
         6+YUSIZwdROf1+bmmD5Z03HXNmpFjjpjlTSgHPR2foss0oPO6GvUoFSFJ0s7imv5+WoI
         8cU0QC5+HGi35CHjsLqSIDniTwkPIKm5ZtL+Q=
Received: by 10.115.106.7 with SMTP id i7mr460939wam.131.1221550929791;
        Tue, 16 Sep 2008 00:42:09 -0700 (PDT)
Received: from ?192.168.1.103? ( [71.197.224.64])
        by mx.google.com with ESMTPS id m26sm31055340pof.1.2008.09.16.00.41.38
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 16 Sep 2008 00:42:08 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <vpqwshctwr7.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95986>

Matthieu Moy wrote:
> Sergio Callegari <sergio.callegari@gmail.com> writes:
>
>   
>> Hi,
>>
>> Management of opendocument files in git has been discussed a short time ago.
>> Here is an helper script that may help achieving better density in git packs
>> containg blobs from openoffice files.
>>     
>
> If you don't get "oh, sh*t, I lost data with it"-kind of feedback, can
> you add it to the wiki:
>
> http://git.or.cz/gitwiki/GitTips#head-1cdd4ab777e74f12d1ffa7f0a793e46dd06e5945
>
> Thanks,
>
>   
Sure.  I'll wait a few days for feedback (also from myself), then I'll
add it there.
I've already got a couple of corrections and suggestions from Paolo.
Would it be useful also to add a note about how to filter-branches with
a plain "--tree-filter true" to convert archives so that they take
advantage of storing ODF stuff uncompressed?
If proper, I can add that too.


Sergio
