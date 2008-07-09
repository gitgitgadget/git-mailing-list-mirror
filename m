From: "Stephen Sinclair" <radarsat1@gmail.com>
Subject: Re: git over rsync+ssh
Date: Wed, 9 Jul 2008 16:33:16 -0400
Message-ID: <9b3e2dc20807091333l38260b88na89939bdde09508e@mail.gmail.com>
References: <g52gbg$si9$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Michael J Gruber" <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Wed Jul 09 22:34:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGgMh-0005yR-9m
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 22:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943AbYGIUdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 16:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752168AbYGIUdR
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 16:33:17 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:25849 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbYGIUdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 16:33:16 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3699232rvb.1
        for <git@vger.kernel.org>; Wed, 09 Jul 2008 13:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=GRMY9MkiSZGSrfi0rFnsZOXZ+4efpJsXPO7W1ZfZ98s=;
        b=A6xB6wmgZrLeU87qI6V4+Drm/iPb7b5R2zV/y08Qt5ov/NrTsL9kQynpUD9yxAGEvi
         ykHVCe4CJi7sX66LzRHZTTzItUEfF3Kz+aFeC4VlHxqgaJ2UHz3X2DBr/LH37cq/LnMr
         854vQMVvbH6BXAscMFeQ4JqOCN6X7fXA5/7os=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=VMChlvSD3J2eorJL7Dgky6sXZ8PBJ7dzsAhZgHaPSCInX3XpxG1fM1WrUTDQEM2ilx
         YPMExLXqwWz6zKjZN41dR9z9x6wq4plh1buSatS7ZwPUjHEQGfP9Q5Sn5om08m2m9KWz
         IwsET+WqVh12A/9K3pl7oWjy68CkjGgk/xE2Q=
Received: by 10.141.180.5 with SMTP id h5mr4264205rvp.240.1215635596168;
        Wed, 09 Jul 2008 13:33:16 -0700 (PDT)
Received: by 10.140.166.19 with HTTP; Wed, 9 Jul 2008 13:33:16 -0700 (PDT)
In-Reply-To: <g52gbg$si9$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87909>

On Wed, Jul 9, 2008 at 10:01 AM, Michael J Gruber
<michaeljgruber+gmane@fastmail.fm> wrote:
> I want to put a git repo on a server where I have ssh access but failed to
> compile git (AIX 5.1, has libz.a but no .so nor headers; compiling
> prerequisite zlib failed, probably due to a botched build environment).
>
> As far as I can see my only option for a private repo is using rsync over
> ssh.

Have you tried sshfs?
It allows you to mount an ssh-accessible file system onto your local
file system.
This might make it possible to use your local git to access the remote account.
Not sure of the implications for data integrity...


Steve
