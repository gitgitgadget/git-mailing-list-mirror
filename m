From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: problem cloning via http since v1.6.6-rc0
Date: Thu, 21 Jan 2010 09:34:55 +0800
Message-ID: <be6fef0d1001201734s45ef83fcy32e07f8c213cbe2@mail.gmail.com>
References: <20100121004756.GA18213@onerussian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Yaroslav Halchenko <debian@onerussian.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 02:35:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXlwv-0002Fa-BB
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 02:35:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753438Ab0AUBe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 20:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752203Ab0AUBe4
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 20:34:56 -0500
Received: from mail-iw0-f196.google.com ([209.85.223.196]:40628 "EHLO
	mail-iw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336Ab0AUBez (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 20:34:55 -0500
Received: by iwn34 with SMTP id 34so4225349iwn.21
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 17:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=yg3X7NfHvEjuuQBDPSP1QJfFooa2dl6N1wNByJ7h384=;
        b=GE+7kTvuMduZYKuoTrV6+3/RnBkd9Rq/69/D5/FH+a+XyEfNe4vpL9JIiD4SMRS7jf
         D4Fywg4ufYAWQBso8Q3sexO1MJEgTaByzkkfyBk1yH62bvzzLh89IT7hzBON096QgXMT
         42MqDeC+4EIkKS19buUVqi6ZTr1knm/5ocqmw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=C/lRnJImZZlCAtTvc3ycr0b6g1bv78il8YRVuogu/2KTw9lky1Q+Zu1a9qOK/8iynJ
         awxAOiJqNGaQvUvXyiMpE0emqu/ArZDjUezYL/40R7ToRLYbrzDTufkMCBg4UpfiAxdY
         zZx9wo0ohNDjUdszbVi64RN//GWhu27VZSqSM=
Received: by 10.231.170.14 with SMTP id b14mr1306274ibz.26.1264037695110; Wed, 
	20 Jan 2010 17:34:55 -0800 (PST)
In-Reply-To: <20100121004756.GA18213@onerussian.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137611>

Hi,

On Thu, Jan 21, 2010 at 8:47 AM, Yaroslav Halchenko
<debian@onerussian.com> wrote:
> Cloning of the repository works fine with v1.6.5.7 but fails with v1.6.6-rc0.

this sounds like around the time the smart http protocol was introduced.

> fatal: http://git.debian.org/git/pkg-exppsy/pymvpa.git/info/refs?service=git-upload-pack not found: did you run git update-server-info on the server?
>
> on the server, 1.6.3.3 version of git was used to run git
> update-server-info.

hmm, are you using the WebDAV-flavour or the smart http protocol to
host the repository?

-- 
Cheers,
Ray Chuan
