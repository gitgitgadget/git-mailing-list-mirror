From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: [1/2 PATCH] git-svn: make multi-init less confusing
Date: Fri, 05 Jan 2007 07:38:26 -0800
Message-ID: <m2ejq9trf1.fsf@gmail.com>
References: <87fyaqvgoz.fsf@morpheus.local>
	<20070105020158.GA21925@localdomain> <871wmaugh6.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 05 16:39:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2r9h-0001Ep-67
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 16:38:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161134AbXAEPif convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 5 Jan 2007 10:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161125AbXAEPif
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 10:38:35 -0500
Received: from nz-out-0506.google.com ([64.233.162.238]:52140 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161134AbXAEPie convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jan 2007 10:38:34 -0500
Received: by nz-out-0506.google.com with SMTP id s1so3316862nze
        for <git@vger.kernel.org>; Fri, 05 Jan 2007 07:38:33 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type:content-transfer-encoding;
        b=WPHPKdWaYakOKH00KuGbOs/MCOv3lrxoK/qI3cssleOiKU8Ys+DZrw36XB4HXylWO35wOCnLEMQcL6rUdbkbJEfQ+GZHY98dPJG8OHrHHkWNlw2TKJdEjkarAk4qqGF4naxvwuRB8s3u6CIOn5WVfpS6FPx1N54PsG7Jrhcoheg=
Received: by 10.65.154.10 with SMTP id g10mr16116692qbo.1168011513594;
        Fri, 05 Jan 2007 07:38:33 -0800 (PST)
Received: from ziti ( [67.171.24.140])
        by mx.google.com with ESMTP id e17sm698498qba.2007.01.05.07.38.31;
        Fri, 05 Jan 2007 07:38:32 -0800 (PST)
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
In-Reply-To: <871wmaugh6.fsf@morpheus.local> (David =?iso-8859-1?Q?K=E5ged?=
 =?iso-8859-1?Q?al's?= message of "Fri, 05 Jan 2007 07:37:09 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36004>

David K=E5gedal <davidk@lysator.liu.se> writes:
> Now if you could only clarify the documentation of dcommit to explain
> whether it creates one svn revision per commit in your branch, or if
> it creates a single svn revision with the full diff, and the
> documentation would be perfect :-)

dcommit creates one svn rev for each commit listed by:

   git log remotes/git-svn..HEAD

+ seth
