From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: large files and low memory
Date: Tue, 05 Oct 2010 10:01:05 +0200
Message-ID: <vpqpqvpf4qm.fsf@bauges.imag.fr>
References: <20101004092046.GA4382@nibiru.local>
	<AANLkTimbdrAqoWMxiteT5zNYmwHp8M698BEv1FLuiAxx@mail.gmail.com>
	<4CAA1BEB.3050908@workspacewhiz.com>
	<AANLkTi=nzyRgiBL07f2oeyjdUc8XnaKbJEJ+k8_g9rQ1@mail.gmail.com>
	<20101005005902.GC2768@nibiru.local>
	<20101005074144.GA22564@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 05 10:01:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P32SZ-0006mA-RI
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 10:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757851Ab0JEIBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 04:01:11 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36038 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757814Ab0JEIBK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 04:01:10 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o957tlWm021856
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 5 Oct 2010 09:55:47 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1P32SQ-0006bf-0S; Tue, 05 Oct 2010 10:01:06 +0200
In-Reply-To: <20101005074144.GA22564@nibiru.local> (Enrico Weigelt's message of "Tue\, 5 Oct 2010 09\:41\:45 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 05 Oct 2010 09:55:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o957tlWm021856
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1286870150.63303@csuErzuTraUSb4kxJOUXeg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158176>

Enrico Weigelt <weigelt@metux.de> writes:

> * Enrico Weigelt <weigelt@metux.de> wrote:
>
> <snip>
>
> Found another possible bottleneck: git-commit seems to scan through
> a lot of files. Shouldnt it just create a commit object from the
> current index and update the head ?

git commit will show what's being commited (the output of "git commit
--dry-run") in your editor, hence it needs to compute that.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
