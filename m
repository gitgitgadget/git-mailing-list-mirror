From: Frank Li <lznuaa@gmail.com>
Subject: Re: [PATCH] Fix symlink __stdcall problem at MSVC
Date: Thu, 20 Aug 2009 22:16:50 +0800
Message-ID: <1976ea660908200716u6643ff3fgd30f6cd859260316@mail.gmail.com>
References: <1250774680-4720-1-git-send-email-lznuaa@gmail.com>
	 <alpine.DEB.1.00.0908201546500.4719@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 20 16:17:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Me8Ro-0004yU-SG
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 16:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754361AbZHTOQv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2009 10:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754331AbZHTOQv
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 10:16:51 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:63609 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754259AbZHTOQu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Aug 2009 10:16:50 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1746693qwh.37
        for <git@vger.kernel.org>; Thu, 20 Aug 2009 07:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2x9sT/7vf1zm4rFoBTNRv5upKjFwKdWn1fBGwp11pXw=;
        b=QvbqxqpGZYNxtDJk6zUuDdcg9jC4LMobddfSiVLzpifbEwx5GH+jVxnkNCEnxc+qHM
         EE+q7t5RflUX5Rl3woA9mSKvPytKjp9Ms84jwJfXi60M4E+/sSc8UpiSy9670oc4eJEX
         oe/x24bbsDfr6NgLaL8c4BZGc7UOwXsOW3FxY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iLwvEoY411IBr7wz7DU92Lagj2jZYXbnwqw/kFDSPpM2VmOGwQ64hvsBJo/74o3qV7
         DWfNHmZIawsRpfipeqddkB/TpFg5Tto+ga1SSMNhz+OZGEd0+NlRUUMORm7zsUazwsu6
         egblFbpKJKTmhynT8ISOipdW+eZcC9slApQ8A=
Received: by 10.224.25.6 with SMTP id x6mr7575910qab.30.1250777810544; Thu, 20 
	Aug 2009 07:16:50 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908201546500.4719@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126642>

>
> Like what? =A0Seems you did not paste my complete commit message.
>
Yes, Sorry about this
