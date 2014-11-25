From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: How safe are signed git tags? Only as safe as SHA-1 or somehow safer?
Date: Tue, 25 Nov 2014 08:52:58 +0700
Message-ID: <CACsJy8C3Bfruy=usn9MajmLP_10s2zf8AFZJmxyeGSPDS9SwVQ@mail.gmail.com>
References: <5468C33E.2080108@whonix.org> <20141117212657.GC15880@peff.net>
 <CAK3OfOgko5Fb5FMGCKw3+12fAzMVEHuUriaiBNGi8nb28bNTQA@mail.gmail.com>
 <CACsJy8BMNXUinfK=YcJPkx98tYv_e40N0_mqqnzMLxDN6hkruA@mail.gmail.com> <20141125012359.GR6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nico Williams <nico@cryptonector.com>,
	git discussion list <git@vger.kernel.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 02:53:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt5Jt-00083y-QI
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 02:53:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbaKYBx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 20:53:29 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:52628 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbaKYBx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 20:53:29 -0500
Received: by mail-ig0-f179.google.com with SMTP id r2so4252921igi.0
        for <git@vger.kernel.org>; Mon, 24 Nov 2014 17:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Huts9lWv4SwUPd3tY/9Ox0TRIN0xrv6mqnM6HoLwsFg=;
        b=WDlt/4aUl8+sxgmPwNDkP4yticFe8diJFpUoz5qy98RIexvyzl9l5aBeXQean6XIt+
         jqHzbTFfU3gYQNzVntODN9+UyfhpYiHob2X+IjPkrM6SQ7QnyRqaXuH/9hm3ZUil26Uo
         mZXF5YNMsrntGLCNPgHjG1UAKhUD/yhGXV0wtNEoJeXFDL0OMau+5inc83eOqTh/L8bQ
         OxEAdIVJmCiK+nVz/uDmwxVUlyqVAqhBwPXN400JFJAPG3u8PP9Qmwv5RWAM2BBOFVTv
         WF7rAJ8mGABrA47Ygbbll4jiVBtD+29VQqcXgNrJPmGRqtygK139NKPsiTwq/OFlycFS
         XKTQ==
X-Received: by 10.50.143.73 with SMTP id sc9mr15288843igb.27.1416880408491;
 Mon, 24 Nov 2014 17:53:28 -0800 (PST)
Received: by 10.107.176.8 with HTTP; Mon, 24 Nov 2014 17:52:58 -0800 (PST)
In-Reply-To: <20141125012359.GR6527@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260182>

On Tue, Nov 25, 2014 at 8:23 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> I think the biggest obstacle is the upgrade path. ;-)

In the worst case we can always treat new repos as a different VCS. So
people will need a migration from SHA-1 to the new format, just like
they migrate from SVN/CVS to Git. Painful but simple.
-- 
Duy
