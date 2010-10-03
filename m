From: =?UTF-8?B?SmVhbi1QaGlsaXBwZSBHYXJpw6lweQ==?= 
	<jean-philippe.gariepy@nuecho.com>
Subject: Re: [BUG] git clean -X behaviour when .gitignore has sub-directory
 entries
Date: Sun, 03 Oct 2010 14:55:48 -0400
Organization: Nu Echo
Message-ID: <4CA8D1B4.1020801@nuecho.com>
References: <4CA0AB9A.4050002@nuecho.com> <20100927203652.GB11957@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Shawn Bohrer <shawn.bohrer@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 20:56:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2TjJ-0006pU-DL
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 20:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754557Ab0JCS4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 14:56:07 -0400
Received: from m.nuecho.com ([64.119.213.149]:57110 "EHLO m.nuecho.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754523Ab0JCS4G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 14:56:06 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by m.nuecho.com (Postfix) with ESMTP id 5D11FBF025B;
	Sun,  3 Oct 2010 14:56:04 -0400 (EDT)
X-Virus-Scanned: amavisd-new at z.nuecho.com
Received: from m.nuecho.com ([127.0.0.1])
	by localhost (zimbra.nuecho.ad [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m35FFYRakHma; Sun,  3 Oct 2010 14:56:03 -0400 (EDT)
Received: from burton.nuecho.ad (modemcable108.22-130-66.mc.videotron.ca [66.130.22.108])
	by m.nuecho.com (Postfix) with ESMTPSA id DC3E5BF01D1;
	Sun,  3 Oct 2010 14:56:03 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.9) Gecko/20100921 Fedora/3.1.4-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <20100927203652.GB11957@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157891>

  On 09/27/2010 04:36 PM, Jonathan Nieder wrote:
> ...
>   1) a/b/f is not actually considered excluded; only its containing
>      directory is.
>
>   2) git clean does not even examine a/b to consider whether to remove
>      it: since a/ does not contain any tracked files, it stopped there.

Ok, thanks for your analysis.  Do you consider it a bug?



-- 
Jean-Philippe
