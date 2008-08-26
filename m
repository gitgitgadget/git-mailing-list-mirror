From: "Weyert de Boer" <weyert@gmail.com>
Subject: Problems with importing Adobe Opensource SVN repos
Date: Wed, 27 Aug 2008 00:48:52 +0200
Message-ID: <c7d83d0d0808261548o1614b025i80f4ce34f0b161cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 27 00:49:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY7ML-0008DZ-VF
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 00:49:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbYHZWsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 18:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbYHZWsx
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 18:48:53 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:32463 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbYHZWsx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 18:48:53 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2347245rvb.1
        for <git@vger.kernel.org>; Tue, 26 Aug 2008 15:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=TS3GGGQOa6XhDp2TRkMLObTxwzU5j/pD4f2VhlFZ+Oc=;
        b=rlbZf3G2+DHs94XL3fr1LNCZEZhfr89eUrcVmUHbBGnauB1Tb01/qJQnmmh0Kwl2LP
         ZUg5mzPpiW9HRtqHri93qU61VLHRlL9jY+4k8y7xgml+WOxlUIJJt7I+Bj+/zJXOSdzo
         keHNReFKFQl1HD3pn9uBFwQ7sEBIXilEFrRF4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=VUq35jUZE9bCBFFzNjE8B7H27JgMIWvbEvxe8tZqg5tD4VH+iUu2mm8RifrMIpq1jp
         WKcklyHqiQNBAYxrszLX8/D/4PrGEfCCA8xv2bndpLqIsllDlbwDUGELKApIZ7KYJfEP
         4+RWd1o6gX8XrRMqYcejzf331uA7RdEa+z6oY=
Received: by 10.141.29.18 with SMTP id g18mr3166661rvj.162.1219790932720;
        Tue, 26 Aug 2008 15:48:52 -0700 (PDT)
Received: by 10.140.203.3 with HTTP; Tue, 26 Aug 2008 15:48:52 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93830>

Hello!

I am trying to import some SVN repositories available at Adobe
Opensource. Mainly I am trying to import the
repo of Flex. Only I am having trouble to get it imported into GIT.
The problem is that it keeps asking for the authentication
credentials.

I have tried the following commands:

git svn clone --stdlayout http://opensource.adobe.com/svn/opensource/flex/sdk

and

git svn clone --stdlayout http://opensource.adobe.com/svn/opensource/cairngorm

The results I am getting are as follows:

git svn clone --stdlayout http://opensource.adobe.com/svn/opensource/flex/sdk
Authentication realm: <http://opensource.adobe.com:80> Opensource
Subversion Repository
Password for 'albinotreefrog':

This keeps occurring until you cancel the command.

The information about the Flex SDK repo can be found at:
http://opensource.adobe.com/wiki/display/flexsdk/Get+Source+Code

Anyone happen to know what I am doing wrong?

Thanks in advance,

Weyert de Boer
