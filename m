From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] Add git-submodule command
Date: Sat, 26 May 2007 16:48:02 +0200
Message-ID: <8c5c35580705260748k635c5893w66c735dfce9c2af0@mail.gmail.com>
References: <7v1wh4ped4.fsf@assigned-by-dhcp.cox.net>
	 <11801878003599-git-send-email-hjemli@gmail.com>
	 <200705261638.00302.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Simon Hausmann" <simon@lst.de>
X-From: git-owner@vger.kernel.org Sat May 26 16:48:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrxYw-0000vP-DU
	for gcvg-git@gmane.org; Sat, 26 May 2007 16:48:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756402AbXEZOsG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 10:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756854AbXEZOsG
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 10:48:06 -0400
Received: from nz-out-0506.google.com ([64.233.162.235]:47693 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756402AbXEZOsF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 10:48:05 -0400
Received: by nz-out-0506.google.com with SMTP id n1so567542nzf
        for <git@vger.kernel.org>; Sat, 26 May 2007 07:48:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eDtNzkUENDLK3WlgBpKSEHzA0ilx79V7hXJ7q2CfQCha6dqD3xc+gQ4W56IDyYquI4fyuYSy7/nZuHCSDXpmEA1H9U3bVDpimXYnH6JrXQYCdlI3aSwzKCROoTTHkI0le0Hwf0ZjltoFdD0OUF/PtT5nrR/UzBEH3H8h0sD6yTk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b3dKhhI+H9bPdNAP39EmZXTFWRCM7mu0ulzkuxdB+mS+hkv0LbpxEdz8vCsJLXAgTR8MBeieRxdHG7klFpvRKn4dGjXrSHY2mjuvdSinlbtmHVnxdEHUCdCXINNNPh7+BRAo80TsfnmYw6Th+q2eV7vjVyRlpZkr6er4mTqFLkM=
Received: by 10.115.23.12 with SMTP id a12mr1956026waj.1180190882930;
        Sat, 26 May 2007 07:48:02 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Sat, 26 May 2007 07:48:02 -0700 (PDT)
In-Reply-To: <200705261638.00302.simon@lst.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48474>

On 5/26/07, Simon Hausmann <simon@lst.de> wrote:
> On Saturday 26 May 2007 15:56:40 Lars Hjemli wrote:
> > +             test -e "$path"
> > +             die "A file already exist at path '$path'"
>
> Isn't there a && missing at the end of the test line? :)
>

Hmph. There's always something slipping through, thanks for noticing.
I will make the testscript now....

-- 
larsh
