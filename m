From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: [PATCH] Teach git diff about Objective-C syntax
Date: Wed, 17 Sep 2008 14:37:34 +0100
Message-ID: <57518fd10809170637n585afacbs94fdddc5b8bb61b6@mail.gmail.com>
References: <1221610063-33610-1-git-send-email-jon.delStrother@bestbefore.tv>
	 <1221648564-56239-1-git-send-email-jon.delStrother@bestbefore.tv>
	 <alpine.DEB.1.00.0809171205430.14329@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, vmiklos@frugalware.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 17 15:38:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfxF0-0004Qn-Vl
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 15:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319AbYIQNhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 09:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbYIQNhg
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 09:37:36 -0400
Received: from el-out-1112.google.com ([209.85.162.176]:64924 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbYIQNhg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 09:37:36 -0400
Received: by el-out-1112.google.com with SMTP id z25so1256859ele.1
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 06:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=IqIqUa23i2gV8bN7xEKeVBYUJtS+wca+rvBjipL1kK0=;
        b=f1wENaGhk+h+KN2sx+FY8ZpQd+YjsIqZmXoi/GxaedgAHkiEX5GrLBGigCT7DKgBbw
         jrgec1anNnO0Azt8sNb1vxNu8snf7rWEZsnupN4Jb4qSFd2XU7+6JdYs8iEj8Js4Kgsg
         HUzhYKm96pu9Yz8zFHzhYpW1oxb/+s8Op6SXA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=WAaOOH8KQZt7ntcjkGoEBsskwp55/InYZ8eK1X0L51wgiOA7EHqO27/v0vpXAt4jtG
         JaXFQYskN3yXlkXwyeADRt7EalyFRVyVO6FIYwydGeYPF67mGrgKcJDg2lIGTVuMnGH0
         KmUDxK8KbN/n6/anqpzpmByRGVSYyBuBMslFw=
Received: by 10.142.141.21 with SMTP id o21mr854363wfd.213.1221658654345;
        Wed, 17 Sep 2008 06:37:34 -0700 (PDT)
Received: by 10.143.6.3 with HTTP; Wed, 17 Sep 2008 06:37:34 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0809171205430.14329@racer>
Content-Disposition: inline
X-Google-Sender-Auth: 7f8dc6c8c46a29c8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96112>

On Wed, Sep 17, 2008 at 12:06 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 17 Sep 2008, Jonathan del Strother wrote:
>
>> -                     "^[     ]*\\(\\([       ]*"
>> +                     "^[ \t]*\\(\\([ \t]*"
>
> Why?

Sorry - missed that in the original reply.  You really prefer having
an invisible tab character to an explicit \t ?
