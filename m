From: Seth Falcon <seth@userprimary.net>
Subject: git-send-email not sending?
Date: Mon, 21 Jan 2008 10:30:11 -0800
Message-ID: <m2y7aj9glo.fsf@userprimary.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 21 19:31:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH1QZ-0005bQ-8W
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 19:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325AbYAUSa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 13:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbYAUSa2
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 13:30:28 -0500
Received: from qmta06.emeryville.ca.mail.comcast.net ([76.96.30.56]:51762 "EHLO
	QMTA06.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753933AbYAUSaV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 13:30:21 -0500
Received: from OMTA09.emeryville.ca.mail.comcast.net ([76.96.30.20])
	by QMTA06.emeryville.ca.mail.comcast.net with comcast
	id fo3q1Y0010S2fkC0A0ZU00; Mon, 21 Jan 2008 18:30:21 +0000
Received: from ziti.local ([64.81.164.13])
	by OMTA09.emeryville.ca.mail.comcast.net with comcast
	id fuWC1Y0010Hfbhs8V00000; Mon, 21 Jan 2008 18:30:19 +0000
X-Authority-Analysis: v=1.0 c=1 a=Z4mJgif-AAAA:8 a=ZX1waDppo2zoufpjvR0A:9 a=UAY8ew26nB7xgfEDCY8Pjzo0tCIA:4 a=F-J2dRE9H3gA:10 a=50e4U0PicR4A:10
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71304>

Hi,

I'm using git version 1.5.4.rc3.37.gfdcf3 and when I use
git-send-email with the --compose option like this:

   git send-email --compose -- a_dir_of_patches/

The intro email gets sent, but not any of the actual patches.  If I
ommit the --compose option, then the patches do get sent.  Pretty sure
this worked for me until a recent update so I wonder if there's a
buglet in the recent validation patches (or I'm in error and missing
some needed config?).

+ seth

-- 
Seth Falcon | seth@userprimary.net | blog: http://userprimary.net/user/
