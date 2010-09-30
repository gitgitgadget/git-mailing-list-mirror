From: Mathias Lafeldt <misfire@debugon.org>
Subject: Re: How to get a remote branch
Date: Thu, 30 Sep 2010 09:48:52 +0200
Message-ID: <4CA440E4.3080203@debugon.org>
References: <1285819987771-5586541.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andy <hoangtu69@yahoo.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 09:49:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1Dsz-0004tq-0c
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 09:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755051Ab0I3Hsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 03:48:55 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:62371 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754941Ab0I3Hsy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 03:48:54 -0400
Received: from [172.20.2.23] (p578D1B5F.dip.t-dialin.net [87.141.27.95])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0M5Ksl-1Oq3A20uX1-00z2Fe; Thu, 30 Sep 2010 09:48:53 +0200
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
In-Reply-To: <1285819987771-5586541.post@n2.nabble.com>
X-Provags-ID: V02:K0:KD5fbFFdVk3HgClw1IuiAbIzxC5u9QkrKPhbCSTfvLk
 1BsM2/u1AUPoipbEVdL12GulGrPoabEA55PkyjU4xPJjFPtl0W
 d9oe1kFiyfSFHHeQ4pELFc4JN4QWuc9fxi+eYaZ5QwMJ8nR61o
 6rSpPkvquQCL+hLAnkkGSIR7zFO9Vp/KcJfnbmEu64VLGwWhk1
 flElHbpUSEZj2EKQzaGf950i8BdJHtwtgVu4luJGFE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157633>

Andy wrote:
> Here's my directory structure
> 
> origin -> HEAD
>          -> master
>          -> develop
> 
> Right now if I issue command
> 
> git clone https://abc.com/xzy.git and do git branch 
> 
> then I have an asterisk next to master.
> 
> I want to get branch develop, what command should I issue please?

$ git checkout -b develop origin/develop

-Mathias
