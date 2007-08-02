From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: cvs2svn conversion directly to git ready for experimentation
Date: Thu, 2 Aug 2007 19:55:28 -0400
Message-ID: <9e4733910708021655p34a72428gd0bd33a830faf127@mail.gmail.com>
References: <46AFCF3E.5010805@alum.mit.edu>
	 <65F1862F-4DF2-4A52-9FD5-20802AEACDAB@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Michael Haggerty" <mhagger@alum.mit.edu>, git@vger.kernel.org,
	users@cvs2svn.tigris.org
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Aug 03 01:55:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGkVw-00058u-Fb
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 01:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756856AbXHBXz3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 19:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756352AbXHBXz3
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 19:55:29 -0400
Received: from rv-out-0910.google.com ([209.85.198.188]:27708 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598AbXHBXz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 19:55:28 -0400
Received: by rv-out-0910.google.com with SMTP id k20so537319rvb
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 16:55:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R1CIVRew9iKeCWKnaDEPf544sbZOsRtkxrd1gB1GWKglQfiLTCwb9FVLq63NEA9XJ/wSN9J9jBuz96TYoe4zG9hrzgsmrX7aHljHaTOGEACa7HW79aPtnRT8aCNbsKdhuWwfkApFUA30IR/VtgK/u2dxV8Xb4K1RTkvR1phEX+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c6VLUX8pGqbgzjC99LSEWKSG+ynPPwuG6qRO9L5yuIywaOX+uysvZwBr2+gA5i45mOQkOA9uusoQKFt3MlRXQrAsvVBqICjSzMhN7riMdbdlhuolB4kzKMGzEUQTbBGR8s37VWaGhtkJcaEPBdztxFcmyxpYjg/xoIKKRgA8UsM=
Received: by 10.115.89.1 with SMTP id r1mr2381125wal.1186098928437;
        Thu, 02 Aug 2007 16:55:28 -0700 (PDT)
Received: by 10.114.195.11 with HTTP; Thu, 2 Aug 2007 16:55:28 -0700 (PDT)
In-Reply-To: <65F1862F-4DF2-4A52-9FD5-20802AEACDAB@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54649>

On 8/2/07, Steffen Prohaska <prohaska@zib.de> wrote:
> Right now, I'd prefer the import by parsecvs because of the
> simpler history. However, I don't know if I loose history
> information by doing so. I'd start by a run of cvs2svn to validate
> the overall structure of the CVS repository. Dealing with corruption
> in the CVS repository seems to be superior in cvs2svn. It reports
> errors when parsecvs just crashes.

Parsecvs silently throws away things that confuse it. cvs2svn is much
more careful about not losing track of anything. For example parsecvs
is unable to process Mozilla CVS and cvs2svn can. The branching in
Mozilla CVS is too complex for parsecvs to handle.

-- 
Jon Smirl
jonsmirl@gmail.com
