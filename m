From: Victor Engmark <victor.engmark@terreactive.ch>
Subject: Re: Permissions and authorisations in git repository
Date: Fri, 28 Jan 2011 12:55:37 +0100
Organization: terreActive AG
Message-ID: <4D42AEB9.3020008@terreactive.ch>
References: <10431381.57687.1296214887819.JavaMail.trustmail@mail1.terreactive.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 28 12:55:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pimvg-0002jH-KG
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 12:55:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753896Ab1A1Lzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jan 2011 06:55:45 -0500
Received: from gate.terreactive.ch ([212.90.202.121]:44918 "EHLO
	mail.terreactive.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404Ab1A1Lzo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jan 2011 06:55:44 -0500
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <10431381.57687.1296214887819.JavaMail.trustmail@mail1.terreactive.ch>
X-terreActive-From: victor.engmark@terreactive.ch
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165612>

On 01/28/2011 12:41 PM, vikram2rhyme wrote:
>
> Hello friends
> I am wondering if there are any permission and authorization control over
> git
> repository. I have gone through git manual but there is no discussion on it.
> On the internet i searched but hardy i found anything. Please help me if
> there
> is any permission control in distributed environment in git repository

Git is independent of access control mechanisms - You can use whatever 
you want. For example, you could use the filesystem read/write 
permissions on a directory to control local access, or SSH permissions 
to allow remote access. See for example GitHub, which uses different 
protocols for different levels of access.

HTH,
-- 
Victor Engmark
