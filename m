From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC/PATCH] rebase: add -x option to record original commit name
Date: Fri, 5 Feb 2010 21:00:15 -0500
Message-ID: <76718491002051800ga68dacdq2a432f544401b1fe@mail.gmail.com>
References: <1265419166-21388-1-git-send-email-jaysoffian@gmail.com>
	 <7vzl3ngn7w.fsf@alter.siamese.dyndns.org>
	 <76718491002051758s577d8b5eq2323cd66d479662@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 03:00:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdZyC-0000gG-4D
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 03:00:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933874Ab0BFCAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 21:00:17 -0500
Received: from mail-iw0-f185.google.com ([209.85.223.185]:61680 "EHLO
	mail-iw0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933800Ab0BFCAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 21:00:16 -0500
Received: by iwn15 with SMTP id 15so1694275iwn.19
        for <git@vger.kernel.org>; Fri, 05 Feb 2010 18:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=tL7fxMLiw8XNihHfltEwFUgT1JVQubdeC5sDNJw//Ks=;
        b=PIu2KiHh1rMUwqKPG5wfrCp4fxBVqKKU3+geZ0koZw8hvDBxREx48ksQehU8z7907g
         FleaWE1q1/XhlXYbszJWFoqxFKzfkeyq5TOeU7SY1bRo0F0xhSVkeZLGI/Vmt0VFO8h5
         4tJ/5SjM+4HbDkFatS8Gi3WsODYDjTFvzMuSM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Kh9IVLextJBHiwrQiC4IGWsb+0WiSsExYosBy7fyy6XRww5fqLXPErRDzMC/M9E7/r
         IWZOiwA/YKWrbB/7uRsDVod0TeLHYCbqTuFa++6Mc4u7rL2DKdaMc+a+a/TATX+dsIdu
         EnnrlVDh+nX8HDLG5LWXi3BVXr7fZz3sk5MlY=
Received: by 10.231.169.71 with SMTP id x7mr3739346iby.18.1265421615439; Fri, 
	05 Feb 2010 18:00:15 -0800 (PST)
In-Reply-To: <76718491002051758s577d8b5eq2323cd66d479662@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139138>

On Fri, Feb 5, 2010 at 8:58 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> Well now that's interesting. I am in the process of back porting a
> large amount of development, and it seems very useful to record this
> information in the log message. The subject messages are not always
> unique, so it's provides a very easy to find the original commit.

Sorry, that wasn't clear. I meant, it's a more convenient way to find
the original commit than looking through the original branch for a
commit with the same subject.

j.
