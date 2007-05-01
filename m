From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT RFC PATCH] Don't use refs/bases/<branchname>
Date: Tue, 1 May 2007 11:37:39 +0300
Message-ID: <b0943d9e0705010137q4a35f818m7dbbc9d2e77e2fcf@mail.gmail.com>
References: <20070429220832.5832.251.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue May 01 10:37:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hinrl-0004l8-Gg
	for gcvg-git@gmane.org; Tue, 01 May 2007 10:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031140AbXEAIhm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 1 May 2007 04:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031595AbXEAIhm
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 04:37:42 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:51521 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031140AbXEAIhk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 May 2007 04:37:40 -0400
Received: by ug-out-1314.google.com with SMTP id 44so18535uga
        for <git@vger.kernel.org>; Tue, 01 May 2007 01:37:39 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CKIbRyhhtP2wKr3hpY8tlaqHb4xKVgg305/rEFsdTuOm92vyGbcy4ZbxhtHMgSyL0V6l/7EWNKFfSkGy9McGTYuiRriFezktcpPappVw2L8u6MHHwE7aEdog4ORMQ4oRuKq9vbqImuMnpjviyBkB2xWJnHKPFEVoDZ2KZfo2l4w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KazgNBQx5SD4OwyUSEuoDHDEQWPLrTLIEEZMDwTAIypD+xlQ0GTbPONdWJMNKoUKGPyRxG7uVbDoq/Zr8x5+uoJ188FJRpD5m9IBwjD5bfxTulpDJ+WzjwXmjoysLHPswjrkiln3mikp2D8TUP4DlHWo6cdS2C2mbQ26xhXZzT0=
Received: by 10.67.97.18 with SMTP id z18mr158964ugl.1178008659644;
        Tue, 01 May 2007 01:37:39 -0700 (PDT)
Received: by 10.66.255.11 with HTTP; Tue, 1 May 2007 01:37:39 -0700 (PDT)
In-Reply-To: <20070429220832.5832.251.stgit@yoghurt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45928>

On 30/04/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> It's silly to save the stack base in a ref when it can trivially be
> computed from the bottommost applied patch, if any. (If there are no
> applied patches, it's simply equal to HEAD.)

The reason I initially had the base ref was to see what's on top of
the stack when using gitk. I later added refs/patches/<branch>/...
which are shown by gitk and the base ref would be redundant.

I'm OK with this patch as long as tools like qgit don't rely on this re=
f.

--=20
Catalin
