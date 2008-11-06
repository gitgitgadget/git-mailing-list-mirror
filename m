From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: Setting Up a GIT Repository Mirror
Date: Thu, 6 Nov 2008 16:33:47 +0100
Message-ID: <adf1fd3d0811060733t28008f0cld1a3b3c5bf4ff4d8@mail.gmail.com>
References: <e97d51700811060706t40433bb9k7a3704429f244164@mail.gmail.com>
	 <e97d51700811060708y5deb9e9ek4a36c012726b3a63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Yaser Raja" <yrraja@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 06 16:35:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky6t0-0007JF-Vh
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 16:35:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbYKFPdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 10:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752163AbYKFPdu
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 10:33:50 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:11543 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbYKFPdt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 10:33:49 -0500
Received: by ug-out-1314.google.com with SMTP id 39so868482ugf.37
        for <git@vger.kernel.org>; Thu, 06 Nov 2008 07:33:48 -0800 (PST)
Received: by 10.103.178.17 with SMTP id f17mr1149415mup.45.1225985627769;
        Thu, 06 Nov 2008 07:33:47 -0800 (PST)
Received: by 10.103.179.20 with HTTP; Thu, 6 Nov 2008 07:33:47 -0800 (PST)
In-Reply-To: <e97d51700811060708y5deb9e9ek4a36c012726b3a63@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100241>

On Thu, Nov 6, 2008 at 4:08 PM, Yaser Raja <yrraja@gmail.com> wrote:
> Hi
[...]

> I came to know about --mirror option of git-clone and used it to make
> a bare repository replica of the MainRep. Now i am not sure how to
> keep it in sync with the MainRep.

$ git fetch

as it is bare you cannot merge, so you cannot pull.

HTH,
Santi
