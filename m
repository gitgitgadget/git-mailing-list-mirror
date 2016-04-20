From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] replace --edit: respect core.editor
Date: Wed, 20 Apr 2016 08:33:10 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604200832430.2826@virtualbox>
References: <909769abaff1babdab77625bebd04e2013c6e344.1461076425.git.johannes.schindelin@gmx.de> <xmqqoa9536wi.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 08:33:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aslhg-0004Q8-7D
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 08:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754121AbcDTGdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 02:33:32 -0400
Received: from mout.gmx.net ([212.227.17.22]:51449 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752966AbcDTGda (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 02:33:30 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LlYrb-1bQBJ70aOd-00bHa8; Wed, 20 Apr 2016 08:33:14
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqoa9536wi.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:9JrY5mWHD0SHEvMet23SlAvWRvpaiSsTyFHVWGTMsWqkCriKedn
 U+r653JMuPHzvRtwW0TC7ckeIc+NpEx5wxQCxwlBkOq8JG89t7ol5WX4FYTSmJvOL+SGWzu
 OX4Xa+f0ncKmiQqpmoFZg7tHdZ1VlhCBqz9rh+r4K/8SM8tRsni/vo/S3KUFxbMxzDWqsld
 n5bq1otAjvDyBzwOxSOWw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cO/Cq9/ki5M=:VPdjvta7zlPkekVrUAFv/j
 wIAyGGKaQJ5orEnSx+B+/2VkSdJYhlkI1NgVX0WIN1G3a9SHmLWoNBR21mVSUqW6J5t7gu+J9
 BTz0kdKOlfqY8jffh+bo57jkqz59Wxen06NcwntVEE+PVjWJ2NtlzMbCidIV84hIwrvzd/GF4
 Xb3FSXDeDLkSRcJ0w9KtiLrF3JQjPLWDdSnLS9zPvyVQbvtPfItWnUQLMVDp8HqyLpYSFttPV
 F456ZB3xpoN/9jBmswNbcEZbPMPFzOPJG+kVqiOHnF3WBvquo4YlvThe8eESmQGjutWMND7kS
 8ijcCrKSSDO8oI4nSwYmt+oqZFnrpEId8T29vrhqIJ/WkD6e/6/r3AHfok9blxpd+KXXkV0FH
 aGI21YOE7M1XyrIspt+CPD6IZq0rq54sKNHFIPvXk8qlERpbiaOpHe76Vw5Xkl3R4C8VWOuFI
 ujekpgqtd50kRi+lmbl5JVriBl/3GuVHdyrGCf58+8defw2bvAxJgchkFJzDTq+fZ3Sz/EBKJ
 w9edpbC90SN/rBH5poULa3iQyJ+YQCXiDlm36QcJR+1DLiMbTZbh9bzdUycoM/hdLRrFKWqLo
 BJzs09spveie4OE4bTUQA3dPqGFSOpqlCPxyrM3atScpSS5PTQCZa0d1tZeii6f0MZ5avZuGM
 RMjJyp6/OSt5HUqspR8y7iFCDUQSLwMIQaxdv7ZacxGBfxYEovY5RDJl9K4trvKOZWrW+aMAV
 MhRRx7zqrVM2+WmFdq3PtBy30xfbVw8Tv4kavYNTOXSDb2sohy2IeJzo8FdA4VpPimTumTX5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291984>

Hi Junio,

On Tue, 19 Apr 2016, Junio C Hamano wrote:

> "git blame -L475,6 builtin/replace.c" points at b892bb45 (replace: add
> --edit option, 2014-04-26) and the commit log message names two people
> who can review this change, so that is what I am doing here.

D'oh. Sorry.
Dscho
