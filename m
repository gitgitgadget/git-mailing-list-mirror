From: Sultan Shakir <sshakirflhosp@gmail.com>
Subject: Can Git work for us if we are remotely hosted?
Date: Wed, 11 Aug 2010 18:51:14 -0400
Message-ID: <AANLkTin4JyZhmjm_1c4q7kjP0eXzA-_2eNsLzsnGASet@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 12 00:51:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjK90-0002BL-Ik
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 00:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755583Ab0HKWva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 18:51:30 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:63429 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754786Ab0HKWvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 18:51:25 -0400
Received: by qyk7 with SMTP id 7so5238458qyk.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 15:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=FMptRe8oATeZcgRFtgD4O5iQ0DRfHhcO42ALkxUXb0Q=;
        b=yDHf25xNb12r0doHHQeZr/KS13PdpAvqaUT16bzrMhFaojOn8HJPO7kIwROKCqJbBQ
         5St/frWOH9gX1OOUOYe8U1LuzlIyBtIxzIV4V94WlAL3SLAEMMol7OpBohlN0Zg8eNST
         n3u3zr1V8TZhOj6vgS0tyAzeARSUUkjSgvJOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=cpIJMTt0eky0JQJHT0s/J+RZeb/U2RbTU9zlwajQ4LE7K6eVyrAkI8vZ9xx6jQpau6
         b1YVk7+3ztRDPemk8bqoAfwCKEHfijQoy/Q6z6tqfHC5ARPIzAXruwH8Nihw3i5hWDoJ
         ZxxL8lile8hvKHvwkNdsStysza+GyeIZucJ+I=
Received: by 10.229.186.137 with SMTP id cs9mr4054684qcb.71.1281567074687; 
	Wed, 11 Aug 2010 15:51:14 -0700 (PDT)
Received: by 10.229.69.76 with HTTP; Wed, 11 Aug 2010 15:51:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153308>

I've been trying to wrap my brain around how I can get Git to work at
my organization.  The issue is that nearly all of our programs and
their IDE are remotely hosted.  This means that to even work on a file
we have to connect to the network in order to use the application that
we code in.  We do have access to the backend where the files are
stored though.  How can we use Git in this situation without setting
up another server?
