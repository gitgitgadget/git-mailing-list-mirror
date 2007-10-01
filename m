From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 1/2] Change "refs/" references to symbolic constants
Date: Mon, 1 Oct 2007 21:41:43 +0100
Message-ID: <200710012141.44459.andyparkins@gmail.com>
References: <200709291359.59147.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 01 22:42:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcS5r-0007dr-Pt
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 22:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752413AbXJAUl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 16:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752783AbXJAUl5
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 16:41:57 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:40079 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752222AbXJAUl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 16:41:56 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1966095ugc
        for <git@vger.kernel.org>; Mon, 01 Oct 2007 13:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=mi+DYA3nERSdPXa3zSQJBVHdYhzrsaxUt+sP7XY9UBo=;
        b=bMpanI16AMVUprmCwmb52fBVNFu1p3uWo0gNDevUXpcIpSTFUQS+Ba0GVUSi8S0h5JJvtwAYbaOcLetE6t6BEUsj1rBl8q3EvZiQ7khozF7f/0l3YY4A1xtkCbZIcmt4UddQkK6AEqnn5yN5vRZVqqkMYd/Q+Kwk7TK2eRCVHKc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=rgfOV00lILohSyO2mTQ29vSSYrOpHyB24GsXsXgTc/oXudKSx8fNTyT7U5G2sjG3q2Y4Z/Ddj6OaJSesqjEkEdwupMWWXoK8cTKAsSB6+00a6GI+7XLQwIxtKqaC+YpgrkJWQxOVofeoJ+HdL8XAY8QgPBqjeRXqGJQgz9d7dJQ=
Received: by 10.67.31.5 with SMTP id i5mr64358ugj.1191271314465;
        Mon, 01 Oct 2007 13:41:54 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTPS id j1sm93894ugf.2007.10.01.13.41.53
        (version=SSLv3 cipher=OTHER);
        Mon, 01 Oct 2007 13:41:53 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <200709291359.59147.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59632>

On Saturday 2007, September 29, Andy Parkins wrote:
> Changed repeated use of the same constants for the ref paths to be
> symbolic constants.  I've defined them in refs.h

Please hold off on applying this.  I'm getting this when running the tests:

*** t5516-fetch-push.sh ***
*   ok 1: setup
*   ok 2: fetch without wildcard
*   ok 3: fetch with wildcard
*   ok 4: push without wildcard
*   ok 5: push with wildcard
*   ok 6: push with matching heads
*   ok 7: push with no ambiguity (1)
*   ok 8: push with no ambiguity (2)
*   ok 9: push with weak ambiguity (1)
*   ok 10: push with weak ambiguity (2)
*   ok 11: push with ambiguity (1)
* FAIL 12: push with ambiguity (2)

I'm having trouble seeing where the fault is at the moment though.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
