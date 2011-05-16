From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCHv3 6/9] receive-pack: Prepare for addition of the new
 'limit-*' family of capabilities
Date: Mon, 16 May 2011 15:16:37 -0700
Message-ID: <BANLkTinxTWK3wgp-WcC9rBpCe2-uXeSE=w@mail.gmail.com>
References: <201105151942.29219.johan@herland.net> <1305495440-30836-1-git-send-email-johan@herland.net>
 <1305495440-30836-7-git-send-email-johan@herland.net> <7vaaenm957.fsf@alter.siamese.dyndns.org>
 <BANLkTimUWHiUdxbBfvvcomqmzQxLPhUsZA@mail.gmail.com> <7vhb8ujo4e.fsf@alter.siamese.dyndns.org>
 <BANLkTimge=rPe6K3rYRqYDGQTN_wbi3a2A@mail.gmail.com> <7vd3jijnwe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johan Herland <johan@herland.net>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 17 00:17:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QM66N-0004ei-A0
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 00:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754276Ab1EPWRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 18:17:18 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56856 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860Ab1EPWRS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 18:17:18 -0400
Received: by qwk3 with SMTP id 3so2514880qwk.19
        for <git@vger.kernel.org>; Mon, 16 May 2011 15:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=HvQ29Y+n1rwpyJ6wPWF7ZJLryC6M6CRDw4o2WIyOwss=;
        b=TjySYi7jtSuxugh7Gra6ZKeuoz4fDOPTqU79XrQWibvinAJdiKQqT3KUq4ggwvPTXy
         s1qh8uyW0AN4bYRsQNGBwqYrb9Zl+PT1LSV21OgbZ06QWN80mnmT0tdOOJETPFbMfEMG
         zCu/pIjSadl2T4WwYvQNbgn0UoUUQNaM0zj50=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=k8sD7DMDDJJF2WZA+RX3hqG5UlKSkNe0F5BG/fVdNqye72rbB4iUQ0GGq59H0eIgUA
         4S9aZi3FyCIm/50/Xcsq7KnbeKXNTK0O5cjxHZX/VoAdS/Ze553AeTpr2qIsVKLgbjid
         TEFrJcXM3Ah14DdY6We4qhLBj23hq/Q76SjsU=
Received: by 10.229.90.90 with SMTP id h26mr3778676qcm.103.1305584237117; Mon,
 16 May 2011 15:17:17 -0700 (PDT)
Received: by 10.229.229.5 with HTTP; Mon, 16 May 2011 15:16:37 -0700 (PDT)
In-Reply-To: <7vd3jijnwe.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173771>

Heya,

On Mon, May 16, 2011 at 15:12, Junio C Hamano <gitster@pobox.com> wrote:
> I do not see any point in deciding that right now without even knowing
> what kind of strings (short? mostly ascii? etc.) we would typically want
> as payload and tie our hands with a poor decision we would end up making
> out of thin air.

Ok, fair enough. :)

-- 
Cheers,

Sverre Rabbelier
