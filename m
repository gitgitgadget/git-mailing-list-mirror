From: Rustom Mody <rustompmody@gmail.com>
Subject: detached head in git.el (was git in emacs)
Date: Mon, 6 Jul 2009 15:19:37 +0530
Message-ID: <f46c52560907060249v19b9c55g4495d9764df70bc8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alexandre Julliard <julliard@winehq.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 11:49:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNkpW-0003Pi-1y
	for gcvg-git-2@gmane.org; Mon, 06 Jul 2009 11:49:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077AbZGFJte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2009 05:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752845AbZGFJtd
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 05:49:33 -0400
Received: from mail-px0-f190.google.com ([209.85.216.190]:35130 "EHLO
	mail-px0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415AbZGFJtd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2009 05:49:33 -0400
Received: by pxi28 with SMTP id 28so3443841pxi.33
        for <git@vger.kernel.org>; Mon, 06 Jul 2009 02:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=u/HLgkMjKpny3kM4klDwcGK0+EzrAeI7xArwic5RFEs=;
        b=U13xhy5s65Pf+uXiy63jLYyO9vInZtCfGcKYdWpjQwp7jRUTy4N+PkuVATTAZ+v72r
         qf8hOBFsCwkjsC7w76Glzp3mM8q5t7g5VX1FHZtQ6cSgqtXggmTZVo0y9sTz8+vlSNk4
         vDw6vnX7NBa6krLFgR+xA7Ykrps70Qg12r7rE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=MAGFUxMnOZqcNxCBVrD5tgNR/xZAM/ieUoUMawHWH40ckF+TT7T5cZHYA6IzO3ehbj
         wL8kFStMJTSnQ2V+mIrdZXyuMyP7LDmBs/R/jtPdO0C1k5FlrLSyrdlgenQ1TD/pfms8
         k+7awRUeSBEawv0TAqnoYV1EWKjnQfL5iKr4k=
Received: by 10.115.106.14 with SMTP id i14mr7270987wam.77.1246873777034; Mon, 
	06 Jul 2009 02:49:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122780>

I figured out that the message
Branch:     fatal: ref HEAD is not a symbolic ref

comes with a detached head on Windows

On linux I get the (detached head) message

On Tue, Jun 30, 2009 at 1:20 AM, Alexandre Julliard<julliard@winehq.org> wrote:
> Rustom Mody <rustompmody@gmail.com> writes:
>
>> On Thu, Jun 25, 2009 at 6:29 PM, Jakub Narebski<jnareb@gmail.com> wrote:
>>> This probably means that git.el (which version do you use) should
>>> be corrected.
>>
>> Ok So I had an old version
>> Now its version 1.0
>> But I still get the same error :-(
>
> The version number isn't helpful I'm afraid, they are all called 1.0...
>
> You probably still have an old version, detached head support was added
> quite some time ago. You can get the latest version from the git source
> tree.
>
> --
> Alexandre Julliard
> julliard@winehq.org
>
