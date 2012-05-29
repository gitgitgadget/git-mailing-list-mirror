From: Vangelis Katsikaros <ibob17@yahoo.gr>
Subject: triggering pack-refs
Date: Tue, 29 May 2012 13:43:23 +0300
Message-ID: <4FC4A84B.3020404@yahoo.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 29 12:48:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZJys-000187-Cp
	for gcvg-git-2@plane.gmane.org; Tue, 29 May 2012 12:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753593Ab2E2Ksp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 May 2012 06:48:45 -0400
Received: from nm3-vm0.bullet.mail.ukl.yahoo.com ([217.146.183.228]:40733 "HELO
	nm3-vm0.bullet.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753053Ab2E2Ksp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 May 2012 06:48:45 -0400
X-Greylist: delayed 319 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 May 2012 06:48:44 EDT
Received: from [217.146.183.184] by nm3.bullet.mail.ukl.yahoo.com with NNFMP; 29 May 2012 10:43:24 -0000
Received: from [77.238.184.71] by tm15.bullet.mail.ukl.yahoo.com with NNFMP; 29 May 2012 10:43:24 -0000
Received: from [127.0.0.1] by smtp140.mail.ukl.yahoo.com with NNFMP; 29 May 2012 10:43:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.gr; s=s1024; t=1338288204; bh=VLu3+KkQ4+WdQ4CvDjjSO2XxHnw3nzu+GVVwoiwg2/4=; h=X-Yahoo-Newman-Id:X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:Received:Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:Content-Type:Content-Transfer-Encoding; b=lCYpDmVxHqXrD2BlCbDerNA8Po5Frhr1QS3HIMapOCUBrrMDpg3mYob3aXLZNwbN1ik8DMQiblOd/3XKiTWz3p33ok69+3y1apoOuYSHIf+eCe/MnPZ9B7Ho9PEpzj97ta5y7dc/2zoupUGxCZrlfO5bvhdGHlnO1JWizS3Zel0=
X-Yahoo-Newman-Id: 956713.91213.bm@smtp140.mail.ukl.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: pryh5DsVM1mLu7p7JV74pdtjY5dxQjEqwh0K1GNSEZnYmhj
 9r3A6SN8KGGAGiwSmP8ZoUmXYCagcibQTMfMfzQQHCks2U0W1YcTVuMZA3tc
 m5.eeFHAybxYXflFjRWiPSy_ETskx_h7WgDEM.aRnk3x3OAsNEmoA_kzXR6z
 D3NM4RBBGPNFyc4_b_otYyVWbzKZwsW26fKZyseT_HeCI4w2ah4qZBYSPCVq
 o8vDjBlF6tcWrLFKD6R8WTopMsmePLeK64DXLTOqkx5iw38RWlrYUbn9xGsQ
 GZ4LQlo3GZi9JNec6.B4x.YH6RiII1SbkRD4FbGMp8W37.v7SnyG3NMkPTjF
 FkNWNlpJZU1YVdUlkR_C6T21nrx6dVUjFIXSa9Qrq61mBT77t.E5ToYA-
X-Yahoo-SMTP: OIGsxIKswBBLxjyJwClqZYB_Cw--
Received: from [192.168.1.64] (ibob17@77.49.145.143 with plain)
        by smtp140.mail.ukl.yahoo.com with SMTP; 29 May 2012 10:43:24 +0000 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198734>

Hi

I was doing push/pull to a remote repo and I suddenly got

Total 0 (delta 0), reused 0 (delta 0)
Auto packing the repository for optimum performance.
fatal: Unable to create 'PATH/packed-refs.lock': Permission denied
error: failed to run pack-refs
To user@hostname:PATH
    abc1..abc2  dev -> dev

Indeed, the group of the user I was using didn't have the permission to 
write in PATH/ . It also seems that git pack-refs wasn't running before 
when I was going push/pull.

My question: is it normal for git pack-refs to be triggered during a 
push for the first time at some point in time (because a threshold of 
something was exceeded), or is this an indication that something else 
might be wrong?

I can post more information if needed. The client is 1.7.0.4 on ubuntu, 
and the git on the server is the same too (I don't know how to see the 
the "git version of the remote repo" - if there is such thing).

Regards
Vangelis Katsikaros
