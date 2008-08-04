From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [StGit PATCH] Add some tests of refreshing removed files
Date: Mon, 4 Aug 2008 10:08:58 -0400
Message-ID: <9e4733910808040708k69802d6w120fd88df7f92b7b@mail.gmail.com>
References: <9e4733910807311902nd3a02bep68c8a26a7e6303cd@mail.gmail.com>
	 <20080804134050.19457.96613.stgit@yoghurt>
	 <9e4733910808040707u2ef8992eha629ebca9c41730b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Catalin Marinas" <catalin.marinas@gmail.com>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 16:10:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQ0lA-0000Au-Sq
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 16:10:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754121AbYHDOJA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Aug 2008 10:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753884AbYHDOJA
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 10:09:00 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:8607 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753862AbYHDOJA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Aug 2008 10:09:00 -0400
Received: by yx-out-2324.google.com with SMTP id 8so141739yxm.1
        for <git@vger.kernel.org>; Mon, 04 Aug 2008 07:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=wGLWCzMke7PNxLAk2carGkfT8PE22LLIeaE7srIQbNU=;
        b=pz6hkqscLp6sYqr4eJA5ieUVYo1wf6cT9uN3tybjs+CRL6opuvjFIrUgcUmcOtgrXU
         f3SqMVzStXgLPcN6w9NTs11NnQYun2LPUYv4XZqcZ0NfkoJWRH288T7T7icWyM45nB6G
         KVeIojYyZctjaptTGfQu80TXq4EC1MKzEeXws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=n+nELsxquI+VjsuC7s9hjhOOCGrkBFlhAOhwM/6R+Y2gi4XhVjpxD34m1R0pHUa0Z4
         TdfVQHahwDerkVmq/equBeMITatcssJsDxW8fo+4j4lyEXnMqRHn4G3T2pTCnwoNKCHx
         SYuwbOT98gEuCO1krayY8mUBvRSsuZrqoj3B8=
Received: by 10.151.156.1 with SMTP id i1mr8332874ybo.117.1217858938991;
        Mon, 04 Aug 2008 07:08:58 -0700 (PDT)
Received: by 10.65.214.7 with HTTP; Mon, 4 Aug 2008 07:08:58 -0700 (PDT)
In-Reply-To: <9e4733910808040707u2ef8992eha629ebca9c41730b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91357>

On 8/4/08, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 8/4/08, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>  > Signed-off-by: Karl Hasselstr=F6m <kha@treskal.com>
>  >
>  >  ---
>  >
>  >  These four tests all pass on Catalin's current master. Do they fa=
il
>  >  for you, or did I miss something in your problem description?
>
>
> I just updated to current git and stg and retested. Tracking a remove
>  is working now for me. Tools were about three months old before
>  updating.
>
>  Not sure what changed. But I definitely couldn't get stgit to do it
>  and had to use git commands to generate the patch. I would remove th=
e
>  file, refresh and the patch was empty.
>  stg status would show the file in D state.  As soon as I touched
>  something else and refreshed the rm would appear in the patch.

The file I was trying to rm was a hidden file, .mailmap

>
>  Maybe there is more to the triggering sequence than a simple rm. I'l=
l
>  keep a watch out and see if I can figure out how I got into the stat=
e.
>
>
>  --
>  Jon Smirl
>  jonsmirl@gmail.com
>


--=20
Jon Smirl
jonsmirl@gmail.com
