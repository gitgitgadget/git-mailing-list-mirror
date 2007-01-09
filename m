From: "Alexy Khrabrov" <deliverable@gmail.com>
Subject: building git in a separate directory
Date: Mon, 8 Jan 2007 19:30:54 -0800
Message-ID: <7c737f300701081930t755d9e61h581e421ecf7ab465@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jan 09 04:31:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H47hT-00009V-0P
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 04:30:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbXAIDaz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 22:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbXAIDaz
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 22:30:55 -0500
Received: from wx-out-0506.google.com ([66.249.82.233]:41939 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbXAIDaz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 22:30:55 -0500
Received: by wx-out-0506.google.com with SMTP id h31so256441wxd
        for <git@vger.kernel.org>; Mon, 08 Jan 2007 19:30:54 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mz5xJfkZLfVeqclt0PsnZZp1S3zmxUtFbe/hE91r7JcoFm4W3ruS3jBoSLxkfyWOUSsurtoZx6EzLXobdFijqWgyp0ge5FNhapjy9ujMuheEvtmOO1dsAA+WZB7G5y18Wni9hvttbLtsDNyQRUGQ12cv0f7PhYML5lVXL7ftQnI=
Received: by 10.90.119.15 with SMTP id r15mr2710062agc.1168313454565;
        Mon, 08 Jan 2007 19:30:54 -0800 (PST)
Received: by 10.90.78.8 with HTTP; Mon, 8 Jan 2007 19:30:54 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36302>

Tried to build git 1.4.4.1 away from the source directory -- said

make configure

-- which made a configure, switched to a separate build/ directory,
invoked that/../configure -- which ran fine, except produced no
Makefile!

What's the way to build git outside from the source directory?

Cheers,
Alexy
