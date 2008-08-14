From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] Adding a challenge-response authentication method to git://
Date: Thu, 14 Aug 2008 02:10:29 +0200
Message-ID: <20080814001029.GA14939@cuci.nl>
References: <20080813162644.GC12200@cuci.nl> <20080813164038.GE3782@spearce.org> <20080813173757.GE12200@cuci.nl> <20080813180857.GH3782@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 14 02:11:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTQRC-00028Q-HF
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 02:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753359AbYHNAKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 20:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753296AbYHNAKa
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 20:10:30 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:53684 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934AbYHNAKa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 20:10:30 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 0FA745465; Thu, 14 Aug 2008 02:10:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080813180857.GH3782@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92296>

Shawn O. Pearce wrote:
>If you are going to keep it "really simple" you may be tempted to
>say that all user additions/deletions/password changes should be
>done by the admin directly editing the password list.  At which

Correct.

>point it may actually be easier (and safer) for the admin to just
>handle a GnuPG or SSH public key.

If you want that, that is best handled in ssh.

>This is why we tend to rely on SSH.  It neatly solves all of this
>for us, and does it in a way that UNIX administrators are familiar
>with managing.

>This is also why the last discussion on this topic went down the road
>of using GnuPG to handle the authentication portion of the protocol.
>Unfortunately dealing with the server side keychain is a little
>bit more complex then I'd like it to be out of the box, and the
>client side I think is lacking something as common as ssh-agent
>for caching the decrypted key.

I agree, which is why I don't want to put this complexity in git proper.

>I can see how it would be pretty simple to add authentication to
>git-daemon based upon a shared secret, but such schemes always
>cause management problems on both sides.

I'm not trying to solve all management problems, I'm just trying to
offer a simple solution for the small-user-base-central-repository case
without a lot of code-bloat on the git side.
If it doesn't fit ones needs, use ssh or something else; but it does
have its merits for the simple centralised setups.
-- 
Sincerely,
           Stephen R. van den Berg.

"And now for something *completely* different!"
