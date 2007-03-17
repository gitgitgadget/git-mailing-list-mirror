From: "Stefano Spinucci" <virgo977virgo@gmail.com>
Subject: Re: using the same repo with different OS
Date: Sat, 17 Mar 2007 15:17:05 +0100
Message-ID: <906f26060703170717t52094994taefad640c52c7faa@mail.gmail.com>
References: <906f26060702250913g41658be6mffea613f25f9a847@mail.gmail.com>
	 <Pine.LNX.4.63.0702251829530.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7v3b4ut7yq.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0702251929170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vy7mmrspw.fsf@assigned-by-dhcp.cox.net>
	 <906f26060702281006l794173e8uea0f7174dd712e32@mail.gmail.com>
	 <20070228181251.GG5924@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Mar 17 15:17:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSZiZ-0000k1-Oi
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 15:17:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965576AbXCQORJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 10:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965571AbXCQORJ
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 10:17:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:45955 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965580AbXCQORH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 10:17:07 -0400
Received: by ug-out-1314.google.com with SMTP id 44so940242uga
        for <git@vger.kernel.org>; Sat, 17 Mar 2007 07:17:06 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HMZK9Y3NeVIf8T6qaXYbITN3PxwMoubZ239rTJTWr7zsdbfAgaQNUOOaY0IVCGaMGLOn3QsL4apXFAncurVmexAG2OX4AJ5pb3PXTzwnHZyad8vm73zJocLlkLKxa+2ecji4lvJk+UD/5SSS31od3tFFOAe56ycv3FTFFaEZtzo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c98mN1IiIYm0sFsnLeW96iQH8s4W7SGKxKTr2VyHAiMYVQTa7joeTe3cTlu/Qflyyki9DaEcWHtTIFMNUvuD23Lv0vYE6yobAzbIuv3ewNsCt2fD7Lj4bphlTmqERoKo+7kv1JHN8v+b/U/x25zMBO8xbR6qJUC4Fn785ypvu0c=
Received: by 10.115.17.1 with SMTP id u1mr1080840wai.1174141025284;
        Sat, 17 Mar 2007 07:17:05 -0700 (PDT)
Received: by 10.114.92.12 with HTTP; Sat, 17 Mar 2007 07:17:05 -0700 (PDT)
In-Reply-To: <20070228181251.GG5924@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42435>

On 2/28/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Stefano Spinucci <virgo977virgo@gmail.com> wrote:
> > I noticed today that my notes about compiling Git on cygwin to work
> > with FAT32 (export NO_MMAP=1) on the Wiki page WindowsInstall were
> > removed.
>
> That was me.  NO_MMAP=1 is now the default on Cygwin.

Unfortunately, the Git cygwin mantainer decided to compile git without
the NO_MMAP option (see the announcement
http://cygwin.com/ml/cygwin-announce/2007-03/msg00005.html and a reply
to my message http://cygwin.com/ml/cygwin/2007-03/msg00567.html).

Then, I guess if on the Wiki page WindowsInstall we should add a note
about recompiling manually Git to work with FAT32.


PS

On the Git cygwin announcement, the mantainer Eric Blake said:
"However, it means that this version does assume that you are not
using FAT or FAT32 to
hold your repositories, since they *do not store file permissions very
accurately*."

What file permissions are not stored accurately ???

Shouldn't be added somewhere (maybe on the GitFaq) a note about Git on
FAT32 problems (if there are any) ???


bye

---
Stefano Spinucci
