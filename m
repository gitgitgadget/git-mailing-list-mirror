From: "Paolo Teti" <paolo.teti@gmail.com>
Subject: Re: [MinGW port] Unable to repack on Clearcase dynamic views
Date: Thu, 31 May 2007 11:46:12 +0200
Message-ID: <34a7ae040705310246w72c30c19ic063895a46b8f3fb@mail.gmail.com>
References: <fcaeb9bf0705300742u22b54c78vccbc037fb553141f@mail.gmail.com>
	 <34a7ae040705300811o22a7d9e9y1ca6e52c4bf23fcc@mail.gmail.com>
	 <fcaeb9bf0705300833t6f0639ddx2f507996e48d838c@mail.gmail.com>
	 <200705302028.15549.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu May 31 11:46:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HthEh-0005yq-Ei
	for gcvg-git@gmane.org; Thu, 31 May 2007 11:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757903AbXEaJqO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 05:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757635AbXEaJqO
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 05:46:14 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:30674 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755376AbXEaJqN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 05:46:13 -0400
Received: by wr-out-0506.google.com with SMTP id 76so101244wra
        for <git@vger.kernel.org>; Thu, 31 May 2007 02:46:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HWj/QNJVdZ9vula/Gc7cpjf8eRF/WHQ/ZhvsafEOKA41XdEy3pMMX11UGciE6faB0imEpR7Epr4xgoLcIbNlvxvaP/qaT8gM9tXDHNYKcOxVRCFefgjlXa4L/04KCsXONloQd9E9MTHRnIsTgKJamFhklRyipkyRdnPa9yug3mY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oVsxVZ4GaMlwW3kGnvdhQVFlK9wuJjBY/1SXNPa0CUL5pIVJFLWxNOKFNUVyCz8yZMCnDoYrPHHXKQnSn9ZygTqkTxqcXGWI33UW/Uvoxp8IREJ7Tlj9VKFLtPkKSi+POMk14DlWjrcmWIjzO9U7u3/Ct9JLC3SbaQEa2O+JtaM=
Received: by 10.78.123.4 with SMTP id v4mr290698huc.1180604772578;
        Thu, 31 May 2007 02:46:12 -0700 (PDT)
Received: by 10.78.183.11 with HTTP; Thu, 31 May 2007 02:46:12 -0700 (PDT)
In-Reply-To: <200705302028.15549.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48807>

2007/5/30, Robin Rosenberg <robin.rosenberg.lists@dewire.com>:

> BTW, Does anyone have something like git-cvsexportcommit for clearcase?

a stupid workaround is git-cvsexportcommit + clearimport /clearexport_cvs.
