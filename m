From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: Verifying the whole repository
Date: Thu, 23 Oct 2008 07:05:16 -0700
Message-ID: <ee77f5c20810230705l20339a1dj87b855bf3321f796@mail.gmail.com>
References: <b2cdc9f30810230659n15f44f64l571a0df3dbe104d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alex Bennee" <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 16:08:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kt0pi-0004Gj-VP
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 16:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbYJWOFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 10:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbYJWOFT
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 10:05:19 -0400
Received: from el-out-1112.google.com ([209.85.162.180]:39760 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbYJWOFS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 10:05:18 -0400
Received: by el-out-1112.google.com with SMTP id z25so110271ele.1
        for <git@vger.kernel.org>; Thu, 23 Oct 2008 07:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=5m3DNzW2wYyEY4WG7eZVFTuXubCvuQdQTT0oQZvi7lI=;
        b=V8aHlh04dH3491+4PKrJvqtgdTUVqx2TURWs0iHgSHHOENpJIM7e2+sqb/FtRPsmLd
         9Tma1OK0ltG7X0aLNnjBKQPBTsDRp8hqIQlog7gcjuhHbKCTxO/g5ME1S1JBt+lSE1/C
         3zarrzqR5wFyqgtlI+b2fWtyhAC6CzjtRrGaw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Ld94zqZTv1vv/sYDKhzKmujstvS7/3xQqNjvpJB+GBFF+L7FlIg9+Oq/It8VJ18jgN
         WAPiWIteb7PtBAcgVDpkEIUcOd39HxIrd5lAMzAJQHkUqjqhLmLz3kCNXQKY2T6z9r9+
         ufO/gHdPhB2Qnmk1oJIFuvuo/YEKhdtQjSl1U=
Received: by 10.142.162.5 with SMTP id k5mr336610wfe.260.1224770716129;
        Thu, 23 Oct 2008 07:05:16 -0700 (PDT)
Received: by 10.142.170.14 with HTTP; Thu, 23 Oct 2008 07:05:16 -0700 (PDT)
In-Reply-To: <b2cdc9f30810230659n15f44f64l571a0df3dbe104d9@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98967>

On Thu, Oct 23, 2008 at 6:59 AM, Alex Bennee <kernel-hacker@bennee.com> wrote:

> As git is fundamentally hash based it's a lot easier to determine the
> health of the repository but I wonder if it's possible for silent
> corruption to creep in which won't be noticed until you try and
> checkout a historical commit of the tree. I notice there is a
> git-verify-pack command that checks the pack files are OK. Do any of
> the other commands implicitly ensure all objects in the repo are
> correct and valid? git-gc?

Try:  git fsck --full --strict


Dave.
