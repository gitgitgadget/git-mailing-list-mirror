From: "David M. Lloyd" <david.lloyd@redhat.com>
Subject: Re: [PATCH v1] rebase -m: Use empty tree base for parentless commits
Date: Thu, 09 Oct 2014 14:20:36 -0500
Message-ID: <5436E004.20103@redhat.com>
References: <5434312E.6040407@redhat.com> <bf0e177fbaac91f8c55526729e580fade9f0f395.1412879523.git.bafain@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Fabian Ruch <bafain@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 09 21:20:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcJGV-0000Iy-IJ
	for gcvg-git-2@plane.gmane.org; Thu, 09 Oct 2014 21:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbaJITUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2014 15:20:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60338 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751264AbaJITUj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2014 15:20:39 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s99JKa9N007141
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 9 Oct 2014 15:20:37 -0400
Received: from behemoth.home.flurg.com (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s99JKaLf018399;
	Thu, 9 Oct 2014 15:20:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <bf0e177fbaac91f8c55526729e580fade9f0f395.1412879523.git.bafain@gmail.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/09/2014 01:50 PM, Fabian Ruch wrote:
> Hi David,
>
> I don't think you made a mistake at all. If I understand the --merge
> mode of git-rebase correctly there is no need to require a parent.
> The error occurs when the script tries to determine the changes your
> merge commit introduces, which includes the whole "importing/master"
> branch. The strategy is not yet part of the picture then and will not
> be until the changes are being replayed.

Thank you for your prompt response, clear explanation, and patch even! 
I'm afraid my understanding of the git internals is next-to-nil.  But 
I'm glad I could contribute to helping to improve it in some small way.

-- 
- DML
