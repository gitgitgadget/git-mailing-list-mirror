From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCHv2 0/4] git-p4: small fixes to branches and labels; tests
Date: Thu, 1 Dec 2011 00:37:05 +0000
Message-ID: <CAOpHH-U6NxRSioRZg9_+f146vVR+S1hWsVbRmHz+vsqtz+vXiA@mail.gmail.com>
References: <1322643817-13051-1-git-send-email-luke@diamand.org>
 <loom.20111130T155409-599@post.gmane.org> <4ED6809A.9020703@diamand.org>
 <20111130225813.GA11544@arf.padd.com> <20111130230007.GA11598@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Luke Diamand <luke@diamand.org>, git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Thu Dec 01 01:37:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVuek-0007Qy-El
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 01:37:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753075Ab1LAAhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 19:37:38 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:57300 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752493Ab1LAAhh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Nov 2011 19:37:37 -0500
Received: by lagw12 with SMTP id w12so361812lag.19
        for <git@vger.kernel.org>; Wed, 30 Nov 2011 16:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=IGarhlesMf8USraxz0RnCRhDRbhxb7GpZA58EofnaHs=;
        b=mFlR2CctUGbPVMBxUk/L3LJUpKpoGzfa/wnYVh65qjurGW2W6KSUPlL5LdglFkEY+x
         /PlV7z90uwPXrEqbDvUFfIJHxWdQAzDtBWwtRbyeqMvph4LOggYdNuW/Qk04dktLPvXb
         ss7j0RmGR8ymFc806tHVO4UuuJVN32ZCDkVx8=
Received: by 10.152.113.101 with SMTP id ix5mr3023717lab.23.1322699856338;
 Wed, 30 Nov 2011 16:37:36 -0800 (PST)
Received: by 10.152.5.105 with HTTP; Wed, 30 Nov 2011 16:37:05 -0800 (PST)
In-Reply-To: <20111130230007.GA11598@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186153>

On Wed, Nov 30, 2011 at 11:00 PM, Pete Wyckoff <pw@padd.com> wrote:
> And avoids collision with some Vitor code that will get
> added eventually.

I'm starting to doubt I will ever be able to overcome the fast-import
limitation on not allowing branch delesetion. Sure, the code I wrote was
garbage! But they seem to be very relunctant on the concept of deleting
branches on the fly.
Did you ever take a look at the patch I sent? Maybe you could help me
shape it up a bit.

-- 
Vitor Antunes
