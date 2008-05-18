From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH v2 3/5] git-submodule.sh: Add Custom argument input support to git submodule recurse subcommand
Date: Sun, 18 May 2008 15:36:10 +0200
Message-ID: <bd6139dc0805180636o4c5141c5vee559290832a4f03@mail.gmail.com>
References: <1209978582-5785-1-git-send-email-imyousuf@gmail.com>
	 <1209978582-5785-2-git-send-email-imyousuf@gmail.com>
	 <1209978582-5785-3-git-send-email-imyousuf@gmail.com>
	 <7v7idzxhwp.fsf@gitster.siamese.dyndns.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: imyousuf@gmail.com, git@vger.kernel.org,
	"Imran M Yousuf" <imyousuf@smartitengineering.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 18 15:37:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jxj4R-0007gW-PZ
	for gcvg-git-2@gmane.org; Sun, 18 May 2008 15:37:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268AbYERNgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2008 09:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752960AbYERNgO
	(ORCPT <rfc822;git-outgoing>); Sun, 18 May 2008 09:36:14 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:42114 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268AbYERNgN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2008 09:36:13 -0400
Received: by rv-out-0506.google.com with SMTP id l9so954896rvb.1
        for <git@vger.kernel.org>; Sun, 18 May 2008 06:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Dws+/+eEY4l95lnNgQjh6SI3I0AzIn+VC/OQB7G8KjI=;
        b=msmJkqlDIwGr/+EwX8IuQ1/yIZp9emxMeyaONJcuPj42BL1g9esb5BlZt2ZJsLug9TTQRG9H0mN4o3pkTE5mJp1PcRWVrnwGccrx1giaKUE0u45TOiw0kf27922PjGTowV+8Iu8CfQZXwa3agbfoYSvC/yNTURalh5moQWtcjRc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DY944ikExf0O6XPYxcAfamXvO+WI8yJ1GcoA4cOQ/5lRxfkf4hsc//gWx6kyMFPDG9R96Hi84WvWaJbYZJua61ip0TYOnnT1uMAJiBG27q2scdPN3hLvP50sb3oNkT8RwTHCh1yRtYlMVXsyDGwL9n63thtsgiH5Jpz1c1yoCDc=
Received: by 10.143.161.11 with SMTP id n11mr2379157wfo.333.1211117770896;
        Sun, 18 May 2008 06:36:10 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Sun, 18 May 2008 06:36:10 -0700 (PDT)
In-Reply-To: <7v7idzxhwp.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82385>

On Tue, May 13, 2008 at 12:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
> If we want a useful and flexible "recurse", perhaps the only thing we need
> to do is a command that lists a submodule directory path, one path at a
> time, in optionally different traversal order and depth cutoff, so that
> the user can feed it to xargs and do whatever they want to run in there.

How about Windows? Do we want to depend on something like
http://gnuwin32.sourceforge.net/packages/findutils.htm or does msysgit
ship with xargs? (Or do we not intend to build internal commands upon
this system and leave using the output of "recurse" to the user?)

-- 
Cheers,

Sverre Rabbelier
