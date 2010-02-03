From: Michele Ballabio <barra_cuda@katamail.com>
Subject: Re: git-gui translation updates needed
Date: Wed, 3 Feb 2010 11:11:16 +0100
Message-ID: <201002031111.29557.barra_cuda@katamail.com>
References: <20100201151647.GB8916@spearce.org> <7vy6jbunu8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 11:10:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NccBL-0000lv-Tr
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 11:10:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756989Ab0BCKJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 05:09:55 -0500
Received: from smtp185-pc.aruba.it ([62.149.157.185]:48900 "HELO
	smtp1-pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1756324Ab0BCKJy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 05:09:54 -0500
Received: (qmail 18141 invoked by uid 89); 3 Feb 2010 10:09:38 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on smtp1-pc.ad.aruba.it
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_50,RDNS_NONE
	autolearn=no version=3.2.5
Received: from unknown (HELO darkstar.localnet) (barra?cuda@katamail.com@78.134.65.18)
  by smtp1-pc.ad.aruba.it with SMTP; 3 Feb 2010 10:09:36 -0000
User-Agent: KMail/1.11.4 (Linux/2.6.32.7-mike-1mike; KDE/4.2.4; i686; ; )
In-Reply-To: <7vy6jbunu8.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138822>

On Wednesday 03 February 2010, Junio C Hamano wrote:
>  - It is curious that de.po is based on a version of .pot that is
>    different from the official git-gui.pot, even though it seems to be
>    up-to-date (no, I don't read German, but running "msgmerge -U po/de.po
>    po/git-gui.pot" doesn't seem to detect anything missing).
> 
>    Build log for "de" also says that has 520 messages all translated.

IIRC, the timetable was:
	* Christian Stimming submits a new de.po
	* Shawn Pearce updates git-gui.pot and asks for help
	* other languages are submitted

So de.po has a different date, but doesn't miss anything since
no major change has occurred in git-gui.git in the meantime.

>  - I am seeing "1 untranslated", even though it.po is based on the latest
>    git-gui.pot.  It translates "buckets" to an empty string; somebody who
>    care about Italian may need to double check.

An empty string means "there's no translation, use the default" -- in
this case: "buckets". I left it this way because I couldn't come up
with a decent translation, and I wanted to keep a reminder.

In this case, git-gui is counting objects during a clone;
would it be OK to consider "buckets" as synonim of
"objects" or "items" or something else?
Then I would translate accordingly.
