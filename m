From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] t0005: work around strange $? in ksh when program 
	terminated by a signal
Date: Fri, 9 Jul 2010 16:03:30 +0000
Message-ID: <AANLkTilrFPb4JLagQdK4QAIwE7zL7KptuY_VhxhKPZBe@mail.gmail.com>
References: <20100709030812.GA16877@dert.cs.uchicago.edu>
	<4C36CA2C.5050305@viscovery.net>
	<iOZX7rvipLDwT5DTYGPE0q9TlJfav09nJWqaRsyiefjNds9DpaDw1A@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Jul 09 18:03:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXG3F-0007oV-Qe
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 18:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757831Ab0GIQDe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Jul 2010 12:03:34 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45661 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757803Ab0GIQDd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jul 2010 12:03:33 -0400
Received: by iwn7 with SMTP id 7so2335386iwn.19
        for <git@vger.kernel.org>; Fri, 09 Jul 2010 09:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=826bdv1dzSoa8DJuI7IirBuRn7v7EkoEytVFgIBVZWo=;
        b=l7TEbx1b0gDpHGwoybju9x0Yt/EGKmVg4EjqjsORXGS0VwCWLprCXVR+5OOD/jjl48
         Tp2gGBA8tHdFdGfmz7Um8MBeAdBNwkgvSDsjBn5GfUfJFacEeiTIqzRNBDJe/6Hkhn4T
         GH70l4v/ChlwZF/2B67NjRZmLMwLslKhEcP18=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=K/D5Ze4js+hjSr8RP+cAFFhmfvYNCksMxnWx/Kc1kParB+cDDSgSKSN05a7f3W7YDZ
         i4OckUKQ2ehEFTNkXqT+Gkif3dXi/mKQCvKgE8izgteR23AyyltOYV43YODgK4y/g3FV
         2u4kHzvxx/ZCM+sEc/cFGe6SBm2JsKuKoEekY=
Received: by 10.231.176.215 with SMTP id bf23mr9754652ibb.96.1278691410054; 
	Fri, 09 Jul 2010 09:03:30 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Fri, 9 Jul 2010 09:03:30 -0700 (PDT)
In-Reply-To: <iOZX7rvipLDwT5DTYGPE0q9TlJfav09nJWqaRsyiefjNds9DpaDw1A@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150676>

On Fri, Jul 9, 2010 at 15:45, Brandon Casey
<brandon.casey.ctr@nrlssc.navy.mil> wrote:
> the exit status is 128+signum. =C2=A0The Public domain Korn shell, an=
d
> ksh on IRIX 6.5, Solaris 7, 9, and 10 all exit with the standard
> behavior of 128+signum. =C2=A0So, it may be appropriate to change the
> commit message and comment in t0005 to reflect this fact.

s/standard/conventional/, no?
