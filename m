From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Bug in git remote prune?
Date: Thu, 5 Nov 2009 20:58:01 -0500
Message-ID: <76718490911051758h5afb6a40x9cef3e63ae2a809c@mail.gmail.com>
References: <76718490911051634w2d364b73m567e73039508c857@mail.gmail.com>
	 <7vvdho5t9s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 02:59:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6E6i-0001L5-I4
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 02:59:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757805AbZKFB55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 20:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757424AbZKFB55
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 20:57:57 -0500
Received: from mail-iw0-f180.google.com ([209.85.223.180]:53137 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757318AbZKFB54 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 20:57:56 -0500
Received: by iwn10 with SMTP id 10so531856iwn.4
        for <git@vger.kernel.org>; Thu, 05 Nov 2009 17:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=T7XmU8QF00QXOIxfeEP9GDj82CX+/udXTMgud7sjFn8=;
        b=P9gIEiQpV+8Osqph9f3ekTo7JanboNdmnQjlvXWBiXhWCs36DVrHXbE/0QjODno8uq
         u+u1GGGXESGOa6QyZuFqBrmZXJyl9W3mPyuylb5/OpxoYkO3UUSBjxsef/00PpobTaXt
         MJ3z8Som27qtFB5CV23ppNNcQ6xZab2P3fCkI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=TQClkeBwU6tixrijzDKWFlafyc3vCYbRZSI0xDMF2C+bgixNSjYrijMB3vQlqstNYs
         whBXZdtuTmxdXutk+rPZMTnmmFwdkSgW3U5N7c13fKJepgbZptf+7I5m9mftCNmV34Ik
         kvZSBj4gCGvb29MsF3S0tKGT+Z1iQ4Jm77nkw=
Received: by 10.231.73.131 with SMTP id q3mr1598788ibj.6.1257472681215; Thu, 
	05 Nov 2009 17:58:01 -0800 (PST)
In-Reply-To: <7vvdho5t9s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132267>

On Thu, Nov 5, 2009 at 8:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nothing happens because we were told by the refspec not to even look at
> these refs/heads/{next,ghost} refs on the other side.

Gotcha, and that's all you had to say, but I appreciate the long
explanation. :-)

j.
