From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCHv5 08/17] gitweb: Add optional output caching
Date: Wed, 6 Oct 2010 22:46:27 +0000
Message-ID: <AANLkTi=RFu5PzBfbF0qVjFnSHnf5GGedkgqKAA4v4nVG@mail.gmail.com>
References: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
	<1286402526-13143-9-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 00:46:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3cks-0006jk-PQ
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 00:46:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759970Ab0JFWq3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Oct 2010 18:46:29 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52135 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759416Ab0JFWq2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Oct 2010 18:46:28 -0400
Received: by iwn5 with SMTP id 5so105128iwn.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 15:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qYbHJa/wgxjP1Wm5eV714afUitTYHhqwiyNlSX0oH84=;
        b=M5vY4bRQENrIGC7ptLEdEUDrHUMAp10SUoQiGtwiubLHZ0F5D5lYLBDIHfWmq6QkxE
         6rQyCa96YJxjizbztXkNkufB2wMr4I0F7oCIToKFfog6gqhFfgzIhSJ+InQu7D981JYy
         mhJOT4axEtOaNA3VBGnVcl9UOVcecAWJs7Gh0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HUNfhIkS/freUS7OMqtKT4DBxZRujamBhJUIIeJyE9YyH1P4czmpRcc/6sbKNNn+XX
         mC4L2UQIp9A1qOMXYEjOXv3DN+ovSbNJmNtNOMizZ5Mk9aEJsvOdHwATIhJ5e3kVdqP2
         s2/zlfmtivQ1Zx9kE79ahByKQXt0upE9XsSkg=
Received: by 10.231.11.71 with SMTP id s7mr11385262ibs.85.1286405187731; Wed,
 06 Oct 2010 15:46:27 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Wed, 6 Oct 2010 15:46:27 -0700 (PDT)
In-Reply-To: <1286402526-13143-9-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158336>

On Wed, Oct 6, 2010 at 22:01, Jakub Narebski <jnareb@gmail.com> wrote:

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $cache ||=3D 'Gitw=
ebCache::SimpleFileCache';
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eval "require $cac=
he";

Just:

    eval { require $cache };

Instead?
