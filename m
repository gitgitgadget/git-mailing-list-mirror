From: "Rotem Yaari" <vmalloc@gmail.com>
Subject: Feature Request: Branch Annotations
Date: Wed, 8 Oct 2008 12:49:12 +0200
Message-ID: <d2115f4f0810080349o30b6bc2labc2745b8d981e0d@mail.gmail.com>
References: <d2115f4f0810080341m27c4ca9bv9b1e9b66704ef3fa@mail.gmail.com>
	 <d2115f4f0810080348t62e18b14x1dfe798974332b05@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 08 12:51:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnWce-00078y-F9
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 12:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754907AbYJHKtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 06:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754910AbYJHKtP
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 06:49:15 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:36597 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753764AbYJHKtN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 06:49:13 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2665770fgg.17
        for <git@vger.kernel.org>; Wed, 08 Oct 2008 03:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=yDGObEd+8V5uZ3vfLiouyL+rr1hBb8+Az15eLipxEjE=;
        b=EjIz/09Qr0nu/OHRORGJQbLRE1Dn8DMSqMG2q31UQdfgURaBRixTiLsXmx5YrfSofk
         lqdDPExR2gVlgpZuZFcaG0Vvjk5R8lutm1iozUQIbYqA7N0GZAvmiktIPLDWAIALTlSX
         twMdfcxgAPKpdFJp9HpGL6ke2MYQilap3lliQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=aK8egvFTSGKBfWMC6ZVz5STHowsqti/pl8mCKLzCL93BS2JmamfQ1vkpxz5sLpVL73
         p3qB3biNdgwHVJXMXMKEgMCmnBeEE1E7aseT3Uxn2bhgjTW4WqtYH0TgK6QeHTfOMy+P
         ApYs0M47+0IsymoEJrcIox0H9seND+F7WNRoM=
Received: by 10.187.160.1 with SMTP id m1mr1507360fao.72.1223462952534;
        Wed, 08 Oct 2008 03:49:12 -0700 (PDT)
Received: by 10.187.243.11 with HTTP; Wed, 8 Oct 2008 03:49:12 -0700 (PDT)
In-Reply-To: <d2115f4f0810080348t62e18b14x1dfe798974332b05@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97793>

Hi,

I usually work with many branches in git, each of which represents a
different state of development/stability, but also development tasks
assigned to me.
Sometimes, besides the name of the branch, it could be useful to have
a short description of a branch which quickly reminds me what that
branch is intended for.

Currently I see no way in git to achieve this (there's a description
for a repository, but not for individual branches).

Any opinions on this?


Thanks in advance,

--
Rotem
