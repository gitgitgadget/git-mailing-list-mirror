From: Shantanu Pavgi <pavgi@uab.edu>
Subject: Re: git access using SSL certificates
Date: Mon, 28 Jun 2010 17:39:03 -0500
Message-ID: <6E28EE29-0FFA-4467-AE10-76ED2AEF79A5@uab.edu>
References: <CB7586D8-2C18-4BE9-9B32-3D02AA5F37ED@uab.edu> <16FCDB06-9C82-4CBF-BD25-A10BD3E829DE@uab.edu> <20100628204425.GA13640@LK-Perkele-V2.elisa-laajakaista.fi>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Tue Jun 29 00:39:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTMz3-0008Q5-1X
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 00:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752363Ab0F1WjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 18:39:08 -0400
Received: from uabexht1.ad.uab.edu ([138.26.5.101]:34718 "EHLO
	UABEXHT1.ad.uab.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517Ab0F1WjH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jun 2010 18:39:07 -0400
Received: from [10.0.0.23] (138.26.125.8) by relay.ad.uab.edu (138.26.5.101)
 with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 28 Jun 2010 17:39:03
 -0500
In-Reply-To: <20100628204425.GA13640@LK-Perkele-V2.elisa-laajakaista.fi>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149868>


Tried with Git 1.7.1 on Mac: Doesn't work, same error. 
Tried from another CentOS box with Git 1.7.1 and it worked fine. 

In all failed cases apache logs indicate: <timestamp> [error] Re-negotiation request failed. 

--
Thanks,
Shantanu Pavgi. 


On Jun 28, 2010, at 3:44 PM, Ilari Liusvaara wrote:

> On Mon, Jun 28, 2010 at 03:23:30PM -0500, Shantanu Pavgi wrote:
>> 
>> Forgot to mention version info in my earlier email: 
>> Server/Public repo: CentOS 5.4 with Git 1.7.1 installed from source 
>> Client in earlier mail: Mac OS X 10.6 Git 1.6.5.2 
> 
> Too old. 1.6.6 is minimum version requirement for smart HTTP push.
> Try upgrading.
> 
>> Debian with Git 1.5.6.5:
> 
> Too old. That's quite old version... Upgrade.
> 
> -Ilari
