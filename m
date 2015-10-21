From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] fix flaky untracked-cache test
Date: Wed, 21 Oct 2015 07:42:04 +0200
Message-ID: <562725AC.9090500@web.de>
References: <1445284095-6602-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	pclouds@gmail.com, larsxschneider@gmail.com, tboegi@web.de
X-From: git-owner@vger.kernel.org Wed Oct 21 07:42:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZomAD-0000di-TO
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 07:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753031AbbJUFmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 01:42:13 -0400
Received: from mout.web.de ([212.227.15.3]:64945 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751106AbbJUFmN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 01:42:13 -0400
Received: from birne9.local ([213.66.56.100]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0MKIti-1Zn7jg1HBW-001j9W; Wed, 21 Oct 2015 07:42:10
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.3.0
In-Reply-To: <1445284095-6602-1-git-send-email-dturner@twopensource.com>
X-Provags-ID: V03:K0:4D7OtdZkUBouoBSZLcrbHIGBL0mDX0JPr40sYPGdGbaaXe4/23O
 bA7X8w/a+AyXdSdMsKgnz1pLRRx+eLXgs/yNN8iLw47yRz0sgtsHa4OOtxlX9J++6AlaLAY
 i2eT8oMlB7Mcvss3Oens/aYeW0+dXhQlG+gHbgpsm7rQmes09OaoKmUQ72ZMgk6D+No5rkk
 P5qrPO2y5sfLjPOMLWmzg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ceUboX+pnfY=:yt+itzMQ4z1FqiOB+MOTCu
 CeN+4271weUSeTYMI8O990K8EcjFBJNRrOIGPpR7i4A654xfmesQ6zCmYYv+evMLPzRiXHAHo
 NKlSIlXiH9CnroEnnbpbM7xTS3wqxxxOxWO0hQSTSyvqom1lrxhKz1h26BlSvSl8tPwVwvUal
 rTpbWNhG0a9EtSwPhqbMlNBxoLNMVR82nN+NMXxJ/I99fQ2KfnL2Zpi7fdau3kITHK4Rnq9/p
 3OoCPLcMNKVCOOTnjfP2ADs+zqKAdM5Xm87mPgFvIpGgtdxOgo+5PS8mkezeRXMA/FYJoUEWy
 xchNvpjVf6p6FrnVmPB9aDxOiSNMo3wNR3fTumo9Wep2jvum/E8pNn6tTbiHKDFfOoRQjexf9
 JPj0IrJLRAy9AXWkCqhoR1aU/fDPG9x8QnkrX8EvETEO+UX9wldyDPPTRuUCf/Yg71ifRd3KD
 uuJdyav1Y7ncMfe++8v+q9ReRrH9zClygCToIMeQcWki7c78k0PopPIV6LHQhrQe9nIAeBoFv
 kVRQ03cvCXueU1Mhs7iKmRU7bnjUSXkEjQe/NcLx4GjsBlnJ2aNMHt/230gMoSy5EuU2fm1+t
 FC8iIfTWIVoFzFv9xHjYoyWhiAje/NiMDwENWBGxbTflhKNGCRpmA0g3uHTkNMYW4ctjSUhRd
 wrRNYsVMF0NNp+xM+3PjP+His0fn6NwtDebXXtomJDYcTqDtGxaljDzmWCxchWqMsX1gz76Ws
 LQ+6ly/57f3ibubEdfeLJi+yUTw9bBdB3k8P81viTggoCv1E0NlxPatuagqkd/DJqOzAGsOB 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279969>

On 19.10.15 21:48, David Turner wrote:

> +	echo test >base && #we need to ensure that the root dir is touched
> +	rm base
>  '
Thanks for working on this, (I can run the test as soon as I have access to a Mac with SSD)
Minor remark, the echo test can be removed (and may be the comment ?)
> +	>base &&
> +	rm base
>  '
