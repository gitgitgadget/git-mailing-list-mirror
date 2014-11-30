From: Yuri D'Elia <wavexx@thregr.org>
Subject: Re: Thinning a repository
Date: Sun, 30 Nov 2014 13:35:36 +0100
Message-ID: <m5f2up$554$1@ger.gmane.org>
References: <m5f1uq$na7$1@ger.gmane.org> <20141130123400.GG31751@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 13:36:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xv3jK-0001Sb-P1
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 13:35:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbaK3Mfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2014 07:35:55 -0500
Received: from plane.gmane.org ([80.91.229.3]:42830 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752038AbaK3Mfy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 07:35:54 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Xv3jD-0001PT-IV
	for git@vger.kernel.org; Sun, 30 Nov 2014 13:35:51 +0100
Received: from adsl-ull-182-73.49-151.net24.it ([151.49.73.182])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 13:35:51 +0100
Received: from wavexx by adsl-ull-182-73.49-151.net24.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 13:35:51 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-ull-182-73.49-151.net24.it
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <20141130123400.GG31751@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260450>

On 11/30/2014 01:34 PM, Fredrik Gustafsson wrote:
> On Sun, Nov 30, 2014 at 01:18:34PM +0100, Yuri D'Elia wrote:
>> Is there a quick way to reproduce the effect of a shallow clone on a
>> local repository that doesn't involve filter-branch and/or re-clone?
> 
> I'm curious, why is it a bad thing to do a re-clone? If you clone your
> local repo it would be really fast.

I see no reason to involve the workspace.
I would also want to keep the current remote/origin as it is.

I expect a 'thin' command to be faster by not touching the workspace at all.
