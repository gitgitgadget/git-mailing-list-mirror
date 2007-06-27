From: "Patrick Doyle" <wpdster@gmail.com>
Subject: Is it possible to "graft" a series of commits into/onto an existing repository?
Date: Wed, 27 Jun 2007 09:25:56 -0400
Message-ID: <e2a1d0aa0706270625o538bff7dib81802f000592e51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 27 15:26:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3XX0-0006rT-MH
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 15:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758526AbXF0NZ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 09:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758501AbXF0NZ6
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 09:25:58 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:63118 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758294AbXF0NZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 09:25:57 -0400
Received: by wa-out-1112.google.com with SMTP id v27so207248wah
        for <git@vger.kernel.org>; Wed, 27 Jun 2007 06:25:56 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qhnn8jPV9yDaAJb9/cqwhjHJtx4JQh56yFJQDbyHJzaGq2XFFWy9auJ5NDR8ICxYWPwGyj2rvmvoeaKhxjxUVJezMQCLzRHrGice7E85XGoG8bCBSecII2mGfg548uM4gXJBzvUMW6arEs7EVfzdJbW2eaeEipHw9GVE8/c/1ro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=UQGzk4hNzRZ8S1LaJXHyistqDAc58dZWTjADvqB4VbG3DZg/IClae+MrHOdQwgWyjgL/FXqef5Uy08P+0yaMXSh6wfj30mSMqsOPJtjiPaYlO8frVIPc72QFxadEymWuhX+IF8djiwMXDWh1MTQE0vOOf7NB77mZD44SElmLrn8=
Received: by 10.114.92.2 with SMTP id p2mr471778wab.1182950756705;
        Wed, 27 Jun 2007 06:25:56 -0700 (PDT)
Received: by 10.114.15.11 with HTTP; Wed, 27 Jun 2007 06:25:56 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51040>

I have an empty directory, managed by git and I want to graft another
(git) repository onto it, such that that history is maintained.  Is
this possible?

--wpd
