From: Seth Falcon <seth@userprimary.net>
Subject: Re: [PATCH] send-email, fix breakage in combination with --compose
Date: Mon, 21 Jan 2008 16:05:17 -0800
Message-ID: <m23asqafnm.fsf@userprimary.net>
References: <m2y7aj9glo.fsf@userprimary.net>
	<1200945466-21154-1-git-send-email-hendeby@isy.liu.se>
	<1200945466-21154-2-git-send-email-hendeby@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Tue Jan 22 01:13:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH6lR-00050L-Sa
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 01:13:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380AbYAVAMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 19:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754241AbYAVAMg
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 19:12:36 -0500
Received: from qmta09.emeryville.ca.mail.comcast.net ([76.96.30.96]:42873 "EHLO
	QMTA09.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754046AbYAVAMf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 19:12:35 -0500
X-Greylist: delayed 420 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Jan 2008 19:12:35 EST
Received: from OMTA05.emeryville.ca.mail.comcast.net ([76.96.30.43])
	by QMTA09.emeryville.ca.mail.comcast.net with comcast
	id g0391Y03f0vp7WLA900500; Tue, 22 Jan 2008 00:05:22 +0000
Received: from ziti.local ([64.81.164.13])
	by OMTA05.emeryville.ca.mail.comcast.net with comcast
	id g05J1Y00A0Hfbhs8R00000; Tue, 22 Jan 2008 00:05:32 +0000
X-Authority-Analysis: v=1.0 c=1 a=8RH7e68IMfQA:10 a=Z4mJgif-AAAA:8 a=24-QWLARR7QDK6qnzswA:9 a=Wxm8UjIcyqYcU-mbfDW2EoF5b-UA:4 a=F-J2dRE9H3gA:10 a=50e4U0PicR4A:10
In-Reply-To: <1200945466-21154-2-git-send-email-hendeby@isy.liu.se> (Gustaf Hendeby's message of "Mon\, 21 Jan 2008 20\:57\:46 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71375>

Hi Gustaf,

Gustaf Hendeby <hendeby@isy.liu.se> writes:
> This fixes the subtile bug in git send-email that was introduced into
> git send-email with
>
> commit aa54892f5ada8282643dc7387b33261c7135d784
> send-email: detect invocation errors earlier
>
> causing no patches to be sent out if the --compose flag was used.
>
> Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>

I gave this a quick test and it works for me too.  Thanks!

So FWIW,

Acked-by: Seth Falcon <seth@userprimary.net>

-- 
Seth Falcon | seth@userprimary.net | blog: http://userprimary.net/user/
